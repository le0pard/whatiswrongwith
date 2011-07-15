class DashboardController < ApplicationController
  
  def index
    @quote_form = QuoteForm.new
  end
  
  def create
    @quote_form = QuoteForm.new(params[:quote_form])
    if @quote_form.save
      Quote.find_best_quote(@quote_form.content)
    else
      render :action => :index
    end
  end
  
end
