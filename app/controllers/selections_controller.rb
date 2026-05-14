class SelectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kukai

  def create
    post = @kukai.posts.find(params[:post_id])
    @selection = current_user.selections.build(post: post, kukai: @kukai)

    if @selection.save
      @post = post
      @selected_count = current_user.selections.where(kukai: @kukai).count
    else
      @error = @selection.errors.full_messages.first
    end
  end

  def destroy
    @selection = current_user.selections.find(params[:id])
    @post = @selection.post
    @selection.destroy
    @selected_count = current_user.selections.where(kukai: @kukai).count
  end

  private

  def set_kukai
    @kukai = Kukai.find(params[:kukai_id])
  end
end
