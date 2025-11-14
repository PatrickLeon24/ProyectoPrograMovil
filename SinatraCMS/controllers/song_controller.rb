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
end
