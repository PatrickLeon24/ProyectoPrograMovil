# controllers/password_controller.rb
require 'sinatra/base'
require 'json'
require_relative '../config/database'
require_relative '../models/user'
require_relative 'application_controller'

class PasswordController < ApplicationController
  # PUT /api/v2/users/password
  #
  # Body (JSON):
  # {
  #   "current_password": "miClaveActual",
  #   "new_password": "miClaveNueva123"
  # }
  #
  put '/api/v2/users/password' do
    content_type :json

    begin
      # 👤 Usuario autenticado (viene del JWT en ApplicationController)
      user_id = @current_user['user_id']

      # Leer y parsear body
      request_body = JSON.parse(request.body.read) rescue nil
      current_password = request_body && request_body['current_password']
      new_password     = request_body && request_body['new_password']

      # Validar campos
      if current_password.nil? || current_password.strip.empty? ||
         new_password.nil?     || new_password.strip.empty?
        status 400
        return {
          success: false,
          message: "Faltan campos requeridos",
          data: nil,
          error: "current_password y new_password son obligatorios"
        }.to_json
      end

      # Buscar usuario
      user = User[user_id]

      unless user
        status 404
        return {
          success: false,
          message: "Usuario no encontrado",
          data: nil,
          error: "No existe usuario con id #{user_id}"
        }.to_json
      end

      # Verificar contraseña actual (aquí es texto plano, sin bcrypt)
      unless user.password_hash == current_password
        status 401
        return {
          success: false,
          message: "La contraseña actual es incorrecta",
          data: nil,
          error: "CURRENT_PASSWORD_INVALID"
        }.to_json
      end

      # Validar nueva contraseña (ejemplo: mínimo 6 caracteres)
      if new_password.length < 6
        status 400
        return {
          success: false,
          message: "La nueva contraseña debe tener al menos 6 caracteres",
          data: nil,
          error: "NEW_PASSWORD_TOO_SHORT"
        }.to_json
      end

      # Actualizar contraseña
      user.update(password_hash: new_password)

      # Opcional: regenerar tokens por seguridad
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

      status 200
      {
        success: true,
        message: "Contraseña actualizada correctamente",
        data: {
          user: {
            id: user.id,
            name: user.name,
            last_name: user.last_name,
            username: user.username,
            password_hash: user.password_hash, # igual que en sign-in
            email: user.email,
            phone: user.phone,
            birth_date: user.birth_date,
            profile_image: user.profile_image,
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
        message: "Error interno al cambiar la contraseña",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
