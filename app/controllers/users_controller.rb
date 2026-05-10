class UsersController < ApplicationController
  def index
    @users = User
               .left_joins(:posts)
               .select("users.*, COUNT(posts.id) AS posts_count")
               .group("users.id")
               .order(Arel.sql("COUNT(posts.id) DESC"), :nickname)
  end
end
