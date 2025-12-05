require 'sinatra/base'
require_relative '../config/database'

class SongController < ApplicationController  
    #este primer get es para tener todos las canciones con sus atributos
    get '/api/songs' do
      content_type :json
      begin
        {
          success: true,
          message: "Listado de canciones",
          data: Song.all,          
          error: nil
        }.to_json
      rescue => e
        puts e.backtrace.join("\n")
        status 500  
        {
          success: false,
          message: "Error al obtener las canciones",
          data: [],
          error: e.message
        }.to_json
      end
    end  

    #Ahora si quiero buscar a uno o mas canciones con la barra de busqueda
    get '/api/songs/search' do
      content_type :json
      query = params[:q]
      
      begin      
        songs = Song.where(Sequel.ilike(:name, "%#{query}%")).all
        
        if songs.empty?       
          {
            success: false,
            message: "No se encontraron canciones en la busqueda con el nombre: #{query}",
            data: [],
            error: nil
          }.to_json
        else       
          {
            success: true,
            message: "Canciones encontradas",
            data: songs.map { |song| song.values },
            error: nil
          }.to_json
        end
      rescue => e     
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error al buscar las canciones",
          data: [],
          error: e.message
        }.to_json
      end
    end
    
    #Ahora aqui cuando necesite una cancion en la vista de musica debo filtrarlo por el id
    get '/api/songs/:id' do
      content_type :json
      id = params[:id]      
      begin          
          song = Song[id]
          if song            
              {
                  success: true,
                  message: "Cancion encontrado",
                  data: song.values,
                  error: nil
              }.to_json
          else
              status 404
              {
                  success: false,
                  message: "Cancion no encontrado",
                  data: nil,
                  error: "No se encontró la cancion con ID: #{id}"
              }.to_json
          end          
      rescue => e
          puts e.backtrace.join("\n")
          status 500 
          {
              success: false,
              message: "Error al buscar la cancion",
              data: nil,
              error: e.message
          }.to_json
      end
  end
  # si el usuario le gusta una cancion
  post '/api/songs/:id/like' do
    content_type :json
    user_id = @current_user['user_id']
    song_id = params[:id]

    begin
      # Ver si ya existe el registro
      rel = UserSong.where(user_id: user_id, song_id: song_id).first

      if rel
        # Si ya existe, verificar si ya está marcado como favorito
        if rel.favorite == 1 || rel.favorite == true
          status 409
          return {
            success: false,
            message: "Ya marcaste esta canción como que te gusta",
            data: { liked: true },
            error: nil
          }.to_json
        else
          # Si existe pero NO es favorito, actualizar a favorito
          DB[:user_song].where(user_id: user_id, song_id: song_id)
                        .update(favorite: true, liked_at: Time.now)
          
          return {
            success: true,
            message: "Canción agregada a tus Me gusta",
            data: { liked: true },
            error: nil
          }.to_json
        end
      end

      # Si no existe el registro, crear uno nuevo
      DB[:user_song].insert(
        user_id: user_id,
        song_id: song_id,
        favorite: true,
        liked_at: Time.now,
        created_at: Time.now
      )

      {
        success: true,
        message: "Canción agregada a tus Me gusta",
        data: { liked: true },
        error: nil
      }.to_json

    rescue => e
      status 500
      {
        success: false,
        message: "Error al marcar la canción como que te gusta",
        data: nil,
        error: e.message
      }.to_json
    end
  end

  # Quitar "me gusta" de una canción
  delete '/api/songs/:id/like' do
    content_type :json
    user_id = @current_user['user_id']
    song_id = params[:id]

    begin
      rel = UserSong.where(user_id: user_id, song_id: song_id).first

      unless rel
        status 404
        return {
          success: false,
          message: "Esta canción no estaba en tus Me gusta",
          data: { liked: false },
          error: nil
        }.to_json
      end

      # Actualizar directamente en la base de datos
      DB[:user_song].where(user_id: user_id, song_id: song_id)
                    .update(favorite: false, liked_at: nil)

      {
        success: true,
        message: "Canción eliminada de tus Me gusta",
        data: { liked: false },
        error: nil
      }.to_json

    rescue => e
      status 500
      {
        success: false,
        message: "Error al quitar la canción de tus Me gusta",
        data: nil,
        error: e.message
      }.to_json
    end
  end

  # Registrar reproducción de canción
  post '/api/songs/:id/play' do
    content_type :json
    user_id = @current_user['user_id']
    song_id = params[:id]

    begin
      # Buscar registro existente
      existing = UserSong.where(user_id: user_id, song_id: song_id).first
      
      if existing
        # Incrementar contador usando SQL directo
        new_count = existing.play_count + 1
        DB[:user_song].where(user_id: user_id, song_id: song_id)
                      .update(play_count: new_count, last_played: Time.now)
        
        status 200
        return {
          success: true,
          message: "Reproducción registrada exitosamente",
          data: { user_id: user_id, song_id: song_id, play_count: new_count }
        }.to_json
      else
        # Crear nuevo registro usando SQL directo
        DB[:user_song].insert(
          user_id: user_id,
          song_id: song_id,
          favorite: false,
          play_count: 1,
          last_played: Time.now,
          created_at: Time.now
        )
        
        status 200
        return {
          success: true,
          message: "Primera reproducción registrada",
          data: { user_id: user_id, song_id: song_id, play_count: 1 }
        }.to_json
      end
      
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
