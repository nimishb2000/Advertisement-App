class AdController < ApplicationController
  def index
    render json: Ad.all
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
