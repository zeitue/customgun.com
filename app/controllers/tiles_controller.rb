class TilesController < ApplicationController
  before_action :set_tile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  layout 'store'
  # GET /tiles
  def index
    @tiles = Tile.all
  end

  # GET /tiles/1
  def show
  end

  # GET /tiles/new
  def new
    @tile = Tile.new
  end

  # GET /tiles/1/edit
  def edit
  end

  # POST /tiles
  def create
    @tile = Tile.new(tile_params)

    if @tile.save
      redirect_to @tile, notice: 'Tile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tiles/1
  def update
    if @tile.update(tile_params)
      redirect_to @tile, notice: 'Tile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tiles/1
  def destroy
    @tile.destroy
    redirect_to tiles_url, notice: 'Tile was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tile
      @tile = Tile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tile_params
      params.require(:tile).permit(:title, :text, :url, :group, :image, :show)
    end
end
