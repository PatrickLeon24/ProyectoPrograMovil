class PasswordRecoveryResetController < ApplicationController
    post '/api/v2/password/reset' do
      content_type :json
  
      begin
        request_body = JSON.parse(request.body.read) rescue nil
        email = request_body['email']
        new_password = request_body['new_password']
  
        if email.nil? || new_password.nil?
          status 400
          return {
            success: false,
            message: "email y new_password son requeridos",
            data: nil,
            error: "faltan parámetros"
          }.to_json
        end
  
        user = User.first(email: email)
  
        unless user
          status 404
          return {
            success: false,
            message: "Usuario no encontrado",
            data: nil,
            error: "correo inválido"
          }.to_json
        end
  
        # Actualizar contraseña
        user.update(
          password_hash: new_password,
          reset_token: nil,
          reset_token_expires: nil
        )
  
        status 200
        {
          success: true,
          message: "Contraseña actualizada correctamente",
          data: nil,
          error: nil
        }.to_json
  
      rescue => e
        puts e.backtrace.join("\n")
        status 500
        {
          success: false,
          message: "Error interno al actualizar contraseña",
          data: nil,
          error: e.message
        }.to_json
      end
    end
  end
  