class User < ApplicationRecord
    #has_secure_password
    has_secure_password validations: false

    attr_accessor :activation_token, :reset_token

    #バリデーションの定義
    MaxLength1 = 255
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        uniqueness: true,
        length: { maximum: MaxLength1 },
        format: { with: VALID_EMAIL_REGEX },
        on: :change_userinfo

    validates :email,
        presence: true,
        uniqueness: false,
        length: { maximum: MaxLength1 },
        format: { with: VALID_EMAIL_REGEX },
        on: :reset_password

    validates :password,
        presence: true,
        on: :change_password

    validates :last_name,
        length: { maximum: MaxLength1 },
        on: :change_userinfo

    validates :first_name,
        length: { maximum: MaxLength1 },
        on: :change_userinfo

    # アカウント登録時のアクティベーション
    def create_activation_digest
        self.activation_token = User.new_token
        update_attribute(:activation_digest,  User.digest(activation_token))
        update_attribute(:activated_at, Time.zone.now)
        SystemMailer.account_activation_mail(self).deliver_now
    end
    
    # パスワード再設定の属性を設定する
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # パスワード再設定用メールを送信する
    def send_password_reset_email
        self.reset_token
        SystemMailer.reset_password_mail(self).deliver_now
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # トークンがダイジェストと一致したらtrueを返す
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # パスワード再発行の有効期限
    def password_reset_expired?
        #reset_sent_at < 2.hours.ago
        num = ENV['MYAPP_EXPIRATION_MINUTES_RESET_PASSWORD'].to_i
        reset_sent_at < num.minutes.ago
    end
end
