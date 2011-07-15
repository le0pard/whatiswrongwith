class DashboardController < ApplicationController
  
  def index
    @quote_form = QuoteForm.new
  end
  
  def create
    @quote_form = QuoteForm.new(params[:quote_form])
    if @quote_form.save
      @quote = Quote.find_best_quote(@quote_form.content)
      unless @quote.nil?
        @answer = Answer.new(
          :problem => @quote_form.content,
          :quote => @quote,
        )
        if @answer.save
          redirect_to answer_path(:token => @answer.token)
        else
          render :action => :index
        end
      else
        render :action => :index
      end
    else
      render :action => :index
    end
  end
  
  def answer
    @answer = Answer.find_by_token(params[:token])
    redirect_to root_path if @answer.blank?
  end
  
end
