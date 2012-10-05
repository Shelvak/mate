class PettyCashesController < ApplicationController
  
  # GET /petty_cashes
  # GET /petty_cashes.json
  def index
    @title = t('view.petty_cashes.index_title')
    @petty_cashes = PettyCash.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @petty_cashes }
    end
  end

  # GET /petty_cashes/1
  # GET /petty_cashes/1.json
  def show
    @title = t('view.petty_cashes.show_title')
    @petty_cash = PettyCash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @petty_cash }
    end
  end

  # GET /petty_cashes/new
  # GET /petty_cashes/new.json
  def new
    @title = t('view.petty_cashes.new_title')
    @petty_cash = PettyCash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @petty_cash }
    end
  end

  # GET /petty_cashes/1/edit
  def edit
    @title = t('view.petty_cashes.edit_title')
    @petty_cash = PettyCash.find(params[:id])
  end

  # POST /petty_cashes
  # POST /petty_cashes.json
  def create
    @title = t('view.petty_cashes.new_title')
    @petty_cash = PettyCash.new(params[:petty_cash])

    respond_to do |format|
      if @petty_cash.save
        format.html { redirect_to @petty_cash, notice: t('view.petty_cashes.correctly_created') }
        format.json { render json: @petty_cash, status: :created, location: @petty_cash }
      else
        format.html { render action: 'new' }
        format.json { render json: @petty_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /petty_cashes/1
  # PUT /petty_cashes/1.json
  def update
    @title = t('view.petty_cashes.edit_title')
    @petty_cash = PettyCash.find(params[:id])

    respond_to do |format|
      if @petty_cash.update_attributes(params[:petty_cash])
        format.html { redirect_to @petty_cash, notice: t('view.petty_cashes.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @petty_cash.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_petty_cash_url(@petty_cash), alert: t('view.petty_cashes.stale_object_error')
  end

  # DELETE /petty_cashes/1
  # DELETE /petty_cashes/1.json
  def destroy
    @petty_cash = PettyCash.find(params[:id])
    @petty_cash.destroy

    respond_to do |format|
      format.html { redirect_to petty_cashes_url }
      format.json { head :ok }
    end
  end
end
