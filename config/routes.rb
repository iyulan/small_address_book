Rails.application.routes.draw do
  root 'contacts#index'

  resources :contacts do
    collection do
      post :import
      get :export
    end

    member do
      get :share
    end
  end
end
