class Quote < ActiveRecord::Base
  
  has_many :answers
  
  validates :content, :presence => true, :length => { :maximum => 2000 }
  validates :source, :presence => true, :length => { :maximum => 150 }
  
  define_index do
    indexes content

    has created_at, updated_at
  end
  
  
  
  def self.find_best_quote(text)
    quotes = self.search(text, :match_mode => :any, :page => 1, :per_page => 50)
    unless quotes.blank?
      quote = quotes[rand(quotes.size)]
    else
      quote = self.find_rand_quote
    end
    quote
  end
  
  def self.find_rand_quote
    self.order("random()").limit(1).first
  end
  
end
