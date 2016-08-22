class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :destroy, :products]
  layout "store"


  # GET /products
  def index
    @products = Product.where(:active => true).order("RANDOM()").limit(3)
  end

  def products
    @grid = initialize_grid(Product, include: :photos ,order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gun_parts
    @gun_parts_grid = initialize_grid(Product.where(:store => "gun_parts", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def wood
    @wood_grid = initialize_grid(Product.where(:store => "wood", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def barrels
    @barrels_grid = initialize_grid(Product.where(:store => "barrels", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def optics
    @optics_grid = initialize_grid(Product.where(:store => "optics", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gifts
    @gifts_grid = initialize_grid(Product.where(:store => "gifts", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def jewelry
    @jewelry_grid = initialize_grid(Product.where(:store => "jewelry", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def decor
    @decor_grid = initialize_grid(Product.where(:store => "decor", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def gun_cases
    @gun_cases_grid = initialize_grid(Product.where(:store => "gun_cases", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def guns
    @guns_grid = initialize_grid(Product.where(:store => "guns", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end


  def custom_parts
    @custom_parts_grid = initialize_grid(Product.where(:store => "custom_parts", :active => true), order: 'products.title', order_direction: 'asc', per_page: 20)
  end


  def new_arrivals
    @products = Product.where(:active => true).limit(60).order('created_at DESC')
    @range = @products.last.created_at..@products.first.created_at
    @new_arrivals_grid = initialize_grid(Product.where(:active => true, :created_at => @range), order: 'products.created_at', order_direction: 'desc', per_page: 20)
  end

  def sale_items
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
    @product.photos.each do |x| x.destroy end
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
      params.require(:product).permit(:title, :manufacturer, :model, :part_number, :price, :quantity, :description, :images, :schematic, :weight, :height, :width, :length, :tags, :categories, :exclusive, :store, :material, :caliber, :barrel_length, :type_field, :style_field, :active, :shipped_by, product_attachments_attributes: [:id, :product_id, :image])
    end


def save_attachments
  params[:photos]['image'].each do |a|
  @photo = @product.photos.create!(:image => a, :product_id => @product.id)
  end
end

 def update_attachments
   @product.photos.each(&:destroy) if @product.photos.present?
   params[:photos]['image'].each do |a|
  @photo = @product.photos.create!(:image => a, :product_id => @product.id)
   end
end
end
