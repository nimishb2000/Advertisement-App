class AdsController < ApplicationController
  def index
    render json: Ad.all
  end

  def create
    ad = Ad.new(ad_params)
    if ad.save
      render json: ad, status: :created
    else
      render json: ad.errors, status: :unprocessable_entity
    end
  end

  private

  def ad_params
    params.require(:ad).permit(:content, :creator)
  end

end
