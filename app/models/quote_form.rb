class QuoteForm
  include ActiveModel::Validations
  
  attr_accessor :content
  
  validates :content, :presence => true
  
  def to_model; self; end
  def persisted?; false; end
  def to_key; nil; end
  def to_param; nil; end
  
  def initialize(attributes = nil)
    # Mass Assignment implementation
    if attributes
      attributes.each do |key, value|
        self[key] = value
      end
    end
    yield self if block_given?
  end
  
  def [](key)
    instance_variable_get("@#{key}")
  end
  
  def []=(key, value)
    instance_variable_set("@#{key}", value)
  end
  
  def save
    if valid?
      #save method implementation
      true
    else
      false
    end
  end
end