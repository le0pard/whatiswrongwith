class Answer < ActiveRecord::Base
  
  belongs_to :quote
  
  before_save :set_token
  
  private
  
  def set_token
    self.token = ActiveSupport::SecureRandom.hex(20) if self.token.blank?
  end
  
end
