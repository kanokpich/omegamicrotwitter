class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :password, presence: true, length: {minimum: 8}
    has_secure_password
end
