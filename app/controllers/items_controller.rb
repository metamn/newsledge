class ItemsController < ApplicationController
  
  before_filter :check_ownership, :only => [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = current_user.items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end    
  end

  # GET /items/new
  # GET /items/new.json
  def new
    redirect_to items_url
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    redirect_to items_url
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end
  
  
  private 
    
    def check_ownership
      begin 
        @item = current_user.items.find(params[:id])
      rescue
        redirect_to items_url
      end
    end
end
