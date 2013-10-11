class HomeController < ApplicationController
  layout 'home'
  def index
    @user = User.new
  end
end
