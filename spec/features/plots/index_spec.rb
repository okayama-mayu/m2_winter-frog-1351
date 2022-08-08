require 'rails_helper' 

RSpec.describe 'Plots Index Page', type: :feature do 
  # User Story 1, Plots Index Page
  # As a visitor
  # When I visit the plots index page ('/plots')
  # I see a list of all plot numbers
  # And under each plot number I see names of all that plot's plants
  it 'lists all plot numbers and all plots plants' do 
    # garden
    garden = Garden.create!(name: 'Community Garden', organic: false)

    # plots 
    plot_1 = garden.plots.create!(number: 1, size: "medium", direction: "east")

    plot_2 = garden.plots.create!(number: 2, size: "medium", direction: "east")

    plot_3 = garden.plots.create!(number: 3, size: "medium", direction: "east")

    # plants 
    purple = Plant.create!(name: 'Purple Beauty Sweet Bell Pepper', description: 'likes sun', days_to_harvest: 10)

    crepe = Plant.create!(name: 'Crepe Myrtle', description: 'likes rain', days_to_harvest: 50)
    
    pineapple = Plant.create!(name: 'Pineapple', description: 'sweet', days_to_harvest: 15)

    onion = Plant.create!(name: 'Onion', description: 'peels', days_to_harvest: 30)

    # plot plants (Plot 1)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: purple.id)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: pineapple.id)

    # plot plants (Plot 2)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: crepe.id)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: pineapple.id)
    
    # plot plants (Plot 3)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: pineapple.id)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: onion.id)

    visit plots_path

    within('#plot-0') do 
      expect(page).to have_content('Plot Number: 1')
      expect(page).to_not have_content('Plot Number: 2')

      within('#plot-plants-0') do 
        expect(page).to have_content(purple.name)
        expect(page).to have_content(pineapple.name)
        expect(page).to_not have_content(crepe.name)
      end
    end

    within('#plot-1') do 
      expect(page).to have_content('Plot Number: 2')
      expect(page).to_not have_content('Plot Number: 3')

      within('#plot-plants-1') do 
        expect(page).to have_content(crepe.name)
        expect(page).to have_content(pineapple.name)
        expect(page).to_not have_content(onion.name)
      end
    end
    
    within('#plot-2') do 
      expect(page).to have_content('Plot Number: 3')
      expect(page).to_not have_content('Plot Number: 1')

      within('#plot-plants-2') do 
        expect(page).to have_content(pineapple.name)
        expect(page).to have_content(onion.name)
        expect(page).to_not have_content(purple.name)
      end
    end
  end

  # User Story 2, Remove a Plant from a Plot
  # As a visitor
  # When I visit a plot's index page
  # Next to each plant's name
  # I see a link to remove that plant from that plot
  it 'has links to remove the plan from the plot' do 
    # garden
    garden = Garden.create!(name: 'Community Garden', organic: false)

    # plots 
    plot_1 = garden.plots.create!(number: 1, size: "medium", direction: "east")

    plot_2 = garden.plots.create!(number: 2, size: "medium", direction: "east")

    plot_3 = garden.plots.create!(number: 3, size: "medium", direction: "east")

    # plants 
    purple = Plant.create!(name: 'Purple Beauty Sweet Bell Pepper', description: 'likes sun', days_to_harvest: 10)

    crepe = Plant.create!(name: 'Crepe Myrtle', description: 'likes rain', days_to_harvest: 50)
    
    pineapple = Plant.create!(name: 'Pineapple', description: 'sweet', days_to_harvest: 15)

    onion = Plant.create!(name: 'Onion', description: 'peels', days_to_harvest: 30)

    # plot plants (Plot 1)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: purple.id)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: pineapple.id)

    # plot plants (Plot 2)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: crepe.id)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: pineapple.id)
    
    # plot plants (Plot 3)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: pineapple.id)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: onion.id)

    visit plots_path

    within('#plot-0') do 
      within('#plot-plants-0-plant-0') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end

      within('#plot-plants-0-plant-1') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end
    end
    
    within('#plot-1') do
      within('#plot-plants-1-plant-0') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end
      
      within('#plot-plants-1-plant-1') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end
    end 

    within('#plot-2') do
      within('#plot-plants-2-plant-0') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end

      within('#plot-plants-2-plant-1') do 
        expect(page).to have_link('Remove Plant from Plot', count: 1)
      end
    end
  end

  # When I click on that link
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot
  # (Note: you should not destroy the plant record entirely)
  it 'has a link to delete a plant from the plot and redirects to the Plots Index' do 
    # garden
    garden = Garden.create!(name: 'Community Garden', organic: false)

    # plots 
    plot_1 = garden.plots.create!(number: 1, size: "medium", direction: "east")

    plot_2 = garden.plots.create!(number: 2, size: "medium", direction: "east")

    plot_3 = garden.plots.create!(number: 3, size: "medium", direction: "east")

    # plants 
    purple = Plant.create!(name: 'Purple Beauty Sweet Bell Pepper', description: 'likes sun', days_to_harvest: 10)

    crepe = Plant.create!(name: 'Crepe Myrtle', description: 'likes rain', days_to_harvest: 50)
    
    pineapple = Plant.create!(name: 'Pineapple', description: 'sweet', days_to_harvest: 15)

    onion = Plant.create!(name: 'Onion', description: 'peels', days_to_harvest: 30)

    # plot plants (Plot 1)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: purple.id)
    PlotPlant.create!(plot_id: plot_1.id, plant_id: pineapple.id)

    # plot plants (Plot 2)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: crepe.id)
    PlotPlant.create!(plot_id: plot_2.id, plant_id: pineapple.id)
    
    # plot plants (Plot 3)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: pineapple.id)
    PlotPlant.create!(plot_id: plot_3.id, plant_id: onion.id)

    visit plots_path

    within('#plot-0') do 
      within('#plot-plants-0-plant-0') do 
        click_link('Remove Plant from Plot')
      end
    end

    expect(current_path).to eq plots_path

    within('#plot-0') do 
      within('#plot-plants-0') do 
        expect(page).to_not have_content(purple.name)
        expect(page).to have_content(pineapple.name)
      end
    end
  end
end