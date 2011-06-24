class ReferencesController < ApplicationController
  # GET /references
  # GET /references.json
  def index
    @references = current_user.references

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @references }
    end
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @reference = current_user.references.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/new
  # GET /references/new.json
  def new
    redirect_to references_url
  end

  # GET /references/1/edit
  def edit
    @reference = current_user.references.find(params[:id])
  end

  # POST /references
  # POST /references.json
  def create
    redirect_to references_url
  end

  # PUT /references/1
  # PUT /references/1.json
  def update
    @reference = current_user.references.find(params[:id])

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference = current_user.references.find(params[:id])
    @reference.destroy

    respond_to do |format|
      format.html { redirect_to references_url }
      format.json { head :ok }
    end
  end
end
