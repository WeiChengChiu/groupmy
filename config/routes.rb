Rails.application.routes.draw do
  resources :groups do
    resources :posts
  end
end
