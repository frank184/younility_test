Rails.application.routes.draw do
  get 'labels/index'

  root to: 'visitors#index'
  devise_for :users

  resources :labels
  resources :users do
    resources :labels, controller: 'users/labels', only: [:update, :destroy] do
      collection do
        get '/edit', to: 'users/labels#edit'
      end
    end
    # scope :labels do
    #   get '/edit', to: 'users/labels#edit', as: :edit_user_labels_path
    #   patch '/', to: 'users/labels#update', as: :user_labels_path
    # end
  end
end
