class LikesController < ApplicationController

  before_action :authenticate_user!
  # サインイン済みユーザーのみにアクセス許可を与える

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
      # permitで変更を加えられるpost_idキーを指定。
      # いいねを押したときに、どの投稿にいいねを押したのかpost_idの情報を変更できるように指定
    end
end