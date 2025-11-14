require 'sinatra/base'
require_relative '../config/database'

class PlaylistController < ApplicationController  
    #este primer get es para tener todos las playlists con sus atributos
    get '/api/playlists' do
      content_type :json
      begin
        {
          success: true,
          message: "Listado de playlists",
          data: Playlist.all,          
          error: nil
        }.to_json
      rescue => e
        puts e.backtrace.join("\n")
        status 500  
        {
          success: false,
          message: "Error al obtener las playlists",
          data: [],
          error: e.message
        }.to_json
      end
    end  

    #Ahora si quiero buscar a uno o mas playlists con la barra de busqueda
    get '/api/playlists/search' do
      content_type :json
      query = params[:q]
      
      begin      
        playlists = Playlist.where(Sequel.ilike(:name, "%#{query}%")).all
        
        if playlists.empty?       
          {
            success: false,
            message: "No se encontraron playlists en la busqueda con el nombre: #{query}",
            data: [],
            error: nil
          }.to_json
        else       
          {
            success: true,
            message: "playlists encontradas",
            data: playlists.map { |playlist| playlist.values },
            error: nil
          }.to_json
        end
      rescue => e     
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error al buscar las playlists",
          data: [],
          error: e.message
        }.to_json
      end
    end
    
    #Ahora aqui cuando necesite una cancion en la vista de musica debo filtrarlo por el id
    get '/api/playlists/:id' do
      content_type :json
      id = params[:id]      
      begin          
          playlist = Playlist[id]
          if playlist            
              {
                  success: true,
                  message: "Cancion encontrado",
                  data: playlist.values,
                  error: nil
              }.to_json
          else
              status 404
              {
                  success: false,
                  message: "Playlist no encontrada",
                  data: nil,
                  error: "No se encontró la playlist con ID: #{id}"
              }.to_json
          end          
      rescue => e
          puts e.backtrace.join("\n")
          status 500 
          {
              success: false,
              message: "Error al buscar la playlist",
              data: nil,
              error: e.message
          }.to_json
      end
  end
end
