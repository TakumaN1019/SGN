class User < ApplicationRecord

  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter, :google_oauth2, :facebook, :stripe_connect]



  has_many :uhoing_relationships, foreign_key: "uhoer_id", class_name: "Relationship", dependent: :destroy
  has_many :uhoings, through: :uhoing_relationships

  # フォローされているユーザーを取り出す（user.uhoersをできるようにする）
  has_many :uhoer_relationships, foreign_key: "uhoing_id", class_name: "Relationship", dependent: :destroy
  has_many :uhoers, through: :uhoer_relationships

  # ウホしているか調べる
  def uhoing?(other_user)
    uhoing_relationships.find_by(uhoing_id: other_user.id)
  end

  # ウホ
  def uho!(other_user)
    uhoing_relationships.create!(uhoing_id: other_user.id)
  end

  # ウホ解除
  def unuho!(other_user)
    uhoing_relationships.find_by(uhoing_id: other_user.id).destroy
  end



  # オリジナルのカスタムバリデーション(日本語化するよりもこっちのほうが自由度が高いので良い)
  validate :add_error_user
  def add_error_user
    # ユーザーネームが20文字以上のときのエラーメッセージ
    if name.present?
      if name.length > 20
        errors[:base] << "ユーザーネームは20文字以内にしてください。"
      end
    end

    # メールアドレスがすでに使われているときのエラーメッセージ
    if User.find_by(email:email)
      if User.find_by(email:email) != User.find(id) # 自分以外のユーザーがメールアドレスを使っているか
を確認。これがなければ自分のメールアドレスに対してもバリデーションしてしまう。
        errors[:base] << "このメールアドレスはすでに使われています。"
      end
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        #image: auth.info.image, #carrierwaveのimage.urlが使えないので画像は保存しない
        name: auth.info.name,
        nickname: auth.info.nickname,
        location: auth.info.location,
      )
    end

    user
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end

