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
    @import = current_user.import(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @import }
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
    redirect_to imports_url
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
    redirect_to imports_path
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    redirect_to imports_path
  end
  
  
  private
    def import
      flash[:notice] = 'Importer started'
      Resque.enqueue(Importer, @import.id)
    end
  
end
