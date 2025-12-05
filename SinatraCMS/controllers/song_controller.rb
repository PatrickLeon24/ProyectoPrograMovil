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
      # Ver si ya existe el like
      rel = UserSong.where(user_id: user_id, song_id: song_id).first

      if rel
        status 409
        return {
          success: false,
          message: "Ya marcaste esta canción como que te gusta",
          data: { liked: true },
          error: nil
        }.to_json
      end

      # Crear relación user_song
      UserSong.create(
        user_id: user_id,
        song_id: song_id,
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

      rel.delete

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
end
