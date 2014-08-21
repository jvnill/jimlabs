Jimlabs3::Application.routes.draw do
  root to: "pages#index"

  resource :session

  resources :enquiries, only: [:index, :new, :create, :destroy]
  resources :posts
  resources :comments, only: [:create, :index, :update]
  resources :portfolios, only: [:new, :create, :edit, :update, :destroy]

  get '/portfolio'         => 'portfolios#index', as: :portfolio_index
  get '/contact'           => 'enquiries#new',    as: :contact
  get '/admin'             => 'sessions#new',     as: :admin
  get '/tags/:tag_name'    => 'tags#show',        as: :tag
  get '/archives/:date'    => 'archives#show',    as: :archive
  get '/sitemap(.:format)' => 'pages#sitemap',    as: :sitemap, defaults: { format: :xml }
  get '/blog/rss/feed'     => 'posts#index', constraints: { format: 'rss' }
  get '/blog/:id/rss/feed' => 'posts#show',  constraints: { format: 'rss' }

  delete '/logout'         => 'sessions#destroy', as: :logout

  get '*url'               => 'pages#page_not_found'
end
