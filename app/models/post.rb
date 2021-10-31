class Post < ApplicationRecord
  belongs_to :user
  has_many :likes

  def get_liked_user
    return User.where(:id => self.likes.pluck('user_id')).pluck('name')
  end
end
