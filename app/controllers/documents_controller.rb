class DocumentsController < ApplicatioonController

  def show
    @documents = Document.find(params[:id])
  end
end
