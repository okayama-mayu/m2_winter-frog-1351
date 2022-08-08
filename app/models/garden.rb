class Garden < ApplicationRecord
  has_many :plots

  def plants_within_100
    plots
    .joins(:plants)
    .where('plants.days_to_harvest < 100')
    .select('plants.name as name, plants.id as plant_id').group('plants.id')
  end
end
