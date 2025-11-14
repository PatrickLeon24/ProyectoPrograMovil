require 'sinatra/base'
require_relative '../config/database'

class GenreController < ApplicationController  
    get '/api/v2/genres' do
      content_type :json

      genre = Genre.all
      puts genre.inspect 
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
end
