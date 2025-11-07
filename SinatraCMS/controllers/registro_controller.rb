require 'sinatra/base'
require_relative '../config/database'
require_relative '../models/user'

class RegistrationController < ApplicationController
  post '/api/v2/sign-up' do
    content_type :json

    begin
      # Parsear body
      request_body = JSON.parse(request.body.read) rescue nil
      name = request_body['name']
      last_name = request_body['last_name']
      username = request_body['username']
      password = request_body['password']
      email = request_body['email']
      phone = request_body['phone']
      birth_date = request_body['birth_date']
      profile_image = request_body['profile_image']

      # Validar campos requeridos
      if [name, last_name, username, password, email].any? { |f| f.nil? || f.strip.empty? }
        status 400
        return {
          success: false,
          message: "Faltan campos requeridos",
          data: nil,
          error: "name, last_name, username, password, email son obligatorios"
        }.to_json
      end

      # Verificar si el username o email ya existen
      existing_user = User.first(Sequel.|({ username: username }, { email: email }))
      if existing_user
        status 409
        return {
          success: false,
          message: "El usuario o correo ya están registrados",
          data: nil,
          error: "Duplicado"
        }.to_json
      end

      # Crear usuario nuevo
      user = User.create(
        name: name,
        last_name: last_name,
        username: username,
        password_hash: password, # simple, sin hashing
        email: email,
        phone: phone,
        birth_date: birth_date,
        profile_image: profile_image || "https://cdn.waveul.com/default_avatar.png",
        created_at: Time.now,
        is_verified: false,
        verification_token: nil,
        reset_token: nil,
        reset_token_expires: nil,
        last_login: nil
      )

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

      # Respuesta final
      status 201
      {
        success: true,
        message: "Registro exitoso",
        data: {
          user: {
            id: user.id,
            name: user.name,
            last_name: user.last_name,
            username: user.username,
            password_hash: user.password_hash,
            email: user.email,
            profile_image: user.profile_image,
            birth_date: user.birth_date,
            phone: user.phone,
            created_at: user.created_at,
            is_verified: user.is_verified,
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
        message: "Error interno al registrar el usuario",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
