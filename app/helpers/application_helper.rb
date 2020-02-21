module ApplicationHelper

  def avatar_url(user)
    return user.profile_photo unless user.profile_photo.nil?
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
    # 上記のコードは、user.profile_photoカラムがnilでなければ、user.profile_photoを返すという意味。
    # ビューで<%= image_tag avatar_url(@user) %>とコードを書いてあげれば、profile_photoカラムに値がなければGravatarからアイコンを持ってくる。
  end

end
