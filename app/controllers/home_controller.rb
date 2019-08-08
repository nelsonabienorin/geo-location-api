class HomeController < ApplicationController
  def index
    render json: {message: 'welcome to geo-location api'}, status: 200
  end
end