Jimlabs3::Application.routes.draw do

  resources :enquiries, :except => [:update, :edit, :show]
  resources :portfolios
  resources :posts
  resources :comments, :only => [:create, :index, :update]

  match '/blog/rss/feed' => 'posts#index', :constraints => {:format => 'rss'}
  match '/blog/:id/rss/feed' => 'posts#show', :constraints => {:format => 'rss'}

  root :to => "pages#index"
  resource :session 

  match '/contact'        => "enquiries#new",    :as => :contact
  match '/admin'          => "sessions#new",     :as => :admin
  match '/logout'         => "sessions#destroy", :as => :logout
  match '/tags/:tag_name' => "tags#show",        :as => :tag
  match '/archives/:date' => "archives#show",    :as => :archive
  match '/sitemap.xml'    => "pages#sitemap",    :as => 'sitemap'
  match '*url'            => "pages#page_not_found"
end
