class AdoptApplicationsController < ApplicationController
  def show
    @application = AdoptApplication.find(params[:id])
  end

  def new
  end
end
