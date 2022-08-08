class PlotPlantsController < ApplicationController 
  def destroy 
    plot_plant = PlotPlant.find(params[:id])
    plot_plant.destroy 

    redirect_to plots_path
  end
end