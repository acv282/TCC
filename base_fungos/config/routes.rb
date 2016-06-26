Rails.application.routes.draw do
  get 'team_roles/new'

  get 'teams/new'

  get 'projects/new'

  get 'project/new'

  get 'user_roles/new'

  get 'user_roles/new'

  get 'sessions/new'

  get 'home/home'

  get 'users/new'

  get 'home/index'

	# Rotas para sessoes (login / logout / cadastro)
	get "log_out"           => "sessions#destroy",    :as => "log_out"
	get "log_in"            => "sessions#create",     :as => "log_in"
	get "sign_up"           => "users#new",           :as => "sign_up"
	
	# Outras rotas
	get "projects"          => "projects#index",      :as => "projects"
	get "prj_view"          => "projects#ajax_view",  :as => "ajax_view"
	get "prj_edit/:id"      => "projects#edit",       :as => "prj_edit"
	get "prj_del/:id"       => "projects#destroy",    :as => "prj_del"
	get "prj_new"           => "projects#new",        :as => "prj_new"
	get "prj_ask/:id"       => "projects#ask",        :as => "prj_ask"
	get "teams"             => "teams#index",         :as => "teams" 
	get "team_new"          => "teams#new",           :as => "team_new" 
	get "team_edit_c/:id"   => "teams#edit_c",        :as => "team_edit_c"
	get "team_edit_a/:id"   => "teams#edit_a",        :as => "team_edit_a"
	get "team_rem/:id"      => "teams#rem",           :as => "team_rem"
	get "team_destroy/:id"  => "teams#destroy",       :as => "team_destroy"
	get "team_reassign/:id" => "teams#reassign",      :as => "team_reassign"
	get "team_assign/:id"   => "teams#assign",        :as => "team_assign"
	get "coord"             => "users#coord",         :as => "coord"
	get "new_coord"         => "users#new_coord",     :as => "new_coord"
	get "home"              => "home#home",           :as => "home"
	
	
	# Formulários multi-versão
	post "create_coord"     => "users#create_coord",  :as => "create_coord"
	
	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users
  resources :sessions
  resources :projects
  resources :team_roles
  resources :teams

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
