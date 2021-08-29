class CommentController < ApplicationController
  include ActionController::HttpAuthentication::Token

  def create
    user_id = authenticate_user
    comment = Comment.new(comment_params.merge(user_id: user_id))
    if comment.save
      render json: { message: 'added successfully' }, status: :created
    else
      render json: { error: comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user_id = authenticate_user.to_i
    creator_id = Comment.find(params[:id]).user_id
    if user_id != creator_id
      render status: :unauthorized
    else
      Comment.find(params[:id]).destroy!
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

  def comment_params
    params.require(:comment).permit(:content, :ad_id)
  end
end
