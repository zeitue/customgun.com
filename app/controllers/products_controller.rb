class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]


layout "store"


  # GET /products
  def index
    @products_grid = initialize_grid(Product.where(:store => "gun_parts"), include: :photos ,order: 'products.title', order_direction: 'asc', per_page: 20)
    @products = Product.all
  end

  def gun_parts
    @gun_parts_grid = initialize_grid(Product.where(:store => "gun_parts"), order: 'products.title', order_direction: 'asc', per_page: 20)
  end

  def wood

  end

  def barrels

  end

  def optics

  end

  def gifts

  end

  def jewelry

  end

  def decor

  end

  def gun_cases

  end

  # GET /products/1
  def show
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


def create
  @product = Product.new(product_params)
  if @product.save
    save_attachments if params[:photos]
    redirect_to @product, notice: 'Product was successfully created.'
  else
    render :new
  end
end


def update
  update_attachments if params[:photos]
  if @product.update(product_params)
    redirect_to @product, notice: 'Product was successfully updated.'
  else
   render :edit
  end
end


  # POST /products
#  def create
#    @product = Product.new(product_params)
#
#    if @product.save
#     if !params[:photos].nil?
#         params[:photos]['image'].each do |a|
#        @photo = @product.photos.create!(:image => a, :product_id => @product.id)
#     end
#    end
#      redirect_to @product, notice: 'Product was successfully created.'
#    else
#      render :new
#    end
#  end

  # PATCH/PUT /products/1
#  def update
#    if @product.update(product_params)
#      redirect_to @product, notice: 'Product was successfully updated.'
#    else
#      render :edit
#    end
#  end

  # DELETE /products/1
  def destroy
    @product.photos.each do |x| x.destroy end
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:title, :manufacturer, :model, :part_number, :price, :quantity, :description, :images, :schematic, :weight, :height, :width, :length, :tags, :categories, :exclusive, :store, :material, :caliber, :barrel_length,  product_attachments_attributes: [:id, :product_id, :image])
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
