class ArticlesController < ApplicationController
	# good pracice to place CRUD actions in followig order: 
	# index, show, new, edit, create, update, and destroy

	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		#Article refers to class in models
		@article = Article.new(article_params) 

		if @article.save
			redirect_to @article
		else
			render 'new'
		end

		# ex) params[:username] equals "dhh"
		#render plain: params[:article].inspect 
	end

	def update 
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		# redirecting to the index action
		redirect_to articles_path
	end

	private def article_params
		params.require(:article).permit(:title, :text)
	end
end
