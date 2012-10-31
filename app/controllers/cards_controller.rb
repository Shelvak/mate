class CardsController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource 
  
  # GET /cards
  # GET /cards.json
  def index
    @title = t('view.cards.index_title')
    @cards = Card.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @title = t('view.cards.show_title')
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @title = t('view.cards.new_title')
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @title = t('view.cards.edit_title')
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @title = t('view.cards.new_title')
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: t('view.cards.correctly_created') }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: 'new' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @title = t('view.cards.edit_title')
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: t('view.cards.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_card_url(@card), alert: t('view.cards.stale_object_error')
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: t('view.cards.correctly_deleted') }
      format.json { head :ok }
    end
  end


  def autocomplete_for_bank_name
    banks = Bank.filtered_list(params[:q]).order('name DESC').limit(10)

    respond_to do |format|
      format.json { render json: banks }
    end
  end
end
