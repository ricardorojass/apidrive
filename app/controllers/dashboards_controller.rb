class DashboardsController < ApplicationController
  def show
    @document = Document.new
    @documents = current_user.documents
  end
end
