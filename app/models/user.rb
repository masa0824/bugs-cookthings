class User < ApplicationRecord
    # 参考：https://qiita.com/apukasukabian/items/62622b7ce75fe469aca3
    #has_secure_password
    has_secure_password validations: false

    #バリデーションの定義
    MaxLength1 = 255
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        uniqueness: true,
        length: { maximum: MaxLength1 },
        format: { with: VALID_EMAIL_REGEX }

    validates :password,
        presence: true,
        on: :create

    validates :last_name,
        length: { maximum: MaxLength1 }

    validates :first_name,
        length: { maximum: MaxLength1 }
end
