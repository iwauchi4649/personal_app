class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  # 投稿が削除されたら、その投稿に紐づくいいねも削除
  has_many :comments, dependent: :destroy
  # 投稿が削除されたら、その投稿に紐づくコメントも削除
  accepts_nested_attributes_for :photos
  # accepts_nested_attributes_forは、親子関係のある関連モデル(今回でいうとPostモデルとPhotoモデル）で、親から子を作成したり保存するときに使える

  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索する。なければnilを返す
    Like.find_by(user_id: user.id, post_id: id)
  end
end
