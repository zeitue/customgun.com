Rails.application.routes.draw do

  resources :photos
  get '/store/gun-parts' => 'products#gun_parts', :as => :gunparts
  get '/store/wood' => 'products#wood', :as => :wood
  get '/store/barrels' => 'products#barrels', :as => :barrels
  get '/store/optics' => 'products#optics', :as => :optics
  get '/store/gifts' => 'products#gifts', :as => :gifts
  get '/store/jewlery' => 'products#jewelry', :as => :jewelry
  get '/store/decor' => 'products#decor', :as => :decor
  get '/store/gun-cases' => 'products#gun_cases', :as => :gun_cases
  get '/store/guns' => 'products#guns', :as => :guns
  resources :products, path: 'store'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'about' => 'about#index', :as => :about
  get 'boddington-rifle-project' => 'boddington_rifle_project#index', :as => :boddington_rifle_project
  get 'bracelet-helpers' => 'bracelet_helpers#index', :as => :bracelet_helpers
  get 'contact' => 'contact#index', :as => :contact
  get 'custom-rifles' => 'custom_rifles#index', :as => :custom_rifles
  get 'engraving' => 'engraving#index', :as => :engraving
  get 'events' => 'events#index', :as => :events
  get 'finishes' => 'finishes#index', :as => :finishes
  get 'gun-fitting' => 'gun_fitting#index', :as => :gun_fitting
  get 'gun-parts' => 'gun_parts#index', :as => :gun_parts
  get 'guns-for-sale' => 'guns_for_sale#index', :as => :guns_for_sale
  get 'gunsmithing' => 'gunsmithing#index', :as => :gunsmithing
  get 'home' => 'home#index', :as => :home
  get 'key-chains' => 'key_chains#index', :as => :key_chains
  get 'layouts' => 'layouts#index', :as => :layouts
  get 'leather-wrap-pads' => 'leather_wrap_pads#index', :as => :leather_wrap_pads
  get 'media' => 'media#index', :as => :media
  get 'payment-and-shipping' => 'payment_and_shipping#index', :as => :payment_and_shipping
  get 'pistols' => 'pistols#index', :as => :pistols
  get 'pens' => 'pens#index', :as => :pens
  get 'restoration' => 'restoration#index', :as => :restoration
  get 'shotguns' => 'shotguns#index', :as => :shotguns
  get 'stock-work' => 'stock_work#index', :as => :stock_work
  get 'synthetic-rifles' => 'synthetic_rifles#index', :as => :synthetic_rifles
  get 'taylors-pens-and-gifts' => 'taylors_pens_and_gifts#index', :as => :taylors_pens_and_gifts
  get 'trophy-room' => 'trophy_room#index', :as => :trophy_room
  get 'wine-stoppers' => 'wine_stoppers#index', :as => :wine_stoppers


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  #     #   end
end
