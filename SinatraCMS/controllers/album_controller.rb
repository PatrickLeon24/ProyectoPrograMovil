require 'sinatra/base'
require_relative '../config/database'

class AlbumController < ApplicationController  
    #este primer get es para tener todos las albums con sus atributos
    get '/api/albums' do
      begin
        albums = Album.all.map do |album|
          {
            id: album.id,
            name: album.name,
            cover_image: album.cover_image,
            release_date: album.release_date,
            created_at: album.created_at,
            artist_name: album.artist.stage_name,
            artist_image: album.artist.profile_image
          }        
        end

        {
          success: true,
          message: "Listado de álbumes",
          data: albums,
          error: nil
        }.to_json
    
      rescue => e
        status 500
        { success: false, message: "Error", data: [], error: e.message }.to_json
      end
    end  

    #Ahora si quiero buscar a uno o mas albums con la barra de busqueda
    get '/api/albums/search' do
      content_type :json
      query = params[:q]
  
      begin 
        albums = Album.where(Sequel.ilike(:name, "%#{query}%")).all
  
        if albums.empty?
          {
            success: false,
            message: "No se encontraron álbumes con el nombre: #{query}",
            data: [],
            error: nil
          }.to_json
        else
          data = albums.map do |album|
            {
              id: album.id,
              name: album.name,
              cover_image: album.cover_image,
              release_date: album.release_date,
              created_at: album.created_at,
              artist_name: album.artist&.stage_name,
              artist_image: album.artist.profile_image
            } 
          end

          {
            success: true,
            message: "Álbumes encontrados",
            data: data,
            error: nil
          }.to_json
        end  
      rescue => e
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error al buscar los álbumes",
          data: [],
          error: e.message
        }.to_json      
    end
  end
    #Ahora aqui cuando necesite una cancion en la vista de musica debo filtrarlo por el id
  get '/api/albums/:id' do
  content_type :json
  id = params[:id]
  
    begin
      album = Album[id]
  
          if album
          data = {
            id: album.id,
            name: album.name,
            cover_image: album.cover_image,
            release_date: album.release_date,
            created_at: album.created_at,
            artist_name: album.artist&.stage_name,
            artist_image: album.artist.profile_image            
          }        

          {
            success: true,
            message: "Álbum encontrado",
            data: data,
            error: nil
          }.to_json
        else
          status 404
          {
            success: false,
            message: "Album no encontrado",
            data: nil,
            error: "No se encontro el álbum con ID: #{id}"
          }.to_json
        end
      rescue => e
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error al buscar el álbum",
          data: nil,
          error: e.message
        }.to_json
      end
  end
end
