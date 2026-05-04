class UserPostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
                  .includes(:user, :keyword, :kukai, :likes, comments: :user)
                  .order(created_at: :desc)
  end
end
