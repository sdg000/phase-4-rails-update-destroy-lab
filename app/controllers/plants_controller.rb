class PlantsController < ApplicationController

  #general response to RecordNotFound - returns private method(render_no_plant_response)
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_plant_response

  #wrap parameters
  wrap_parameters format: {}



  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  end

  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end



  private
  
  #private reusable method for permitting specific symbols used in creating / Updating Instances
  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  #private reusable method to find Bird Instance
  def find_plant
    Plant.find(params[:id])
  end

  #private reusable method to nandle "no_found" json response
  def render_no_plant_response
    render json: {error: "data not found"}, status: :not_found
  end
end
