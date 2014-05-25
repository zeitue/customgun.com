Rails.application.routes.draw do
  root :to => 'home#index'

  get 'about_us/index'
  get 'restoration/index'
  get 'gun_parts/index'
  get 'photo_gallery/index'
  get 'gun_fitting/index'
  get 'wine_stoppers/index'
  get 'pens/index'
  get 'engraving/index'
  get 'taylors_pens_and_gifts/index'
  get 'payment_and_shipping/index'
  get 'double_rifles/index'
  get 'synthetic_rifles/index'
  get 'oil_finishes/index'
  get 'custom_work/index'
  get 'stock_work/index'
  get 'metal_work/index'
  get 'custom_rifles/index'
  get 'sitemap_page_order/index'
  get 'metal_finishes/index'
  get 'contact/index'
  get 'media/index'
  get 'guns_for_sale/index'
  get 'signature_rifle/index'
  get 'leather_wrap_pads/index'
  get 'bracelet_helpers/index'
  get 'show_schedule/index'
  get 'key_chains/index'
  get 'boddington_trophy/index'
  get 'shotguns/index'
  get 'boddington_rifle_project/index'
  get 'home/index'


get '/boddington_rifle_project' => 'boddington_rifle_project#index'
get '/home' => 'home#index'
get '/restoration' => 'restoration#index'
get '/boddington_trophy' => 'boddington_trophy#index'
get '/key_chains' => 'key_chains#index'
get '/shotguns' => 'shotguns#index'
get '/bracelet_helpers' => 'bracelet_helpers#index'
get '/show_schedule' => 'show_schedule#index'
get '/contact' => 'contact#index'
get '/leather_wrap_pads' => 'leather_wrap_pads#index'
get '/signature_rifle' => 'signature_rifle#index'
get '/custom_rifles' => 'custom_rifles#index'
get '/media' => 'media#index'
get '/about_us' => 'about_us#index'
get '/custom_work' => 'custom_work#index'
get '/metal_finishes' => 'metal_finishes#index'
get '/double_rifles' => 'double_rifles#index'
get '/metal_work' => 'metal_work#index'
get '/stock_work' => 'stock_work#index'
get '/engraving' => 'engraving#index'
get '/oil_finishes' => 'oil_finishes#index'
get '/synthetic_rifles' => 'synthetic_rifles#index'
get '/gun_fitting' => 'gun_fitting#index'
get '/payment_and_shipping' => 'payment_and_shipping#index'
get '/taylors_pens_and_gifts' => 'taylors_pens_and_gifts#index'
get '/gun_parts' => 'gun_parts#index'
get '/pens' => 'pens#index'
get '/wine_stoppers' => 'wine_stoppers#index'
get '/guns_for_sale' => 'guns_for_sale#index'
get '/photo_gallery' => 'photo_gallery#index'



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
