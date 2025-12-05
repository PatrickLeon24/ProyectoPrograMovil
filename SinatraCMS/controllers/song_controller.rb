require 'sinatra/base'
require_relative '../config/database'
require_relative '../services/audio_service'

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

  # ===============================
  # 🎵 ENDPOINTS S3 INTEGRATION
  # ===============================
  
  # Subir nueva canción con audio y cover
  post '/api/songs/upload' do
    content_type :json
    user_id = @current_user['user_id']
    
    begin
      # Obtener archivos del request
      audio_file = params[:audio_file]
      cover_file = params[:cover_file]  # Opcional
      
      # Metadatos de la canción
      title = params[:title]
      artist_id = params[:artist_id] 
      album_id = params[:album_id]    # Opcional
      duration = params[:duration]    # En segundos
      
      # Validaciones básicas
      halt 400, {error: "Título requerido"}.to_json unless title&.strip&.length&.> 0
      halt 400, {error: "Audio requerido"}.to_json unless audio_file
      halt 400, {error: "Artist ID requerido"}.to_json unless artist_id
      
      # Subir audio a S3
      audio_result = AudioService.upload_song(audio_file, SecureRandom.hex(8))
      if audio_result[:error]
        halt 400, {error: audio_result[:error]}.to_json
      end
      
      # Subir cover si existe
      cover_s3_key = nil
      if cover_file
        cover_result = AudioService.upload_song_cover(cover_file, SecureRandom.hex(6))
        if cover_result[:error]
          # Si falla el cover, eliminar audio ya subido
          AudioService.delete_file(audio_result[:s3_key])
          halt 400, {error: cover_result[:error]}.to_json
        end
        cover_s3_key = cover_result[:s3_key]
      end
      
      # Crear registro en base de datos usando SQL directo
      song_data = {
        name: title,
        duration: duration || 0,
        file_url: '',  # Campo obligatorio - vacío por ahora (usamos S3)
        s3_audio_key: audio_result[:s3_key],
        s3_cover_key: cover_s3_key,
        file_size: audio_result[:file_size],
        audio_format: audio_result[:audio_format],
        bitrate: params[:bitrate] || 128,
        release_date: params[:release_date] || Date.today,
        play_count_global: 0,
        created_at: Time.now
      }
      
      # Agregar album_id solo si se proporciona
      song_data[:album_id] = album_id if album_id
      
      # Insertar en la base de datos
      song_id = DB[:songs].insert(song_data)
      
      # Crear relación song-artist si no existe
      unless DB[:song_artist].where(song_id: song_id, artist_id: artist_id).first
        DB[:song_artist].insert(song_id: song_id, artist_id: artist_id)
      end
      
      status 201
      {
        success: true,
        message: "Canción subida exitosamente",
        data: {
          id: song_id,
          title: title,
          s3_audio_key: audio_result[:s3_key],
          s3_cover_key: cover_s3_key,
          file_size: audio_result[:file_size],
          audio_format: audio_result[:audio_format],
          duration: duration || 0
        }
      }.to_json
      
    rescue => e
      status 500
      {
        success: false,
        message: "Error al procesar upload",
        error: e.message
      }.to_json
    end
  end
  
  # Obtener URL de streaming para una canción
  get '/api/songs/:id/stream' do
    content_type :json
    song_id = params[:id]
    
    begin
      song = Song[song_id]
      unless song
        status 404
        return {
          success: false,
          message: "Canción no encontrada",
          error: "No existe canción con ID: #{song_id}"
        }.to_json
      end
      
      # Prioridad: S3 -> file_url legacy -> error
      streaming_url = nil
      cover_url = nil
      
      if song.s3_audio_key.present?
        streaming_url = AudioService.generate_streaming_url(song.s3_audio_key, 3600)
      elsif song.file_url.present?
        # Fallback a sistema legacy
        streaming_url = song.file_url
      end
      
      # Cover URL
      if song.s3_cover_key.present?
        cover_url = AudioService.generate_streaming_url(song.s3_cover_key, 3600)
      elsif song.album&.cover_image.present?
        cover_url = song.album.cover_image
      end
      
      unless streaming_url
        status 500
        return {
          success: false,
          message: "No se pudo generar URL de streaming",
          error: "Archivo no disponible"
        }.to_json
      end
      
      status 200
      {
        success: true,
        message: "URL de streaming generada",
        data: {
          song_id: song.id,
          title: song.name,
          streaming_url: streaming_url,
          cover_url: cover_url,
          duration: song.duration,
          file_size: song.file_size,
          audio_format: song.audio_format,
          expires_in: 3600
        }
      }.to_json
      
    rescue => e
      status 500
      {
        success: false,
        message: "Error generando streaming URL",
        error: e.message
      }.to_json
    end
  end
end
