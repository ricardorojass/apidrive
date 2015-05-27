require 'google/api_client'
require 'google_drive'

@client = Google::APIClient.new(application_name: 'Ricardo-test', application_version: '0.0.1')
key = Google::APIClient::KeyUtils.load_from_pkcs12(
    'apidrive-dab6d61ad693.p12',
    'notasecret')

asserter = Google::APIClient::JWTAsserter.new(
    '61507663961-b78schoisjda8qq5h16g5jkm124ejkr6@developer.gserviceaccount.com',
    ['https://www.googleapis.com/auth/drive'],
    key
)
@client.authorization = asserter.authorize
@session = GoogleDrive.login_with_oauth(@client.authorization.access_token)

for file in @session.files
  p file.title
end
