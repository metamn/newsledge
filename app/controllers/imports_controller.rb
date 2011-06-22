class ImportsController < ApplicationController
  after_filter :import, :only => [:create]
  
  
  # GET /imports
  # GET /imports.json
  def index
    @imports = current_user.imports

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @imports }
    end
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
    @import = Import.find(params[:id])
    unless (current_user.accounts.map{|a| a.id}.include? @import.account_id)
      flash[:notice] = "Invalid import"
      redirect_to imports_url
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @import }
      end
    end
  end

  # GET /imports/new
  # GET /imports/new.json
  def new
    @account = Account.find(params[:account])
    @import = @account.imports.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @import }
    end
  end

  # GET /imports/1/edit
  def edit
    @import = Import.find(params[:id])
  end

  # POST /imports
  # POST /imports.json
  def create
    @import = Import.new(params[:import])
    
    respond_to do |format|
      if @import.save
        format.html { redirect_to @import, notice: 'Import was successfully created.' }
        format.json { render json: @import, status: :created, location: @import }
      else
        format.html { render action: "new" }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /imports/1
  # PUT /imports/1.json
  def update
    @import = Import.find(params[:id])

    respond_to do |format|
      if @import.update_attributes(params[:import])
        format.html { redirect_to @import, notice: 'Import was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    @import = Import.find(params[:id])
    @import.destroy

    respond_to do |format|
      format.html { redirect_to imports_url }
      format.json { head :ok }
    end
  end
  
  
  private
    def import
      flash[:notice] = 'Importer started'
      Resque.enqueue(Importer, @import.id)
    end
  
end
