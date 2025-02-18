class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :move_to_index ,only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
 
 


  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end 

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end


  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
       redirect_to root_path
    else
       redirect_to root_path    
    end
  end  


  def create
     @prototype = Prototype.new(prototype_params)
     if @prototype.save
        redirect_to root_path
     else
       render :new,status: :unprocessable_entity
     end
    
  end
  

  
  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  
    
  def move_to_index
    # current_user が存在し、かつそのユーザーが投稿者でなければリダイレクト
    unless current_user == @prototype.user
      redirect_to root_path 
    end
  end
  
  

end