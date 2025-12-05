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

  # Buscar usuarios
  get '/api/users/search' do
    content_type :json
    query = params[:q]

    begin
      users = User.where(
        Sequel.ilike(:username, "%#{query}%") |
        Sequel.ilike(:name, "%#{query}%") |
        Sequel.ilike(:last_name, "%#{query}%")
      ).all

      {
        success: true,
        message: "Usuarios encontrados",
        data: users.map(&:values),
        error: nil
      }.to_json
    rescue => e
      status 500
      {
        success: false,
        message: "Error al buscar usuarios",
        data: [],
        error: e.message
      }.to_json
    end
  end

  # Seguir a un usuario
  post '/api/users/:id/follow' do
    content_type :json
    user_id     = @current_user['user_id']    # el que sigue
    followed_id = params[:id]                 # al que siguen

    begin
      rel = UserFollowUser.where(user_id: user_id, followed_id: followed_id).first

      if rel
        status 409
        return {
          success: false,
          message: "Ya sigues a este usuario",
          data: { followed: true },
          error: nil
        }.to_json
      end

      UserFollowUser.create(
        user_id: user_id,
        followed_id: followed_id,
        created_at: Time.now
      )

      {
        success: true,
        message: "Ahora sigues a este usuario",
        data: { followed: true },
        error: nil
      }.to_json
    rescue => e
      status 500
      {
        success: false,
        message: "Error al seguir usuario",
        data: nil,
        error: e.message
      }.to_json
    end
  end

  # Dejar de seguir
  delete '/api/users/:id/follow' do
    content_type :json
    user_id     = @current_user['user_id']
    followed_id = params[:id]

    begin
      rel = UserFollowUser.where(user_id: user_id, followed_id: followed_id).first

      unless rel
        status 404
        return {
          success: false,
          message: "No sigues a este usuario",
          data: { followed: false },
          error: nil
        }.to_json
      end

      rel.delete

      {
        success: true,
        message: "Has dejado de seguir a este usuario",
        data: { followed: false },
        error: nil
      }.to_json
    rescue => e
      status 500
      {
        success: false,
        message: "Error al dejar de seguir usuario",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
