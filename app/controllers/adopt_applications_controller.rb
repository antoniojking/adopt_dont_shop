class AdoptApplicationsController < ApplicationController
  def show
    @application = AdoptApplication.find(params[:id])
  end
end
