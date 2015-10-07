class Document < ActiveRecord::Base
  belongs_to :user
  default_scope { order("created_at DESC") }
  validates :title, presence: true

  def doc_url
    id = self.document.docdrive_id
    "https://docs.google.com/document/d/#{id}/edit"
  end
end
