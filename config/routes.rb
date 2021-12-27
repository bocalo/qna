Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  
  # resources :questions, shallow: true, only: [:new, :show, :create, :update] do
  #   resources :answers
  # end

  resources :questions, shallow: true do
    resources :answers
  end
end

