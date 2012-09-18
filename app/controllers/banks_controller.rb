class BanksController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource 
  
  # GET /banks
  # GET /banks.json
  def index
    @title = t('view.banks.index_title')
    @banks = Bank.filtered_list(params[:q]).page(params[:page])
    @searchable = true
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banks }
    end
  end

  # GET /banks/1
  # GET /banks/1.json
  def show
    @title = t('view.banks.show_title')
    @bank = Bank.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank }
    end
  end

  # GET /banks/new
  # GET /banks/new.json
  def new
    @title = t('view.banks.new_title')
    @bank = Bank.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank }
    end
  end

  # GET /banks/1/edit
  def edit
    @title = t('view.banks.edit_title')
    @bank = Bank.find(params[:id])
  end

  # POST /banks
  # POST /banks.json
  def create
    @title = t('view.banks.new_title')
    @bank = Bank.new(params[:bank])

    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: t('view.banks.correctly_created') }
        format.json { render json: @bank, status: :created, location: @bank }
      else
        format.html { render action: 'new' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banks/1
  # PUT /banks/1.json
  def update
    @title = t('view.banks.edit_title')
    @bank = Bank.find(params[:id])

    respond_to do |format|
      if @bank.update_attributes(params[:bank])
        format.html { redirect_to @bank, notice: t('view.banks.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_bank_url(@bank), alert: t('view.banks.stale_object_error')
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank = Bank.find(params[:id])
    @bank.destroy

    respond_to do |format|
      format.html { redirect_to banks_url, notice: t('view.banks.correctly_deleted') }
      format.json { head :ok }
    end
  end
end
