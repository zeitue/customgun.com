class ShippersController < ApplicationController
  before_action :set_shipper, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  layout 'store'
  # GET /shippers
  def index
    @shippers = Shipper.all
  end

  # GET /shippers/1
  def show
  end

  # GET /shippers/new
  def new
    @shipper = Shipper.new
  end

  # GET /shippers/1/edit
  def edit
  end

  # POST /shippers
  def create
    @shipper = Shipper.new(shipper_params)

    if @shipper.save
      redirect_to shippers_path, notice: 'Shipper was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /shippers/1
  def update
    if @shipper.update(shipper_params)
      redirect_to shippers_path, notice: 'Shipper was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /shippers/1
  def destroy
    @shipper.destroy
    redirect_to shippers_url, notice: 'Shipper was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      @shipper = Shipper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shipper_params
      params.require(:shipper).permit(:name, :company_name, :scheme, :price, :handling_fee, :up_charge_rate, :address_id, :usps, :fedex, :ups)
    end
end
