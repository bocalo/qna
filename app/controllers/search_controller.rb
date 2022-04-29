class SearchController < ApplicationController
  skip_authorization_check
  
  def index
    @result = Services::Search.search_by(params[:body], params[:type])
  end
end
