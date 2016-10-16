class AddSaleSalePriceFieldOfViewLowPowerFieldOfViewHighPowerDiopterAdjustmentEyeReliefExitPupilLowPowerExitPupilHighPowerElevationTravelToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale, :boolean, default: false
    add_column :products, :sale_price, :float
    add_column :products, :field_of_view_low_power, :float
    add_column :products, :field_of_view_high_power, :float
    add_column :products, :diopter_adjustment, :string
    add_column :products, :eye_relief, :float
    add_column :products, :exit_pupil_low_power, :float
    add_column :products, :exit_pupil_high_power, :float
    add_column :products, :elevation_travel, :string
    add_column :products, :windage_travel, :string
  end
end
