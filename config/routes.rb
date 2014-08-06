Jimlabs3::Application.routes.draw do
  root to: "pages#index"

  resource :session

  resources :enquiries, only: [:index, :new, :create, :destroy]
  resources :posts
  resources :comments, only: [:create, :index, :update]

  match '/portfolio'         => 'portfolios#index', as: :portfolio
  match '/contact'           => 'enquiries#new',    as: :contact
  match '/admin'             => 'sessions#new',     as: :admin
  match '/logout'            => 'sessions#destroy', as: :logout
  match '/tags/:tag_name'    => 'tags#show',        as: :tag
  match '/archives/:date'    => 'archives#show',    as: :archive
  match '/sitemap(.:format)' => 'pages#sitemap',    as: :sitemap, defaults: { format: :xml }

  match '/blog/rss/feed'     => 'posts#index', constraints: { format: 'rss' }
  match '/blog/:id/rss/feed' => 'posts#show',  constraints: { format: 'rss' }
  match '*url'               => 'pages#page_not_found'
end
