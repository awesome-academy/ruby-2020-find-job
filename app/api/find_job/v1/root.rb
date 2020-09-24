module FindJob
  module V1
    class Root < Grape::API
      mount FindJob::V1::Posts
      mount FindJob::V1::Users
    end
  end
end
