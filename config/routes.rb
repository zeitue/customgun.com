Rails.application.routes.draw do

  resources :shippers, path: 'store/shippers'
  resources :authentications
  get '/store/orders/carts' => 'orders#carts', :as => :carts
  get '/store/orders/details/:id' => 'orders#details', :as => :order_details
  get '/store/orders/invoice/:id' => 'orders#invoice', :as => :order_invoice
  get '/store/checkout/address-select' => 'checkouts#address_select', :as => :address_select
  get '/store/checkout/shipping-select' => 'checkouts#shipping_select', :as => :shipping_select
  get '/store/checkout/review' => 'checkouts#review', :as => :review
  get '/store/checkout/process-order' => 'checkouts#process_order', :as => :process_order
  get '/store/checkout/packaging' => 'checkouts#packaging', :as => :packaging
  get '/store/checkout/approved' => 'checkouts#approved', :as => :approved
  get '/store/checkout/disapproved' => 'checkouts#disapproved', :as => :disapproved
  get '/store/products' => 'products#products', :as => :product_management
  get '/store/gun-parts' => 'products#gun_parts', :as => :gunparts
  get '/store/custom-parts' => 'products#custom_parts', :as => :custom_parts
  get '/store/wood' => 'products#wood', :as => :wood
  get '/store/barrels' => 'products#barrels', :as => :barrels
  get '/store/optics' => 'products#optics', :as => :optics
  get '/store/gifts' => 'products#gifts', :as => :gifts
  get '/store/jewlery' => 'products#jewelry', :as => :jewelry
  get '/store/decor' => 'products#decor', :as => :decor
  get '/store/gun-cases' => 'products#gun_cases', :as => :gun_cases
  get '/store/guns' => 'products#guns', :as => :guns
  get '/store/contact' => 'products#contact', :as => :store_contact
  get '/store/privacy-policy' => 'products#privacy_policy', :as => :privacy_policy
  get '/store/return-policy' => 'products#return_policy', :as => :return_policy
  get '/store/terms-and-conditions' => 'products#terms_and_conditions', :as => :terms_and_conditions
  get '/store/payment-policy' => 'products#payment_policy', :as => :payment_policy
  get '/store/shipping-policy' => 'products#shipping_policy', :as => :shipping_policy
  get '/store/sales-tax' => 'products#sales_tax', :as => :sales_tax
  get '/store/new-arrivals' => 'products#new_arrivals', :as => :new_arrivals
  get '/store/sale-items' => 'products#sale_items', :as => :sale_items

  resources :boxes, path: 'store/boxes'
  resources :shipments, path: 'store/shipments'
  resources :addresses, path: 'store/users/addresses'
  resource :cart, only: [:show], path: 'store/cart'
  resource :checkout, path: 'store/checkout'
  resources :items, path: 'store/items'
  resources :orders, path: 'store/orders'
  devise_for :users, path: 'store/users', controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  resources :users, path: 'store/users', only: [:show, :index, :destroy]
  resources :photos, path: 'store/photos'
  resources :products, path: 'store'
  match '/auth/:provider/callback' => 'authentications#create', via: [:get, :post]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'alchemist-series' => 'alchemist_series#index', :as => :alchemist_series
  get 'alchemist-series/avani.odt' => 'alchemist_series#download_avani', :as => :avani
  get 'alchemist-series/ember.odt' => 'alchemist_series#download_ember', :as => :ember
  get 'alchemist-series/zephyr.odt' => 'alchemist_series#download_zephyr', :as => :zephyr
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
