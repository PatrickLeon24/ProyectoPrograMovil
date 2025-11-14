# controllers/editarusuario_controller.rb
require 'sinatra/base'
require 'json'
require_relative '../config/database'
require_relative '../models/user'
require_relative 'application_controller'

class EditUserController < ApplicationController
  # Endpoint para ACTUALIZAR el username de un usuario
  #
  # Ejemplo de llamada (Postman):
  #   PUT /api/v2/users/1/username
  #   Body (JSON):
  #   {
  #     "username": "NuevoNickname123"
  #   }
  #
  put '/api/v2/users/username' do
    content_type :json

    begin
      user_id = @current_user['user_id']

      # Leer y parsear el body
      request_body = JSON.parse(request.body.read) rescue nil
      new_username = request_body && request_body['username']

      # Validar campo requerido
      if new_username.nil? || new_username.strip.empty?
        status 400
        return {
          success: false,
          message: "Falta el campo username",
          data: nil,
          error: "username es obligatorio"
        }.to_json
      end

      # Buscar el usuario por ID
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

      # Verificar que el nuevo username no esté ya en uso por OTRO usuario
      existing_user = User.first(username: new_username)
      if existing_user && existing_user.id != user.id
        status 409
        return {
          success: false,
          message: "El nombre de usuario ya está en uso",
          data: nil,
          error: "Duplicado"
        }.to_json
      end

      # Actualizar el username
      user.update(username: new_username)

      # Respuesta final
      status 200
      {
        success: true,
        message: "Nombre de usuario actualizado correctamente",
        data: {
          user: {
            id: user.id,
            name: user.name,
            last_name: user.last_name,
            username: user.username,
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
          }
        },
        error: nil
      }.to_json

    rescue => e
      puts e.backtrace.join("\n")
      status 500
      {
        success: false,
        message: "Error interno al actualizar el usuario",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
