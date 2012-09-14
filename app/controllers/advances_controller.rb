class AdvancesController < ApplicationController
  
  # GET /advances
  # GET /advances.json
  def index
    @title = t('view.advances.index_title')
    @advances = Advance.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advances }
    end
  end

  # GET /advances/1
  # GET /advances/1.json
  def show
    @title = t('view.advances.show_title')
    @advance = Advance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advance }
    end
  end

  # GET /advances/new
  # GET /advances/new.json
  def new
    @title = t('view.advances.new_title')
    @advance = Advance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advance }
    end
  end

  # GET /advances/1/edit
  def edit
    @title = t('view.advances.edit_title')
    @advance = Advance.find(params[:id])
  end

  # POST /advances
  # POST /advances.json
  def create
    @title = t('view.advances.new_title')
    @advance = Advance.new(params[:advance])

    respond_to do |format|
      if @advance.save
        format.html { redirect_to @advance, notice: t('view.advances.correctly_created') }
        format.json { render json: @advance, status: :created, location: @advance }
      else
        format.html { render action: 'new' }
        format.json { render json: @advance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advances/1
  # PUT /advances/1.json
  def update
    @title = t('view.advances.edit_title')
    @advance = Advance.find(params[:id])

    respond_to do |format|
      if @advance.update_attributes(params[:advance])
        format.html { redirect_to @advance, notice: t('view.advances.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advance.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_advance_url(@advance), alert: t('view.advances.stale_object_error')
  end

  # DELETE /advances/1
  # DELETE /advances/1.json
  def destroy
    @advance = Advance.find(params[:id])
    @advance.destroy

    respond_to do |format|
      format.html { redirect_to advances_url }
      format.json { head :ok }
    end
  end
end
