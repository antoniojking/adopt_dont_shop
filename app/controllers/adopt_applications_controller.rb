class AdoptApplicationsController < ApplicationController
  def index
    @applications = AdoptApplication.all
  end

  def show
    @application = AdoptApplication.find(params[:id])
  end

  def new

  end

  def create
    @application = AdoptApplication.create!(adopt_application_params)
    
    redirect_to "/adopt_applications/#{@application.id}"
  end

  private
  def adopt_application_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :description)
  end
end
