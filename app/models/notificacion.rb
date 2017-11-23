class Notificacion < ApplicationRecord
  include HTTParty
  base_uri 'https://fcm.googleapis.com/fcm/send'


  def self.enviar_mensaje(params)

    resultado = HTTParty.post(base_uri,
                  :body => { :notification => {
                                        :title =>params['asunto'],
                                        :body => params['contenido']
                                     },
                             :to => params['to']
                  }.to_json,
                  :headers => { 'Content-Type' => 'application/json',
                                'Authorization' => ENV['SERVER_KEY']} )

    return resultado

  end
end
