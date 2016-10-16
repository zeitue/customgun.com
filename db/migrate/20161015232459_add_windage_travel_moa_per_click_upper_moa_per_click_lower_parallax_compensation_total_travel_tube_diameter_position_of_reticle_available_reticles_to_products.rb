class AddWindageTravelMoaPerClickUpperMoaPerClickLowerParallaxCompensationTotalTravelTubeDiameterPositionOfReticleAvailableReticlesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :moa_per_click_upper, :float
    add_column :products, :moa_per_click_lower, :float
    add_column :products, :parallax_compensation, :boolean, default: false
    add_column :products, :total_travel, :string
    add_column :products, :tube_diameter, :float
    add_column :products, :position_of_reticle, :string
    add_column :products, :available_reticles, :string
  end
end
