class Admin::BaseController < ApplicationController
  abstract!
  
  before_filter :require_user
  
  layout 'admin'
  
end
