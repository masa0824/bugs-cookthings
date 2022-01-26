class User < ApplicationRecord
    has_secure_password

    #バリデーションの定義
    MaxLength1 = 255
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        length: { maximum: MaxLength1 },
        format: { with: VALID_EMAIL_REGEX }

    #validates :password,
    #    presence: true
end
