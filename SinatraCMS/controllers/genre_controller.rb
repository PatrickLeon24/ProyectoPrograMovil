require 'sinatra/base'
require_relative '../config/database'

class GenreController < ApplicationController  
    #este primer get es para tener todos los generos con sus atributos
    get '/api/genres' do
      content_type :json
      begin
        {
          success: true,
          message: "Listado de generos",
          data: Genre.all,          
          error: nil
        }.to_json
      rescue => e
        puts e.backtrace.join("\n")
        status 500  
        {
          success: false,
          message: "Error al obtener los géneros",
          data: [],
          error: e.message
        }.to_json
      end
    end  

    #Ahora aqui cuando necesite un solo genero en la vista de musica debo filtrarlo por el id
    get '/api/genres/:id' do
      content_type :json
      id = params[:id]
      
      begin          
          genre = Genre[id]
          if genre             
              {
                  success: true,
                  message: "Género encontrado",
                  data: genre.values,
                  error: nil
              }.to_json
          else
              status 404
              {
                  success: false,
                  message: "Género no encontrado",
                  data: nil,
                  error: "No se encontró el género con ID: #{id}"
              }.to_json
          end          
      rescue => e
          puts e.backtrace.join("\n")
          status 500 
          {
              success: false,
              message: "Error al buscar el género",
              data: nil,
              error: e.message
          }.to_json
      end
  end

end
