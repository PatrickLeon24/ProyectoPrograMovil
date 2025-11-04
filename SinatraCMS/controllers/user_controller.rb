require 'sinatra/base'
require_relative '../config/database'

class UserController < ApplicationController

  # Ruta principal de prueba (opcional)
  get '/users' do
    erb :users  # si más adelante quieres crear una vista users.erb
  end

  # Endpoint API para obtener todos los usuarios
  get '/api/v1/users' do
    content_type :json

    begin
      users = User.all  # obtiene todos los registros de la tabla users

      users_data = users.map do |user|
        {
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
          last_login: user.last_login
        }
      end

      {
        success: true,
        message: "Listado de usuarios",
        data: users_data,
        error: nil
      }.to_json

    rescue => e
      status 500
      {
        success: false,
        message: "Error al obtener los usuarios",
        data: [],
        error: e.message
      }.to_json
    end
  end
end
