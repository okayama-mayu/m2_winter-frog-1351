require 'rails_helper' 

RSpec.describe 'Gardens Show Page', type: :feature do 
  # User Story 3, Garden's Plants
  # As a visitor
  # When I visit an garden's show page
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest
  it 'shows a list of unique plants in the garden that take less than 100 days to harvest' do 
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

    visit garden_path(garden)

    expect(page).to have_content(crepe.name, count: 1)
    expect(page).to have_content(onion.name, count: 1)

    expect(page).to_not have_content(purple.name)
    expect(page).to_not have_content(pineapple.name)
  end

  # Extension,
  # As a visitor
  # When I visit a garden's show page,
  # Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
  # (Note: you should only make 1 database query to retrieve the sorted list of plants)
  it 'shows the list of plants sorted by the number of times it appears in the garden' do 
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

    visit garden_path(garden)

    within('#plant-0') do 
      expect(page).to have_content(pineapple.name)
    end
    
    within('#plant-1') do 
      expect(page).to have_content(crepe.name)
    end
    
    within('#plant-2') do 
      expect(page).to have_content(onion.name)
    end

    expect(page).to_not have_content(purple.name)
  end
end