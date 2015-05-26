Rails.application.routes.draw do
  root :to => 'home#index'

  get 'about-us/index'
  get 'restoration/index'
  get 'gun-parts/index'
  get 'photo-gallery/index'
  get 'gun-fitting/index'
  get 'wine-stoppers/index'
  get 'pens/index'
  get 'engraving/index'
  get 'taylors-pens-and-gifts/index'
  get 'payment-and-shipping/index'
  get 'double-rifles/index'
  get 'synthetic-rifles/index'
  get 'oil-finishes/index'
  get 'custom-work/index'
  get 'stock-work/index'
  get 'metal-work/index'
  get 'custom-rifles/index'
  get 'sitemap-page-order/index'
  get 'metal-finishes/index'
  get 'contact/index'
  get 'media/index'
  get 'guns-for-sale/index'
  get 'signature-rifle/index'
  get 'leather-wrap-pads/index'
  get 'bracelet-helpers/index'
  get 'show-schedule/index'
  get 'key-chains/index'
  get 'boddington-trophy/index'
  get 'shotguns/index'
  get 'boddington-rifle-project/index'
  get 'home/index'


get '/boddington-rifle-project' => 'boddington-rifle-project#index'
get '/home' => 'home#index'
get '/restoration' => 'restoration#index'
get '/boddington-trophy' => 'boddington-trophy#index'
get '/key-chains' => 'key-chains#index'
get '/shotguns' => 'shotguns#index'
get '/bracelet-helpers' => 'bracelet-helpers#index'
get '/show-schedule' => 'show-schedule#index'
get '/contact' => 'contact#index'
get '/leather-wrap-pads' => 'leather-wrap-pads#index'
get '/signature-rifle' => 'signature-rifle#index'
get '/custom-rifles' => 'custom-rifles#index'
get '/media' => 'media#index'
get '/about-us' => 'about-us#index'
get '/custom-work' => 'custom-work#index'
get '/metal-finishes' => 'metal-finishes#index'
get '/double-rifles' => 'double-rifles#index'
get '/metal-work' => 'metal-work#index'
get '/stock-work' => 'stock-work#index'
get '/engraving' => 'engraving#index'
get '/oil-finishes' => 'oil-finishes#index'
get '/synthetic-rifles' => 'synthetic-rifles#index'
get '/gun-fitting' => 'gun_fitting#index'
get '/payment-and-shipping' => 'payment-and-shipping#index'
get '/taylors-pens-and-gifts' => 'taylors-pens-and-gifts#index'
get '/gun-parts' => 'gun-parts#index'
get '/pens' => 'pens#index'
get '/wine-stoppers' => 'wine-stoppers#index'
get '/guns-for-sale' => 'guns-for-sale#index'
get '/photo-gallery' => 'photo-gallery#index'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
