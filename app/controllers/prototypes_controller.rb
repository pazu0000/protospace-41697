class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user! , only: [:edit, :update, :destroy]
  before_action :move_to_index ,only: [:update, :destroy]

 
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
    # 未ログインユーザー
    unless user_signed_in?
      redirect_to root_path, alert: "ログインが必要です。" and return
    end
  
    # 投稿者以外
    unless current_user == @prototype.user
      redirect_to root_path, alert: "不法なため入れません" and return
    end
  end
  
    
  

end