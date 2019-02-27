class Message < ActiveRecord::Base
  belongs_to :app
  validates :body, length: {maximum: 255}
  validates_presence_of :body
end
