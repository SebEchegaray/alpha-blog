class ArticlesController < ApplicationController
  # We call our method to be available for our actions
  # Sometimes we need our new method to be used only in some of the actions so what we do there
  # is to add the ONLY word and within square brakets we put the name of the actions but as symbols
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
    
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    
  end

  def create
    # What we did here was to get rid of the line that called in the params and place the name of the
    # method(article_params down in private) that now runs that line of code
    @article = Article.new(article_params)
    if @article.save
      #Flash is a rails helper to give a msg of an article created successfully for example
      flash[:notice] = "Article was created successfully."
      redirect_to article_path(@article) # Another way is to shorten the line by doing: redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # So this IF statement makes it to render the edit page if the fields validation aren't met during the process
    # When they're met, it shoots a msg saying it was successfully added and redirect to the article updated
    # When they aren't met, it displays the same edit page again so the issue can be fixed
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    # To redirect to the articles page to show all articles, what we do is simply look for the prefix of
    # our INDEX action/view and add _path, so that it goes to my listing page of articles as the following:
    redirect_to articles_path
  end

  private # This word/line makes that whatever code I write below it, is only usable within this controller. It won't be available outside for any other part of the code
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end