Rails.application.routes.draw do
  resources :practicas
  resources :materia_fantasmas
  resources :cursos
  resources :monitorias do
    collection do
      get :estado, to: 'monitorias#find_by_estado'
    end
  end
  resources :estudiantes do
    collection do
      get :email, to: 'estudiantes#find_by_email', email: /^[a-zA-Z.\s]+\d*@uniandes.edu.co$/
    end
  end
  resources :administradores do
    collection do
      post :cargar_archivo_estudiantes
      post :cargar_archivo_cursos
    end
    member do

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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
