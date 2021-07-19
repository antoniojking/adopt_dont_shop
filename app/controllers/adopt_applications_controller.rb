class AdoptApplicationsController < ApplicationController
  def show
    @application = AdoptApplication.find(params[:id])
  end

  def new
  end

  def create
    @application = AdoptApplication.new(adopt_application_params)
  end

  private
  def adopt_application_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :description)
  end
end
