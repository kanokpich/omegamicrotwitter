class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :password_digest, presence: true, length: {minimum: 8}, confirmation: true
    has_secure_password
    validates_confirmation_of :password

    has_many :posts
    has_many :follower, class_name: 'Follow', foreign_key: 'follower_id'
    has_many :followee, class_name: 'Follow', foreign_key: 'followee_id'
end
