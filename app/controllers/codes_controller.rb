class CodesController < ApplicationController
  
  # GET /codes
  # GET /codes.json
  def index
    @title = t('view.codes.index_title')
    @codes = Code.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @codes }
    end
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
    @title = t('view.codes.show_title')
    @code = Code.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @code }
    end
  end

  # GET /codes/new
  # GET /codes/new.json
  def new
    @title = t('view.codes.new_title')
    @code = Code.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @code }
    end
  end

  # GET /codes/1/edit
  def edit
    @title = t('view.codes.edit_title')
    @code = Code.find(params[:id])
  end

  # POST /codes
  # POST /codes.json
  def create
    @title = t('view.codes.new_title')
    @code = Code.new(params[:code])

    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: t('view.codes.correctly_created') }
        format.json { render json: @code, status: :created, location: @code }
      else
        format.html { render action: 'new' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /codes/1
  # PUT /codes/1.json
  def update
    @title = t('view.codes.edit_title')
    @code = Code.find(params[:id])

    respond_to do |format|
      if @code.update_attributes(params[:code])
        format.html { redirect_to @code, notice: t('view.codes.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_code_url(@code), alert: t('view.codes.stale_object_error')
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code = Code.find(params[:id])
    @code.destroy

    respond_to do |format|
      format.html { redirect_to codes_url }
      format.json { head :ok }
    end
  end
end
