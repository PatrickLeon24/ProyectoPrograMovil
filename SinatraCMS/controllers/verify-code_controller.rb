class PasswordRecoveryVerifyController < ApplicationController
    post '/api/v2/password/verify' do
      content_type :json
  
      begin
        request_body = JSON.parse(request.body.read) rescue nil
        email = request_body['email']
        code = request_body['code']
  
        if email.nil? || code.nil?
          status 400
          return {
            success: false,
            message: "email y code son requeridos",
            data: nil,
            error: "faltan parámetros"
          }.to_json
        end
  
        user = User.first(email: email)
  
        unless user
          status 404
          return {
            success: false,
            message: "Correo no encontrado",
            data: nil,
            error: "usuario no existe"
          }.to_json
        end
  
        if user.reset_token != code
          status 401
          return {
            success: false,
            message: "Código incorrecto",
            data: nil,
            error: "código inválido"
          }.to_json
        end
  
        if user.reset_token_expires < Time.now
          status 410
          return {
            success: false,
            message: "El código expiró",
            data: nil,
            error: "token expirado"
          }.to_json
        end
  
        status 200
        {
          success: true,
          message: "Código verificado correctamente",
          data: { can_reset: true },
          error: nil
        }.to_json
  
      rescue => e
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error interno al verificar código",
          data: nil,
          error: e.message
        }.to_json
      end
    end
  end
  