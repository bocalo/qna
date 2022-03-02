Rails.application.routes.draw do
  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
      delete :unvote
    end
  end

  devise_for :users
  root to: 'questions#index'
  
  resources :questions, concerns: :votable, shallow: true do
    resources :answers, concerns: :votable do
      post :mark_as_best, on: :member
    end
  end

  
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
end

