module YC
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::YC::Ping
  end
end
