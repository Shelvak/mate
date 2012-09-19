class WorkplacesController < ApplicationController

  # GET /workplaces
  # GET /workplaces.json
  def index
    @title = t('view.workplaces.index_title')
    @workplaces = Workplace.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workplaces }
    end
  end

  # GET /workplaces/1
  # GET /workplaces/1.json
  def show
    @title = t('view.workplaces.show_title')
    @workplace = Workplace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workplace }
    end
  end

  # GET /workplaces/new
  # GET /workplaces/new.json
  def new
    @title = t('view.workplaces.new_title')
    @workplace = Workplace.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workplace }
    end
  end

  # GET /workplaces/1/edit
  def edit
    @title = t('view.workplaces.edit_title')
    @workplace = Workplace.find(params[:id])
  end

  # POST /workplaces
  # POST /workplaces.json
  def create
    @title = t('view.workplaces.new_title')
    @workplace = Workplace.new(params[:workplace])

    respond_to do |format|
      if @workplace.save
        format.html { redirect_to @workplace, notice: t('view.workplaces.correctly_created') }
        format.json { render json: @workplace, status: :created, location: @workplace }
      else
        format.html { render action: 'new' }
        format.json { render json: @workplace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workplaces/1
  # PUT /workplaces/1.json
  def update
    @title = t('view.workplaces.edit_title')
    @workplace = Workplace.find(params[:id])

    respond_to do |format|
      if @workplace.update_attributes(params[:workplace])
        format.html { redirect_to @workplace, notice: t('view.workplaces.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workplace.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_workplace_url(@workplace), alert: t('view.workplaces.stale_object_error')
  end

  # DELETE /workplaces/1
  # DELETE /workplaces/1.json
  def destroy
    @workplace = Workplace.find(params[:id])
    @workplace.destroy

    respond_to do |format|
      format.html { redirect_to workplaces_url, notice: I18n.t('view.workplaces.correctly_deleted') }
      format.json { head :ok }
    end
  end
end
