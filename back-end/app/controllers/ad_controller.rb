class AdController < ApplicationController
  include ActionController::HttpAuthentication::Token

  def index
    ads = Ad.all
    render json: AdRepresenter.new(ads).as_json
  end

  def create
    user_id = authenticate_user
    ad = Ad.new(ad_params.merge({user_id: user_id}))
    if ad.save
      render json: { message: 'added successfully' }, status: :created
    else
      render json: { error: ad.errors }, status: :unprocessable_entity
    end
  end

  def show
    ad = Ad.find(params[:id])
    comments = ad.comment
    if ad && comments
      render json: { ad: ad, comments: comments}
    else
      render json: ad.errors, status: :unprocessable_entity
    end
  end

  def destroy
    binding.irb
    user_id = authenticate_user.to_i
    creator_id = Ad.find(params[:id]).user_id
    if user_id != creator_id
      render status: :unauthorized
    else
      Ad.find(params[:id]).destroy!
      render json: { message: 'removed successfully' }
    end
  end

  private
  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.check(token)
    user_id
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def ad_params
    params.require(:ad).permit(:title, :desc)
  end
end
