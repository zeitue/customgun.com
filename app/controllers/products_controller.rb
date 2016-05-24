class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]


layout "store"


  # GET /products
  def index
    @products_grid = initialize_grid(Product.where(:store => "gun_parts"), order: 'products.title', order_direction: 'asc', per_page: 20)
    @products = Product.all
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

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      params[:photos]['image'].each do |a|
        @photo = @product.photos.create!(:image => a, :product_id => @product.id)
      end
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
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
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:title, :manufacturer, :model, :part_number, :price, :quantity, :description, :images, :schematic, :weight, :height, :width, :length, :tags, :categories, :exclusive, :store, product_attachments_attributes: [:id, :product_id, :image])
    end
end
