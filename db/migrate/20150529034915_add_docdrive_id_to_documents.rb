class AddDocdriveIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :docdrive_id, :string
  end
end
