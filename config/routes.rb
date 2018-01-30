Rails.application.routes.draw do
  devise_for :administradores
  defaults format: :json do
    resources :application do
      collection do
        get  :login
      end
    end
    resources :logs
    resources :notificaciones
    resources :noticias
    resources :citas
    resources :horarios
    resources :saber_pros do
      collection do
        post :cargar_archivo_pagos
      end
    end
    resources :practicas
    resources :materia_fantasmas
    resources :cursos
    resources :monitorias do
      collection do
        get :estado, to: 'monitorias#find_by_estado'
        post :aceptar, to: 'monitorias#aceptar_monitorias'
      end
    end
    resources :estudiantes do
      collection do
        get :email, to: 'estudiantes#find_by_email', email: /^[a-zA-Z.\s]+\d*@uniandes.edu.co$/
        get :monitorias, to: 'estudiantes#estudiantes_monitorias'
        get :practicas, to: 'estudiantes#estudiantes_practicas'
        get :saberPro, to: 'estudiantes#estudiantes_saberpro'
        get :citas, to: 'estudiantes#estudiantes_citas'
      end
    end
    resources :administradores do
      collection do
        post :cargar_archivo_estudiantes
        post :cargar_archivo_cursos
        post :cargar_archivo_profesores
      end
    end
    resources :profesores do
      collection do
        get :email, to: 'profesores#find_by_email', email: /^[a-zA-Z.\s]+\d*@uniandes.edu.co$/
      end
      member do
        post :asignar_curso
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
