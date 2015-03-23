class ArticlesController < ApplicationController
  
  http_basic_authenticate_with(:name => "user", :password => "password", :only => [:index, :destory])
  rescue_from(ActiveRecord::RecordNotFound, :with => :record_not_found)

  def index
  	@all_articles = Article.all
    @time = Time.now.asctime
    @global_article = "Really cool Article Title"
    respond_to do |format|
      format.html
      format.json {render(:json => @all_articles)}
    end
  end

  def show
  	@article = Article.find(params[:id])
  end

  def edit
  	@article = Article.find(params[:id])
  end

  def new
  	@article = Article.new
  end

  def create
  	#render(:plain => params.inspect)
  	@article = Article.new(article_params)
  	if @article.save
  		#redirect_to(:action => "show", :id => @article.id)
  		flash[:notice] = "New article created successfully!"
  		redirect_to(article_path(@article.id))
  	else
      flash[:notice] = "Article didn't post. Please make sure you have enough content in each field"
  		render("new")
  	end
  end

  def update
  	@article = Article.find(params[:id])
  	if @article.update_attributes(article_params)
  		flash[:notice] = "Updated article successfully!"
  		redirect_to(article_path(@article.id))
  	else
      flash[:notice] = "Article didn't post. Please make sure you have enough content in each field"
  		render("edit")
  	end
  end

  def delete
  	@delete_article = Article.find(params[:id])
  end

  def destroy
  	subject = Article.find(params[:id]).destroy
    flash[:notice] = "Successfully deleted the article: #{subject.title}!"
  	redirect_to(articles_path)
  end
  
  private
  	# strong params!
	  # same as using params[:subject], except it
    # raises an error if :subject is not present
    # allows listed arguments to be mass assigned 
  	def article_params
  		params.require(:article).permit(:author, :title, :content)
  	end

    def record_not_found
      # render(:text => "Hmm, counldn't find that...", :status => 404)
      render("error")
      message = "Item with ID #{params[:id]} not found"
      logger.error(message)
      # redirect_to(articles_path)
    end

end
