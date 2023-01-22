class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end
  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.save
    if @prototype.save
      redirect_to root_path(@user)
    else
      render :new
    end
  end
  def show
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user
    @comment = Comment.new
    @comments = @prototype.comments.includes(:prototype)
  end
  def edit
    unless user_sined_in?
      redirect_to action: :index
    end
    @prototype = Prototype.find(params[:id])
  end
  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else 
      render :edit
    end
  end
  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
