class Quote < ActiveRecord::Base
  
  define_index do
    indexes content

    has created_at, updated_at
  end
  
end
