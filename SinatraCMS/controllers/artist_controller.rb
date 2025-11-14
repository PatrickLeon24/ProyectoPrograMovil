require 'sinatra/base'
require_relative '../config/database'

class ArtistController < ApplicationController  
    #este primer get es para tener todos los artistas con sus atributos
    get '/api/artists' do
      content_type :json
      begin
        {
          success: true,
          message: "Listado de artistas",
          data: Artist.all,          
          error: nil
        }.to_json
      rescue => e
        puts e.backtrace.join("\n")
        status 500  
        {
          success: false,
          message: "Error al obtener los artistas",
          data: [],
          error: e.message
        }.to_json
      end
    end  

    #Ahora si quiero buscar a uno o mas artistas con la barra de busqueda
    get '/api/artists/search' do
      content_type :json
      query = params[:q]
      
      begin      
        artists = Artist.where(Sequel.ilike(:stage_name, "%#{query}%")).all
        
        if artists.empty?       
          {
            success: false,
            message: "No se encontraron artistas en la busqueda con el nombre: #{query}",
            data: [],
            error: nil
          }.to_json
        else       
          {
            success: true,
            message: "Artistas encontrados",
            data: artists.map { |artist| artist.values },
            error: nil
          }.to_json
        end
      rescue => e     
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error al buscar los artistas",
          data: [],
          error: e.message
        }.to_json
      end
    end
    
    #Ahora aqui cuando necesite un solo artista en la vista de musica debo filtrarlo por el id
    get '/api/artists/:id' do
      content_type :json
      id = params[:id]      
      begin          
          artist = Artist[id]
          if artist             
              {
                  success: true,
                  message: "Artista encontrado",
                  data: artist.values,
                  error: nil
              }.to_json
          else
              status 404
              {
                  success: false,
                  message: "Artista no encontrado",
                  data: nil,
                  error: "No se encontró el artista con ID: #{id}"
              }.to_json
          end          
      rescue => e
          puts e.backtrace.join("\n")
          status 500 
          {
              success: false,
              message: "Error al buscar el artista",
              data: nil,
              error: e.message
          }.to_json
      end
  end
  # Seguir a un artista
  post '/api/artists/:id/follow' do
    content_type :json
    user_id = params[:user_id]
    artist_id = params[:id]
  
    begin   
      rel = UserFollowArtist.where(user_id: user_id, artist_id: artist_id).first
      
      if rel
        status 409
        return {
          success: false,
          message: "Ya sigues a este artista",
          data: { followed: true },
          error: nil
        }.to_json
      end
  
      # Crear follow
      UserFollowArtist.create(
        user_id: user_id,
        artist_id: artist_id,
        created_at: Time.now
      )
  
      {
        success: true,
        message: "Ahora sigues a este artista",
        data: { followed: true },
        error: nil
      }.to_json
  
    rescue => e
      status 500
      { success: false, message: "Error al seguir artista", error: e.message }.to_json
    end
  end



  # Dejar de seguir a un artista
  delete '/api/artists/:id/follow' do
    content_type :json
    user_id = params[:user_id]
    artist_id = params[:id]
  
    begin
      rel = UserFollowArtist.where(user_id: user_id, artist_id: artist_id).first
  
      unless rel
        status 404
        return {
          success: false,
          message: "No sigues a este artista",
          data: { followed: false },
          error: nil
        }.to_json
      end
  
      rel.delete
  
      {
        success: true,
        message: "Has dejado de seguir a este artista",
        data: { followed: false },
        error: nil
      }.to_json
  
    rescue => e
      status 500
      { success: false, message: "Error al dejar de seguir artista", error: e.message }.to_json
    end
  end

end
