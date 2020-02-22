class PostsController < ApplicationController

  before_action :authenticate_user!
  # サインインしていない状態でnewアクションやcreateアクションを実行しようとすると、サインインページにリダイレクトされる。
  before_action :set_post, only: %i(show destroy)

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

  def index
    @posts = Post.includes(:photos, :user).limit(10).order('created_at DESC')
  end

  def show
    @post
    # 受け取ったHTTPリクエストからidを判別し、指定のレコード1つを@postに代入
  end

  def destroy
    @post
    if @post.user == current_user
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end


  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      # paramsとは送られてきたリクエスト情報をひとまとめにしたもの。
      # requireで受け取る値のキーを設定。
      # permitで変更を加えられるキーを指定。今回の場合、captionキーとimageキーを指定。
      # mergeメソッドは2つのハッシュを統合するメソッド。今回は誰が投稿したかという情報が必要なためuser_idの情報を統合。
    end

    def set_post
      @post = Post.find_by(id: params[:id])
      # 重複するコードがあると冗長なので、before_actionを使ってshowアクションとdestroyアクションが呼ばれる前に@postを読み込むように書き換える。
    end
end
