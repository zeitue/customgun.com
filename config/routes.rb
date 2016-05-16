Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'about' => 'about#index', :as => :about
  get 'boddington-rifle-project' => 'boddington_rifle_project#index', :as => :boddington_rifle_project
  get 'boddington-trophy' => 'boddington_trophy#index', :as => :boddington_trophy
  get 'bracelet-helpers' => 'bracelet_helpers#index', :as => :bracelet_helpers
  get 'contact' => 'contact#index', :as => :contact
  get 'custom-rifles' => 'custom_rifles#index', :as => :custom_rifles
  get 'custom-work' => 'custom_work#index', :as => :custom_work
  get 'double-rifles' => 'double_rifles#index', :as => :double_rifles
  get 'engraving' => 'engraving#index', :as => :engraving
  get 'events' => 'events#index', :as => :events
  get 'gun-fitting' => 'gun_fitting#index', :as => :gun_fitting
  get 'gun-parts' => 'gun_parts#index', :as => :gun_parts
  get 'guns-for-sale' => 'guns_for_sale#index', :as => :guns_for_sale
  get 'gunsmithing' => 'gunsmithing#index', :as => :gunsmithing
  get 'home' => 'home#index', :as => :home
  get 'key-chains' => 'key_chains#index', :as => :key_chains
  get 'layouts' => 'layouts#index', :as => :layouts
  get 'leather-wrap-pads' => 'leather_wrap_pads#index', :as => :leather_wrap_pads
  get 'media' => 'media#index', :as => :media
  get 'metal-finishes' => 'metal_finishes#index', :as => :metal_finishes
  get 'oil-finishes' => 'oil_finishes#index', :as => :oil_finishes
  get 'payment-and-shipping' => 'payment_and_shipping#index', :as => :payment_and_shipping
  get 'pens' => 'pens#index', :as => :pens
  get 'restoration' => 'restoration#index', :as => :restoration
  get 'shotguns' => 'shotguns#index', :as => :shotguns
  get 'signature-rifle' => 'signature_rifle#index', :as => :signature_rifle
  get 'stock-work' => 'stock_work#index', :as => :stock_work
  get 'store' => 'store#index', :as => :store
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
  #     resources :products
  #   end
end
