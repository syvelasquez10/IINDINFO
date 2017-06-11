Rails.application.routes.draw do
  resources :materia_fantasmas
  resources :cursos
  resources :monitorias
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
  resources :profesores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
