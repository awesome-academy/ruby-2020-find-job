class API < Grape::API
  prefix :api
  format :json
  error_formatter :json, ErrorFormatter

  mount FindJob::V1::Root
end
