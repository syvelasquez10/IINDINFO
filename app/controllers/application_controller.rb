class ApplicationController < ActionController::API
  include HTTParty
  base_uri 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'


  private
    # Metodo para revisar el token de autenticacion de firebase
    def revisar_token
      llaves_publicas = self.class.get('/')

      jwt = params[:jwt].split(".")
      header = JSON.parse(Base64.decode64(jwt[0]))
      payload = Base64.decode64(jwt[1])

      rsa = OpenSSL::X509::Certificate.new(llaves_publicas["#{header['kid']}"])

      decoded_token = JWT.decode params[:jwt], rsa.public_key, true, { :algorithm => 'RS256' }
    end
end
