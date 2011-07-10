class Quote < ActiveRecord::Base
  
  validates :content, :presence => true, :length => { :maximum => 2000 }
  validates :source, :presence => true, :length => { :maximum => 150 }
  
  define_index do
    indexes content

    has created_at, updated_at
  end
  
end
