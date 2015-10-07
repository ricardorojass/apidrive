require 'google/api_client'
require 'google_drive'
require 'unirest'

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

for file in @session.files
  p file
end
