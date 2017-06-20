class MonitoriasController < ApplicationController
  before_action :set_monitoria, only: [:show, :update, :destroy]

  # GET /monitorias
  def index
    @monitorias = Monitoria.all
    monitorias = []
    for monitoria in @monitorias
      monitorias.push(monitoria.as_json.merge('estudiante':monitoria.estudiante.as_json).merge('curso':monitoria.curso.as_json))
    end
    render json: monitorias
  end

  # GET /monitorias/1
  def show
    render json: @monitoria.as_json.merge('estudiante':@monitoria.estudiante.as_json)
  end

  # POST /monitorias
  def create
      @monitoria = Monitoria.new(monitoria_params)
      if @monitoria.save
        render json: @monitoria, status: :created, location: @monitoria
      else
        render json: @monitoria.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /monitorias/1
  def update
    if @monitoria.update(monitoria_params)
      render json: @monitoria
    else
      render json: @monitoria.errors, status: :unprocessable_entity
    end
  end

  # DELETE /monitorias/1
  def destroy
    @monitoria.destroy
    render json: { mensaje:"La monitoria ha sido eliminada"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitoria
      jwt = params[:jwt].split(".")
      header = JSON.parse(Base64.decode64(jwt[0]))
      payload = Base64.decode64(jwt[1])

      if header['kid'] == '861e619c87ea74633849421fffe32e6bed96795d'
        cert = "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIaHN+SwTIAW0wDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTcw\nNjIwMDA0NTI2WhcNMTcwNjIzMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAMviRyNJ2siUGzlGqVuFeE5vbzj3YyaWINUsJKRynxBt9lqL\nj5QkN1E6OqZiF6aecBb8H6LirMjtDDjfvQydjWNr8tUTJaHmkzKkJ4mvgubNy7/9\nVyZDQb3wFW2KBHBJ/w/5ZzGYGvuncPW3MnNTpEGDaY8jTKCLylBWxnH+XCJt87DB\ncL+3Sjm4ofpgUu30hVZGosM8a0oEelyiF8C7jQgdUsZLrimk7xQoRTj7gUIiUwDK\nmBYS+YT5k68dE5kHSAFgroRSMHp1AWO5LPE7aF3YaJybOzswmLq2O+kNm6JaVJ/9\nYijaAvA9Dos8i4VgocLBWOLwNvORKbXOUrsk8MkCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAApWBXE+DyC90uMO/IDpl5c/L4YyBtEWYhatfhspzWnm\ndJgj4oJ/tmzT1lQdz96WHr+WFMuL+EP5Et8NrwaJ9eMKS32u+vBANZDlFpzGgy/i\n91Krpk7YB0Uq+OT7rWiBWgGj/QOQX4cly7wROcHl5FGDXmWhxLg6JHwD+68NCL5w\nwKT+k9oCuSagcLDaQnZWZqQ1CMCLNGDYP1AtxDjZw7h+xFbnb/WHM7uV5Cynh8wY\nmyxWePzh8tCw24g/jKsYCWGVf+CeeixZd4KaISYT9wY0aGqpnWgr6WTPcU6O0kmV\ns9ijKUMSs/3PaAJyfxfNqpf6ITIrryxZqY67bwkS/uw=\n-----END CERTIFICATE-----\n"
      elsif header['kid'] == '8e99e7f511d11683a7f7065974d176a598e4db5c'
        cert = "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIB/xPsRkbEcswDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTcw\nNjE4MDA0NTI2WhcNMTcwNjIxMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAKepdoy6XTC6W89KWjFC0H5X9h46hmuRqKD2bl/NjB0sH4P6\n/mgbSpJQGFDl3ZRTQoYq7OC36XW5DjqhmYpfZH4G2Tw/YWTwsUTgBlgETRJ4n5Io\nwJG275w84jwvN5WgGKj7Ni+sdKModS1/PDQLW1RsxoLcaifQRtm9eBOrztripV7T\nEhNE9ENplJ9nwDTpWmrhfVxcnTpGXpfajCqfOAeAfZNwVPtgDlogfFl/CUU5xoPw\nQSjIilDWHF6bUjO9ra2IRYKho1HwkX6gXrmZmuY1P9cFEPOqYUDZZQEEupgXd8/0\ndp8941zwbZJ++ZS90BOTqCMK70pY9Swou962LZMCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAEATByb7Ejbv7A9QJ0xtnb3NjjNBDjvSpMlHW+W3cU/A\ntjcv2N+ZRfCynBDUQleAFRFavfGprE8OCYIplfBaW8SvtGTSb8T2GyARQZntg++t\nzoG99fTjNQhwwhk2EKm+uy9s/g//GJeYQB+WcMfV7BsepKk4MC5MY0GVrhGNAxz2\n6BIeebKE8RnF9qVFyg5GTpINOTywA1dOVbSYOMs2T21a8YGE2AeJFcHpUkhVmCKI\nIdmvld/Q1jaN4ZYJdMAUsv2Thpna2x+nC18heJ5Vt5101u1LsBFSgnPnSANL9y7M\nkTrRbar17swTNimUHYTCyIl2G3j/8fIgw7vz+AoQfGU=\n-----END CERTIFICATE-----\n"
      elsif header['kid'] == '0d5ceb05806897937e014ac03dafd842338f0e6d'
        cert = "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIBXCgTR7TXxMwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTcw\nNjE5MDA0NTI2WhcNMTcwNjIyMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBANPpZqCELbC2QxsvTe5uqMBPwJlN9bbWKKMkYSUJu+a0khpb\nSxzla7NRq0FbW7KESZkxWa08VbuicXuiaLn0SmM0RXUl0CP6sPPBCR1OLt0BznZD\nOKhN924CMHUNeiZEqIPF6058bceFxlmSk37lVp3TCVbKgsJ+H/L72U8bDFlMd1M3\n5B8EDeKpWLUhXkSra6+SzP+WhVJ1LlYeGvsvGRR3Dr5cShLokrKQmERu1ilxqzkt\nbs/jjjPjum1RNS1z8gZbbGnn6izBaKcZN/0FFsKuAalLahghQIo5jGYhTMC7YxRh\nfuoMnjOTm/ZOSFic+gTnF/sirL1snvUESa+nhIsCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBABCiqkcOd3iIMwYw5dzPeFmT6zDArZHdjimmBxkvb1UK\njU9WPmKL9Zau3+F1qXFhlVzL07FsiIz7Xk5YjKVzv4njvaBHJ6h/0OkY5gVl4BcO\nH/T9+HLzOOLeu7cH2UXh4SADZo9aSJZZeD5WDRJrwLTbra4YPyZo0AytJnMfXRBg\n8VYWKxS1iziV3UELWzfCTKYa52xvm2KwV8VP3Xtgek5C/zrkOG1ZyTAlnSOUF8Wa\n30yzjum+Zbjp9RoqplFoNZjN2nKcLKtC664jaZDLGZ9Kup9nHNCyTb4d6Uawt+kt\nM8KwwR9E5EfzMXLCVPZlIMVlnSeCZJQsui9yNDOF9yA=\n-----END CERTIFICATE-----\n"
      elsif header['kid'] == 'ffd6649cba7219672ba7a2693409272a32c97d55'
        cert = "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIKGvN/NtyViQwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTcw\nNjIxMDA0NTI2WhcNMTcwNjI0MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAOH+hFx3caJMa3ZSv16MdGahFTEosHcLy0UNWttQ2+9KQdav\nzWvbEFmT+REPfTokKNKzRA0XL9JO/jMRSFW2QRQpnAlgZ8UwTY4QdhenbqJdCnI8\n80IMLtPV3K9n3y2epGzn7DRtUz/ucDV7fq06Yfe+bxhMxUOCdmWaWrahwn7UKbuw\njUrvr8ixyL0f+E7D3iigOcL7Sn9oMU4YhcUltEQcl6PxVR0kzEbn6jfy67YroBaN\ny8/Lqxr20Ms86iW6fHYNd5rUZ5Mj/cWvyx+20SRhQfwbUgz99/hac/eIHbAZWgxX\nNlFQ7hOxrEHO+VKXLpJIRR7VI/dk3TmuzB08jD0CAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAM8z4V9vPc+yZfxqzR4GWlcdS3RBE9Pa/P13vRU47FcL\nU72InIk9lFg+ttYgsviMt1tgVH8T0v/sVZDLmGx7j++7NK4Fy70KAji95EY8Oe/M\nR1JFcePm4JSVVUA+kVaAtBaiDgU0Q7m/2qxXxIfWhF2UKZy7w2Vxr5eUOdYrAgIl\n8YJIoE/Ru4+aJcLQXJNmh+dzWKDzDELqCRdyWJjU9EoGZDEtNJ9L3PshRDp3pnll\nOnH7ckWaGrz7zNbpi7WBA1YzxvU3NC6iVVdvQYwMOfV7Bz3v/N8dzKOwU3cIHVe3\nWkuEuqPVTR96GbZL9N5Ltc/UMPW9wxsFafc9OZwaYXA=\n-----END CERTIFICATE-----\n"
      end
      rsa = OpenSSL::X509::Certificate.new(cert)

      decoded_token = JWT.decode params[:jwt], rsa.public_key, true, { :algorithm => 'RS256' }

      @monitoria = Monitoria.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def monitoria_params
      params.require(:monitoria).permit(:estado, :notificaciones, :nota_curso, :estudiante_id, :curso_id, :semestre_curso)
    end
end
