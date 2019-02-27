class Api::V1::ApiDocsController < Api::V1::BaseController
  # skip_before_filter :authenticate_api_key

  def index
    if Rails.env.production?
      @url = "portal.managedapps.co/assets/apidocs/api-docs.json"
    else
      @url = "http://localhost:3333/apidocs/api-docs.json"
    end
  end
end