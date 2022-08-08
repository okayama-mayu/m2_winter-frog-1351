require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance method' do 
    describe '#plants_within_100' do 
      it 'returns a unique list of plants associated with the garden that can be harveted within 100 days' do 
        # garden
        garden = Garden.create!(name: 'Community Garden', organic: false)

        # plots 
        plot_1 = garden.plots.create!(number: 1, size: "medium", direction: "east")

        plot_2 = garden.plots.create!(number: 2, size: "medium", direction: "east")

        plot_3 = garden.plots.create!(number: 3, size: "medium", direction: "east")

        # plants 
        purple = Plant.create!(name: 'Purple Beauty Sweet Bell Pepper', description: 'likes sun', days_to_harvest: 100)

        crepe = Plant.create!(name: 'Crepe Myrtle', description: 'likes rain', days_to_harvest: 50)
        
        pineapple = Plant.create!(name: 'Pineapple', description: 'sweet', days_to_harvest: 150)

        onion = Plant.create!(name: 'Onion', description: 'peels', days_to_harvest: 30)

        # plot plants (Plot 1)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: purple.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: crepe.id)

        # plot plants (Plot 2)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: crepe.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: onion.id)
        
        # plot plants (Plot 3)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: pineapple.id)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: onion.id)

        expected = [crepe.name, onion.name] 
        actual = garden.plants_within_100.map do |plant| 
          plant.name 
        end

        expect(actual).to eq expected
      end
    end

    describe '#plants_within_100_sorted' do 
      it 'returns a unique list of plants associated with the garden that can be harveted within 100 days that is sorted by the most planted to least planted in that garden' do 
        # garden
        garden = Garden.create!(name: 'Community Garden', organic: false)

        # plots 
        plot_1 = garden.plots.create!(number: 1, size: "medium", direction: "east")

        plot_2 = garden.plots.create!(number: 2, size: "medium", direction: "east")

        plot_3 = garden.plots.create!(number: 3, size: "medium", direction: "east")

        # plants 
        purple = Plant.create!(name: 'Purple Beauty Sweet Bell Pepper', description: 'likes sun', days_to_harvest: 100)

        crepe = Plant.create!(name: 'Crepe Myrtle', description: 'likes rain', days_to_harvest: 50)
        
        pineapple = Plant.create!(name: 'Pineapple', description: 'sweet', days_to_harvest: 40)

        onion = Plant.create!(name: 'Onion', description: 'peels', days_to_harvest: 30)

        # plot plants (Plot 1)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: purple.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: crepe.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: pineapple.id)

        # plot plants (Plot 2)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: crepe.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: pineapple.id)
        
        # plot plants (Plot 3)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: pineapple.id)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: onion.id)

        expected = [pineapple.name, crepe.name, onion.name] 
        actual = garden.plants_within_100_sorted.map do |plant| 
          plant.name 
        end

        expect(actual).to eq expected
      end
    end
  end
end
