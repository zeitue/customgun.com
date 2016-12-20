class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :destroy, :index]
  layout 'store'
  # GET /boxes
  def index
    @boxes = Box.all
  end

  # GET /boxes/1
  def show
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  def create
    @box = Box.new(box_params)

    if @box.save
      redirect_to @box, notice: 'Box was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /boxes/1
  def update
    if @box.update(box_params)
      redirect_to @box, notice: 'Box was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /boxes/1
  def destroy
    @box.destroy
    redirect_to boxes_url, notice: 'Box was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_box
    @box = Box.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def box_params
    params.require(:box).permit(:provider, :length, :height, :width, :weight)
  end
end
