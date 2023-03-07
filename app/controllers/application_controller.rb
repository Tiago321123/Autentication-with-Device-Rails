class ApplicationController < ActionController::Base
    # O padrão de atributos permitidos no Devise são os campos email, senha e confirmação de senha. Então, quando o desenvolvedor quer permitir que o usuário crie, por exemplo, seu nome ou escolha um perfil de acesso para o sistema, é preciso configurar a permissão desses parâmetros.
    before_action :configure_permitted_parameters, if: :devise_controller?
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
    end
    # A partir de agora, o Devise irá autorizar o registro de nome na criação do usuário (“:sign_up”), mas vale lembrar que é preciso configurar também caso seja permitido editar o nome, que utilizaria o “:account_update”.
