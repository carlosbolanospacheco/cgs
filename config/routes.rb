Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }, path_prefix: 'u'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'colegiados#index'
  resources :colegiados do
    collection do
      post 'filter'
      post 'listado'
      post 'principal'
      post 'listado-pdf', to: 'downloads#listado_colegiados'
    end
  end
  resources :bancos, except: [:show]
  resources :accounts, except: [:show]
  resources :causa_bajas, except: [:show]
  resources :cargos, except: [:show]
  resources :regimen_colegiados, except: %i[show new create destroy]
  resources :colegios, except: %i[show index new create destroy]
  resources :users, except: [:show]
end
