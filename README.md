  # README

  ## アプリケーション概要

  - 「インスタグラム」のクローンアプリケーション


  ## アプリケーションの機能一覧

  - Basic認証機能→まだ
  - ユーザー新規登録機能
  - ユーザーログイン／ログアウト機能
  - ユーザー情報編集機能
  - マイページ表示機能
  - 画像投稿／削除機能
  - コメント機能
  - いいね機能

  ## アプリケーション内で使用している技術一覧
  |種別|名称|
  |------|----|
  |開発言語|Ruby(ver 2.5.1)|
  |フレームワーク|Ruby on Rails(ver 5.2.4.1)|
  |マークアップ|HTML(Haml),CSS(Sass)|
  |DB|sqlite|
  |本番環境|heroku|
  |画像アップロード|carrierwave|
  |自動デプロイ|git push heroku master でok!|
  |ユーザー管理|devise|

  ## データベース

  ## usersテーブル

  |名前|Column|Type|Options|
  |---|------|----|-------|
  |ID|id|integer|null: false|
  |メールアドレス|email|string|null: false, unique: true| 
  |パスワード|encrypted_password|string|null: false|
  |ニックネーム|name|string|null: false|
  |プロフィール写真|profile_photo|integer |null: true|

  ### Association
  - has_many :goods

  ### postsテーブル
  |名前|Column|Type|Options|
  |---|------|----|-------|
  |ID|id|integer|null: false|
  |ユーザーID|user_id|integer|null: false,foreign_key: true|
  |説明文|caption|string|null: false|

  ### Association
  - belongs_to :user
  - has_many :photos
  - has_many :likes
  - has_many :comments

  ### photosテーブル
  |名前|Column|Type|Options|
  |---|------|----|-------|
  |ID|id|integer|null: false|
  |投稿ID|post_id|integer|null: false,foreign_key: true|
  |写真|image|string|null: false|

  ### Association
  - belongs_to :post

  ### likesテーブル
  |名前|Column|Type|Options|
  |---|------|----|-------|
  |ID|id|integer|null: false|
  |投稿ID|post_id|integer|null: false,foreign_key: true|
  |ユーザーID|user_id|integer|null: false,foreign_key: true|

  ### Association
  - belongs_to :post
  - belongs_to :user

  ### comemntsテーブル
  |名前|Column|Type|Options|
  |---|------|----|-------|
  |ID|id|integer|null: false|
  |コメント文|comment|string|null: false|
  |投稿ID|post_id|integer|null: false,foreign_key: true|
  |ユーザーID|user_id|integer|null: false,foreign_key: true|

  ### Association
  - belongs_to :post
  - belongs_to :user