require 'sinatra/base'
require_relative '../config/database'
require_relative '../models/user'
require 'net/http'
require 'uri'
require 'json'

class PasswordRecoveryRequestController < ApplicationController
  post '/api/v2/password/forgot' do
    content_type :json

    begin
      request_body = JSON.parse(request.body.read) rescue nil
      email = request_body['email']

      # Validación
      if email.nil? || email.strip.empty?
        status 400
        return {
          success: false,
          message: "El email es requerido",
          data: nil,
          error: "email obligatorio"
        }.to_json
      end

      # Buscar usuario
      user = User.first(email: email)
      unless user
        status 404
        return {
          success: false,
          message: "El correo no está registrado",
          data: nil,
          error: "usuario no encontrado"
        }.to_json
      end

      # Generar código
      reset_code = rand(100000..999999).to_s
      expires = Time.now + (10 * 60)

      # Guardar en DB
      user.update(
        reset_token: reset_code,
        reset_token_expires: expires
      )

      # Enviar código al flujo de n8n
      uri = URI("https://patrickleon24012401.app.n8n.cloud/webhook-test/password-recovery")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json' })
      request.body = {
        email: user.email,
        code: reset_code
      }.to_json

      http.request(request)

      # Respuesta
      status 200
      {
        success: true,
        message: "Se envió un código a tu correo",
        data: nil,
        error: nil
      }.to_json

    rescue => e
      puts e.backtrace.join("\n")
      status 500
      {
        success: false,
        message: "Error interno al enviar el código",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
