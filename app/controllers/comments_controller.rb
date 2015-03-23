class CommentsController < ApplicationController
	
  def edit
  	@article = Article.find(params[:article_id])
  	@comment = @article.comments.find(params[:id])
  end

  def update
  	@article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  	if @comment.update_attributes(comment_params)
      # flash a hash here!
  	  redirect_to(article_path(@article))
    else
      # handle the error!
    end
  end

  def create
  	#render(:plain => params.inspect)
  	@article = Article.find(params[:article_id])
  	@comment = @article.comments.create(comment_params)
  	redirect_to(article_path(@article))
  end

  def destroy
  	@article = Article.find(params[:article_id])
  	@comment = @article.comments.find(params[:id])
  	@comment.destroy
  	redirect_to(article_path(@article))
  end

  private
	  def comment_params
		params.require(:comment).permit(:commenter, :comment)  
	  end

end
