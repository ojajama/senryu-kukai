class UserPostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:kukai, :keyword).order(created_at: :desc)
  end
end
