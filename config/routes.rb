Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  
  resources :questions, shallow: true do
    resources :answers do
      post :mark_as_best, on: :member
    end
  end
end

