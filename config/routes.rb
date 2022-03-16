Rails.application.routes.draw do
  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
      delete :unvote
    end
  end

  concern :commentable do
    resources :comments, only: :create
  end

  devise_for :users
  root to: 'questions#index'
  
  resources :questions, concerns: %i[votable commentable], shallow: true do
    resources :answers, concerns: %i[votable commentable] do
      post :mark_as_best, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index

  mount ActionCable.server => '/cable'
end

