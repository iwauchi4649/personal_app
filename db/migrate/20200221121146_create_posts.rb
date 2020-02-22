class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :caption
      t.references :user, foreign_key: true, null: false
      # references型はカラム名+"_id"がテーブル名として設定される。今回postsテーブルにはuser_idというカラムが追加される。
      # foreign_key: trueは外部キーとして使用する
      t.timestamps
    end
  end
end
