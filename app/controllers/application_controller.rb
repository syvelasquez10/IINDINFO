class ApplicationController < ActionController::API
  include HTTParty
  base_uri 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'

  before_action :log

  private
    # Metodo para revisar el token de autenticacion de firebase
    def revisar_token
      # Se carga un json que contiene las llaves publicas desde una url
      llaves_publicas = self.class.get('/')

      # Se decodifica el JWT
      jwt = params[:jwt].split(".")
      header = JSON.parse(Base64.decode64(jwt[0]))
      payload = Base64.decode64(jwt[1])

      # Se carga en un certificado la llave publica que indica el kid que viene en el header del jwt
      rsa = OpenSSL::X509::Certificate.new(llaves_publicas["#{header['kid']}"])

      # Se revisa la firma con la llave publica generada
      JWT.decode params[:jwt], rsa.public_key, true, { :algorithm => 'RS256' }

      return payload['aud']

    end

    # Metodo encargado de guardar todos los logs del programa
    def log
      parametros = {}
      parametros['action'] = params['action']
      parametros['controller'] = params['controller']
      parametros['fecha'] =  Time.zone.now
      parametros['token'] = false
      puts parametros
      log = Log.create(parametros)

      # parametros['usuario'] = revisar_token()
      parametros['token'] = true
      log.update(parametros)
    end
end
