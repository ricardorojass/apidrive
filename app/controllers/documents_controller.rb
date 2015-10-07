class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
  end

  def create
    document = current_user.documents.build(document_parameters)
    if document.save

      @client = Google::APIClient.new(application_name: 'Ricardo-test', application_version: '0.0.1')

      google_client_email = '61507663961-b78schoisjda8qq5h16g5jkm124ejkr6@developer.gserviceaccount.com'
      google_p12_file = 'apidrive-dab6d61ad693.p12'
      google_p12_secret = 'notasecret'

      key = Google::APIClient::KeyUtils.load_from_pkcs12(
        google_p12_file,
        google_p12_secret
      )

      scopes = [
        'https://www.googleapis.com/auth/drive'
      ]

      asserter = Google::APIClient::JWTAsserter.new(
        google_client_email,
        scopes,
        key
      )
      @client.authorization = asserter.authorize
      @session = GoogleDrive.login_with_oauth(@client.authorization.access_token)

      puts "Session: #{@client.authorization.access_token}"
      mimeType = "application/vnd.google-apps.document"


      response = Unirest.post "https://www.googleapis.com/drive/v2/files?convert=true",
        headers:{"Authorization" => "Bearer #{@client.authorization.access_token}", "Content-Type" => "application/json"},
        parameters: {title: "docs-test", mimeType: mimeType }.to_json

      drive_id = response.body['id']
      document.docdrive_id = drive_id
      document.save
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
