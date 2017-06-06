Rails.application.routes.draw do
  resources :administradores do
    collection do
      post :cargar_archivo
    end
    member do

    end
  end
  resources :profesores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
