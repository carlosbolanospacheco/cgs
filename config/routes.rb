Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }, path_prefix: 'u'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'colegiados#index'
  resources :colegiados do
    post 'presentar-documento', to: 'colegiados#presentar_documento'
    collection do
      post 'filter'
      post 'listado'
      post 'principal'
      post 'listado-pdf', to: 'downloads#listado_colegiados'
      post 'documento-pdf', to: 'downloads#generar_documento'
      post 'recibo-pdf', to: 'downloads#generar_recibo'
      get  'etiquetas', to: 'downloads#etiquetas'
      get  'mostrar-documento', to: 'colegiados#mostrar_documento'
    end
  end
  resources :colegios, except: %i[show index new create destroy] do
    collection do
      post 'documento-pdf', to: 'colegios#generar_documento'
    end
  end
  resources :bancos, except: [:show]
  resources :accounts, except: [:show]
  resources :causa_bajas, except: [:show]
  resources :cargos, except: [:show]
  resources :regimen_colegiados, except: %i[show new create destroy]
  resources :users, except: [:show]
  resources :documentos, except: %i[show destroy create]
end
