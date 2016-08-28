class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :edit, :update, :create, :destroy]
  layout 'store'

  def index
  end

  # GET /shipments/new
  def new
    @shipment = Shipment.new
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /boxes
  def create
    @shipment = Shipment.new(shipment_params)

    if @shipment.save
      redirect_to order_path, notice: 'Shipment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /shipments/1
  def update
    if @shipment.update(shipment_params)
      redirect_to orders_path, notice: 'Shipment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /shipments/1
  def destroy
    @shipment.destroy
    redirect_to shipments_url, notice: 'Shipment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shipment_params
      params.require(:shipment).permit(:tracking)
    end
end
