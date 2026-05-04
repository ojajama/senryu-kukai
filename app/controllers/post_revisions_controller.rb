class PostRevisionsController < ApplicationController
  def show
    @revision = PostRevision.find(params[:id])
  end
end
