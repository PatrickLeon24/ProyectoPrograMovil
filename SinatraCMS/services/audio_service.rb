require_relative '../config/s3_config'
require 'marcel'
require 'securerandom'

class AudioService
  # Formatos de audio permitidos
  ALLOWED_AUDIO_FORMATS = ['audio/mpeg', 'audio/mp3', 'audio/wav', 'audio/flac', 'audio/m4a'].freeze
  ALLOWED_IMAGE_FORMATS = ['image/jpeg', 'image/png', 'image/jpg'].freeze
  
  # Tamaños máximos (en bytes)
  MAX_AUDIO_SIZE = 100 * 1024 * 1024  # 100 MB
  MAX_IMAGE_SIZE = 10 * 1024 * 1024   # 10 MB

  # Subir canción a S3
  def self.upload_song(audio_file, song_id)
    # Validar archivo
    return { error: "Archivo de audio requerido" } unless audio_file
    
    # Detectar tipo MIME y extensión
    mime_type = Marcel::MimeType.for(audio_file[:tempfile])
    file_extension = File.extname(audio_file[:filename]).downcase
    
    # Validaciones más flexibles para M4A
    is_valid_audio = ALLOWED_AUDIO_FORMATS.include?(mime_type) || 
                     ['.mp3', '.wav', '.flac', '.m4a'].include?(file_extension)
    
    return { error: "Formato de audio no válido. Permitidos: MP3, WAV, FLAC, M4A" } unless is_valid_audio
    
    # Validar tamaño
    file_size = audio_file[:tempfile].size
    return { error: "Archivo muy grande (máximo 100MB)" } if file_size > MAX_AUDIO_SIZE
    
    # Generar clave única
    s3_key = "audio/songs/#{song_id}_#{SecureRandom.hex(8)}#{file_extension}"
    
    # Ajustar MIME type para M4A si es necesario
    if file_extension == '.m4a' && !mime_type.include?('audio')
      mime_type = 'audio/mp4'
    end
    
    begin
      # Subir a S3
      S3Config.bucket.put_object(
        key: s3_key,
        body: audio_file[:tempfile],
        content_type: mime_type,
        metadata: {
          'original_filename' => audio_file[:filename],
          'uploaded_at' => Time.now.iso8601,
          'song_id' => song_id.to_s
        }
      )
      
      return {
        success: true,
        s3_key: s3_key,
        file_size: file_size,
        audio_format: file_extension.gsub('.', ''),
        mime_type: mime_type
      }
    rescue => e
      return { error: "Error al subir archivo: #{e.message}" }
    end
  end

  # Subir cover de canción
  def self.upload_song_cover(image_file, song_id)
    return { error: "Archivo de imagen requerido" } unless image_file
    
    mime_type = Marcel::MimeType.for(image_file[:tempfile])
    return { error: "Formato de imagen no válido" } unless ALLOWED_IMAGE_FORMATS.include?(mime_type)
    
    file_size = image_file[:tempfile].size
    return { error: "Imagen muy grande (máximo 10MB)" } if file_size > MAX_IMAGE_SIZE
    
    file_extension = File.extname(image_file[:filename])
    s3_key = "images/covers/songs/#{song_id}_cover_#{SecureRandom.hex(6)}#{file_extension}"
    
    begin
      S3Config.bucket.put_object(
        key: s3_key,
        body: image_file[:tempfile],
        content_type: mime_type,
        metadata: {
          'original_filename' => image_file[:filename],
          'uploaded_at' => Time.now.iso8601,
          'song_id' => song_id.to_s,
          'type' => 'song_cover'
        }
      )
      
      return {
        success: true,
        s3_key: s3_key,
        file_size: file_size
      }
    rescue => e
      return { error: "Error al subir cover: #{e.message}" }
    end
  end

  # Generar URL firmada para streaming
  def self.generate_streaming_url(s3_key, expires_in = 3600)
    return nil unless s3_key.present?
    
    begin
      S3Config.client.get_object(
        bucket: S3Config.bucket_name,
        key: s3_key,
        expires_in: expires_in
      ).presigned_url(:get)
    rescue => e
      puts "Error generando URL firmada: #{e.message}"
      nil
    end
  end

  # Eliminar archivo de S3
  def self.delete_file(s3_key)
    return false unless s3_key.present?
    
    begin
      S3Config.bucket.object(s3_key).delete
      true
    rescue => e
      puts "Error eliminando archivo: #{e.message}"
      false
    end
  end
end