require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { categories: @product.categories, description: @product.description, exclusive: @product.exclusive, height: @product.height, images: @product.images, length: @product.length, manufacturer: @product.manufacturer, model: @product.model, part_number: @product.part_number, price: @product.price, quantity: @product.quantity, schematic: @product.schematic, tags: @product.tags, title: @product.title, weight: @product.weight, width: @product.width }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { categories: @product.categories, description: @product.description, exclusive: @product.exclusive, height: @product.height, images: @product.images, length: @product.length, manufacturer: @product.manufacturer, model: @product.model, part_number: @product.part_number, price: @product.price, quantity: @product.quantity, schematic: @product.schematic, tags: @product.tags, title: @product.title, weight: @product.weight, width: @product.width }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
