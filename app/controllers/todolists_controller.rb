class TodolistsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, { only: [:show,:edit, :update, :destroy] }
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to todolists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if params[:latest]
      @lists = current_user.lists.latest.order(created_at: :desc)
    elsif params[:old]
      @lists = current_user.lists.old.order(created_at: :desc)
    elsif params[:point_count]
      @lists = current_user.lists.point_count.order(created_at: :desc)
    else
      @lists = current_user.lists.all.order(created_at: :desc)
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.user != current_user
      redirect_to todolists_path
    else
      if @list.update(list_params)
        redirect_to todolist_path(@list.id)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to todolists_path
  end

  def ensure_correct_user
    @list = List.find_by(id: params[:id])
    return unless @list.user_id != current_user.id

    redirect_to todolists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :body, :day, :result, :point)
  end


end
