class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :destroy, :products]
  before_action :update_on_sale, only: [:show]
  layout 'store'

  # GET /products
  def index
    @products = Product.where('active = ? or active = ?', true, !current_user.admin)
    @products = @products.order('created_at desc') if params[:qorder]
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
    @no_page = @products
    @products = Kaminari.paginate_array(@products).page(params[:page]).per(15)
  end


  def main
    @products = Product.where(active: true).order('RANDOM()').limit(3)
  end

  def products
    redirect_to products_url
    #@grid = initialize_grid(Product, include: :photos, order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gun_parts
    redirect_to products_url(:department => 'gun_parts')
    #@gun_parts_grid = initialize_grid(Product.where(store: 'gun_parts', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def wood
    redirect_to products_url(:department => 'wood')
    #@wood_grid = initialize_grid(Product.where(store: 'wood', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def barrels
    redirect_to products_url(:department => 'barrels')
    #@barrels_grid = initialize_grid(Product.where(store: 'barrels', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def optics
    redirect_to products_url(:department => 'optics')
    #@optics_grid = initialize_grid(Product.where(store: 'optics', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gifts
    redirect_to products_url(:department => 'gifts')
    #@gifts_grid = initialize_grid(Product.where(store: 'gifts', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def jewelry
    redirect_to products_url(:department => 'jewelry')
    #@jewelry_grid = initialize_grid(Product.where(store: 'jewelry', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def decor
    redirect_to products_url(:department => 'decor')
    #@decor_grid = initialize_grid(Product.where(store: 'decor', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gun_cases
    redirect_to products_url(:department => 'gun_cases')
    #@gun_cases_grid = initialize_grid(Product.where(store: 'gun_cases', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def guns
    redirect_to products_url(:department => 'guns')
    #@guns_grid = initialize_grid(Product.where(store: 'guns', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def custom_parts
    redirect_to products_url(:department => 'custom_parts')
    #@custom_parts_grid = initialize_grid(Product.where(store: 'custom_parts', active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def new_arrivals
    redirect_to products_url(:qorder => 't')
    #@products = Product.where(active: true).limit(60).order('created_at DESC')
    #@range = @products.last.created_at..@products.first.created_at
    #@new_arrivals_grid = initialize_grid(Product.where(active: true, created_at: @range), order: 'products.created_at', order_direction: 'desc', per_page: 20)
  end

  def sale_items
    redirect_to products_url(:qsale => 't')
    #@sales_grid = initialize_grid(Product.where(sale: true, active: true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def privacy_policy
  end

  def return_policy
  end

  def terms_and_conditions
  end

  def payment_policy
  end

  def shipping_policy
  end

  def sales_tax
  end

  def contact
  end

  def update_on_sale
    @product.update_on_sale
  end

  def filtering_params(params)
    params.slice(:department, :search, :qmodel, :qmanufacturer, :qpart_number,
                 :qmaterial, :qcaliber, :qbarrel_length, :qtype_field,
                 :qstyle_field, :qfield_of_view_low_power, :qsale,
                 :qfield_of_view_high_power, :qdiopter_adjustment, :qeye_relief,
                 :qexit_pupil_low_power,:qexit_pupil_high_power,
                 :qelevation_travel, :qwindage_travel, :qmoa_per_click_upper,
                 :qmoa_per_click_lower, :qparallax_compensation, :qtotal_travel,
                 :qtube_diameter, :qposition_of_reticle, :qavailable_reticles)
  end

  # GET /products/1
  def show
    @item = Item.new
    @photos = @product.photos.all
  end

  # GET /products/new
  def new
    @product = Product.new
    @photos = @product.photos.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      save_attachments if params[:photos]
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    update_attachments if params[:photos]
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.photos.each(&:destroy)
    @product.destroy
    redirect_to product_management_path, notice: 'Product was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(:title, :manufacturer, :model,
                                    :part_number, :price, :quantity,
                                    :description, :images, :schematic,
                                    :weight, :height, :width, :length, :tags,
                                    :categories, :exclusive, :store, :material,
                                    :caliber, :barrel_length, :type_field,
                                    :style_field, :active, :shipped_by, :sale,
                                    :sale_price, :field_of_view_low_power,
                                    :field_of_view_high_power,
                                    :diopter_adjustment, :eye_relief,
                                    :exit_pupil_low_power,
                                    :exit_pupil_high_power, :elevation_travel,
                                    :windage_travel, :moa_per_click_upper,
                                    :moa_per_click_lower,
                                    :parallax_compensation, :total_travel,
                                    :tube_diameter, :position_of_reticle,
                                    :available_reticles,
                                    :sale_end,
                                    :shipper_id, :has_box,
                                    :shipping_height, :shipping_width,
                                    :shipping_length, :shipping_weight,
                                    product_attachments_attributes:
                                      [:id, :product_id, :image])
  end

  def save_attachments
    params[:photos]['image'].each do |a|
      @photo = @product.photos.create!(image: a, product_id: @product.id)
    end
  end

  def update_attachments
    @product.photos.each(&:destroy) if @product.photos.present?
    params[:photos]['image'].each do |a|
      @photo = @product.photos.create!(image: a, product_id: @product.id)
    end
 end
end
