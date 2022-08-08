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
end