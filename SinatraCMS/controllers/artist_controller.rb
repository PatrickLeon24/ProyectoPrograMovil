require 'sinatra/base'
require_relative '../config/database'

class ArtistController < ApplicationController

  # 1) Listado de artistas
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

  # 2) Buscar artistas por nombre
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

  # 3) Obtener un artista por ID
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

  # 4) Canciones de un artista (SongArtist + Song)
  get '/api/artists/:id/songs' do
    content_type :json
    artist_id = params[:id]

    begin
      artist = Artist[artist_id]

      unless artist
        status 404
        return {
          success: false,
          message: "Artista no encontrado",
          data: [],
          error: "No se encontró el artista con ID: #{artist_id}"
        }.to_json
      end

      # Tabla asociativa song_artist
      song_ids = SongArtist.where(artist_id: artist_id).select_map(:song_id)

      if song_ids.empty?
        return {
          success: true,
          message: "El artista no tiene canciones asociadas",
          data: [],
          error: nil
        }.to_json
      end

      songs = Song.where(id: song_ids).all

      {
        success: true,
        message: "Canciones del artista",
        data: songs.map(&:values),
        error: nil
      }.to_json

    rescue => e
      puts e.backtrace.join("\n")
      status 500
      {
        success: false,
        message: "Error al obtener las canciones del artista",
        data: [],
        error: e.message
      }.to_json
    end
  end

  # 5) Seguir a un artista
  post '/api/artists/:id/follow' do
    content_type :json
    user_id   = @current_user['user_id']
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
      {
        success: false,
        message: "Error al seguir artista",
        data: nil,
        error: e.message
      }.to_json
    end
  end

  # 6) Dejar de seguir a un artista
  delete '/api/artists/:id/unfollow' do
    content_type :json
    user_id   = @current_user['user_id']
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
      {
        success: false,
        message: "Error al dejar de seguir artista",
        data: nil,
        error: e.message
      }.to_json
    end
  end
end
