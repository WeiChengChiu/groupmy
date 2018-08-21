class Message < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  def user_identify
    self.user.try(:name) || '遊客'
  end
end
