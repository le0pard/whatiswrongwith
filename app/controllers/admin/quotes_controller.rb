class Admin::QuotesController < Admin::BaseController
  before_filter :get_quote, :only => [:edit, :update, :destroy]
  
  def index
    @quotes = Quote.order("created_at DESC").page(params[:page])
  end
  
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      flash[:notice] = I18n.t("flash.quote.create")
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  
  def edit
    #
  end
  
  def update
    if @quote.update_attributes(params[:quote])
      flash[:notice] = I18n.t("flash.quote.update")
      redirect_to :action => :edit, :id => @quote.id
    else
      render :action => :edit, :id => @quote.id
    end
  end
  
  def destroy
    @quote.destroy
    flash[:notice] = I18n.t("flash.quote.destroy")
    redirect_to :action => :index
  end
  
  private
  
  def get_quote
    @quote = Quote.find(params[:id])
  end
  
end
