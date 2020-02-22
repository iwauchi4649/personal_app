class PostsController < ApplicationController

  before_action :authenticate_user!
  # サインインしていない状態でnewアクションやcreateアクションを実行しようとすると、サインインページにリダイレクトされる。

  def new
    # newはインスタンスを作成するメソッド
    # またbuildもnewと同じくインスタンスを作成するメソッド
    # ただRailsの慣習でPostモデルとPhotoモデルの関連付けしたときにbuildを使う
    @post = Post.new
    @post.photos.build
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      # paramsとは送られてきたリクエスト情報をひとまとめにしたもの。
      # requireで受け取る値のキーを設定。
      # permitで変更を加えられるキーを指定。今回の場合、captionキーとimageキーを指定。
      # mergeメソッドは2つのハッシュを統合するメソッド。今回は誰が投稿したかという情報が必要なためuser_idの情報を統合。
    end
end
