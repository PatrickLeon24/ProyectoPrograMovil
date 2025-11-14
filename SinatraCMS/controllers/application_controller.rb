require 'sinatra/base'
require 'jwt'
require_relative '../helpers/application_helpers'
require_relative '../config/database'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  configure do
    set :views, File.expand_path('../views', __dir__)
    set :public_folder, File.expand_path('../public', __dir__)
    set :bind, '0.0.0.0'
    set :port, 5000
  end

  configure :development do
    set :logging, true
    set :dump_errors, true
    set :show_exceptions, true
    DB.loggers << Logger.new($stdout)
  end

  # Cargar modelos automáticamente
  Dir[File.expand_path('../models/*.rb', __dir__)].each { |file| require file }

  # ===============================
  # 🔐 CONFIGURACIÓN JWT
  # ===============================
  set :jwt_secret, ENV['JWT_SECRET'] || 'tu_clave_secreta_super_segura'
  set :jwt_expiration, 24 * 60 * 60 # 24 horas

  # ===============================
  # 🚫 RUTAS EXCLUIDAS DE AUTH
  # ===============================
  BEFORE_FILTER_EXCLUDED_ROUTES = [
    '/api/v2/sign-in','/api/v1/users','/api/v2/sign-up', '/api/v2/users/username'
  ].freeze

  # ===============================
  # 🔎 FILTRO JWT GLOBAL
  # ===============================
  before '/api/*' do
    unless BEFORE_FILTER_EXCLUDED_ROUTES.include?(request.path)
      token = request.env['HTTP_AUTHORIZATION']&.gsub(/^Bearer /, '')

      unless token
        content_type :json
        halt 401, {
          success: false,
          message: "Token requerido",
          data: nil,
          error: "Debe enviar un token en el header Authorization"
        }.to_json
      end

      decoded = decode_token(token)
      unless decoded
        content_type :json
        halt 401, {
          success: false,
          message: "Token inválido o expirado",
          data: nil,
          error: "El token no se pudo decodificar o ya expiró"
        }.to_json
      end

      @current_user = decoded[0]
      puts "DEBUG: chequeo=#{decoded[0].inspect}"
    end
  end

  # ===============================
  # 🌐 RUTAS BASE
  # ===============================
  get '/' do
    erb :index
  end

  get '/about' do
    erb :about
  end

  # ===============================
  # 🧭 UTILERÍA
  # ===============================
  def page_title(title = "Aplicación Sinatra")
    @page_title = title
  end

  run! if app_file == $0
end
