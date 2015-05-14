class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
  end

  def create
    document = current_user.documents.build(document_parameters)
    if document.save
      redirect_to dashboard_path
    else
      flash.alert = "Fuck!!"
      redirect_to dashboard_path
    end
  end

  private

  def document_parameters
    params.require(:document).permit(:title)
  end
end
