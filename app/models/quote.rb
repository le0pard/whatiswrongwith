class Quote < ActiveRecord::Base
  
  validates :content, :presence => true, :length => { :maximum => 2000 }
  validates :source, :presence => true, :length => { :maximum => 150 }
  
  define_index do
    indexes content

    has created_at, updated_at
  end
  
  
  
  def self.find_best_quote(text)
    text_array = text.split(" ")
    if text_array.length > 1
      quotes = self.search text_array.join(" | "), :match_mode => :boolean
      unless quotes.blank?
        quote = quotes[rand(quotes.size)]
      else
        quote = self.find_rand_quote
      end
      quote
    else
      self.find_rand_quote
    end 
  end
  
  def self.find_rand_quote
    self.first
  end
  
end
