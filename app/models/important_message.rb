class ImportantMessage < ApplicationRecord
  belongs_to :app
  validates_presence_of :body
  validates_presence_of :subject
end
