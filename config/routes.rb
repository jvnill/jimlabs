Jimlabs3::Application.routes.draw do
  root 'pages#index'

  resources :enquiries, only: [:new, :create]
  resources :portfolios, only: [:new, :create, :edit, :update, :destroy]

  resources :posts do
    collection do
      get '/:year' => 'posts#index', constraints: { year: /\d{4}/ }, as: :year
    end
  end

  get '/portfolio'         => 'portfolios#index', as: :portfolio_index
  get '/contact'           => 'enquiries#new',    as: :contact
  get '/admin'             => 'sessions#new',     as: :admin
  get '/tags/:tag_name'    => 'tags#show',        as: :tag
  get '/sitemap(.:format)' => 'pages#sitemap',    as: :sitemap, defaults: { format: :xml }
  get '/blog/rss/feed'     => 'posts#index',      constraints: { format: 'rss' }
  get '/blog/:id/rss/feed' => 'posts#show',       constraints: { format: 'rss' }
  get '*url'               => 'pages#page_not_found'
end
