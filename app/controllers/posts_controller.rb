class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(6)
  end
    
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿に成功しました'
      redirect_to @post
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def destroy  
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
