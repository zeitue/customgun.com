class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:show, :edit, :update, :destroy]
  layout 'store'
  # GET /addresses
  def index
    @addresses = Address.where(user_id: current_user.id)
  end

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      redirect_to addresses_path, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  private

    def check_owner
      if !owns_address?
        redirect_to products_path, alert: "Operation failed: Permission denied"
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    def owns_address?
      @address.user_id == current_user.id
    end


    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:name, :address_line1, :address_line2, :country, :state, :city, :zip, :phone, :user_id)
    end
end
