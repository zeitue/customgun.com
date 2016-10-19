class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  #before_action :check_owner, only: [:show, :edit, :update, :destroy]
  layout 'store'


  # GET /addresses
  def index
    @addresses = Address.where(user_id: current_user.id)
  end

  # GET /addresses/1
  def show
    check_ownership(@address)
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    check_ownership(@address)
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      if params[:address_select]
        redirect_to address_select_path, notice: 'Address was successfully created.'
      else
        redirect_to addresses_path, notice: 'Address was successfully created.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    check_ownership(@address)
    if @address.update(address_params)
      if params[:address_select]
        redirect_to address_select_path, notice: 'Address was successfully updated.'
      else
        redirect_to addresses_path, notice: 'Address was successfully updated.'
      end
    else
      render :edit
    end
  end

  # DELETE /addresses/1
  def destroy
    check_ownership(@address)
    @address.destroy
    if params[:address_select]
      redirect_to address_select_path, notice: 'Address was successfully destroyed.'
    else
      redirect_to addresses_path, notice: 'Address was successfully destroyed.'
    end
  end

  private

    #def check_owner
     # if !owns_address? || !current_user.admin
     #   redirect_to products_path, alert: "Operation failed: Permission denied"
    #  end
  #  end

    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    def owns_address?
      @address.user_id == current_user.id
    end


    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :address_line1, :address_line2, :country, :state, :city, :zip, :phone, :fax, :company, :user_id)
    end
end
