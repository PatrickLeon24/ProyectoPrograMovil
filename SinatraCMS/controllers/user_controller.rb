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

  #DYLANN-----------------------

  # ===============================
  # FAVORITOS E HISTORIAL (VERSIÓN SIMPLIFICADA)
  # ===============================
  
  # Obtener favoritos del usuario actual
  get '/api/users/favorites' do
    content_type :json
    user_id = @current_user['user_id']
    
    begin
      # Consulta solo datos básicos de user_song
      favorites = DB[:user_song]
        .where(user_id: user_id, favorite: true)
        .all
      
      status 200
      {
        success: true,
        message: "Favoritos obtenidos exitosamente",
        data: {
          user_id: user_id,
          total_favorites: favorites.length,
          favorites: favorites
        }
      }.to_json
      
    rescue => e
      status 500
      {
        success: false,
        message: "Error interno del servidor",
        data: nil,
        error: e.message
      }.to_json
    end
  end

  # Obtener estadísticas del usuario actual
  get '/api/users/stats' do
    content_type :json
    user_id = @current_user['user_id']
    
    begin
      # Contar favoritos
      total_favorites = DB[:user_song].where(user_id: user_id, favorite: true).count
      
      # Sumar reproducciones totales
      total_plays = DB[:user_song].where(user_id: user_id).sum(:play_count) || 0
      
      # Canciones reproducidas
      songs_played = DB[:user_song].where(user_id: user_id).where { play_count > 0 }.count
      
      status 200
      {
        success: true,
        message: "Estadísticas obtenidas exitosamente",
        data: {
          user_id: user_id,
          total_favorites: total_favorites,
          total_plays: total_plays,
          songs_played: songs_played
        }
      }.to_json
      
    rescue => e
      status 500
      {
        success: false,
        message: "Error interno del servidor",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
