require 'sinatra/base'
require_relative '../config/database'
require_relative '../models/user'

class SessionController < ApplicationController
  post '/api/v2/sign-in' do
    content_type :json

    begin
      # Parsear body
      request_body = JSON.parse(request.body.read) rescue nil
      username = request_body['username']
      password = request_body['password']

      # Validación de campos
      if username.nil? || password.nil?
        status 400
        return {
          success: false,
          message: "Faltan credenciales",
          data: nil,
          error: "Se requiere username y password"
        }.to_json
      end

      # Buscar usuario
      user = User.first(username: username)

      unless user
        status 404
        return {
          success: false,
          message: "Usuario y/o contraseña incorrectos",
          data: nil,
          error: "No se encontró el usuario"
        }.to_json
      end

      # Verificar contraseña (simple; reemplaza con bcrypt si usas hashes)
      unless user.password_hash == password
        status 401
        return {
          success: false,
          message: "Usuario y/o contraseña incorrectos",
          data: nil,
          error: "Credenciales inválidas"
        }.to_json
      end

      # Generar tokens JWT
      waveul_token = generate_token({
        user_id: user.id,
        username: user.username,
        type: 'waveul'
      })

      files_token = generate_token({
        user_id: user.id,
        username: user.username,
        type: 'files'
      })

      # Actualizar last_login
      user.update(last_login: Time.now)

      # Respuesta final
      status 200
      {
        success: true,
        message: "Inicio de sesión correcto",
        data: {
          user: {
            id: user.id,
            name: user.name,
            last_name: user.last_name,
            username: user.username,
            password_hash: user.password_hash, # quita si no quieres mandarlo
            email: user.email,
            profile_image: user.profile_image,
            birth_date: user.birth_date,
            phone: user.phone,
            created_at: user.created_at,
            is_verified: user.is_verified == 1 || user.is_verified == true,
            last_login: user.last_login,
            verification_token: user.verification_token,
            reset_token: user.reset_token,
            reset_token_expires: user.reset_token_expires
          },
          tokens: {
            waveul: waveul_token,
            files: files_token
          }
        },
        error: nil
      }.to_json

    rescue => e
      puts e.backtrace.join("\n")
      status 500
      {
        success: false,
        message: "Error interno al procesar el inicio de sesión",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
