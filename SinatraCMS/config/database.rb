require 'sequel'
require 'logger'

DB = Sequel.sqlite('db/DataBase.db')

# Configuración de logging para desarrollo
DB.loggers << Logger.new($stdout) if defined?(Sinatra::Base) && Sinatra::Base.development?