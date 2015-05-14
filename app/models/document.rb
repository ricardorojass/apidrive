class Document < ActiveRecord::Base
  belongs_to :user
  default_scope { order("created_at DESC") }
  validates :title, presence: true
end
