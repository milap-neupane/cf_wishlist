class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_lists = WishList.all
  end

  # GET /wish_lists/1
  # GET /wish_lists/1.json
  def show
  end

  # GET /wish_lists/new
  def new
    @wish_list = WishList.new
  end

  # GET /wish_lists/1/edit
  def edit
  end

  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = WishList.new(wish_list_params)

    respond_to do |format|
      if @wish_list.save
        format.html { redirect_to @wish_list, notice: 'Wish list was successfully created.' }
        format.json { render :show, status: :created, location: @wish_list }
      else
        format.html { render :new }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wish_lists/1
  # PATCH/PUT /wish_lists/1.json
  def update
    respond_to do |format|
      if @wish_list.update(wish_list_params)
        format.html { redirect_to @wish_list, notice: 'Wish list was successfully updated.' }
        format.json { render :show, status: :ok, location: @wish_list }
      else
        format.html { render :edit }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_lists/1
  # DELETE /wish_lists/1.json
  def destroy
    @wish_list.destroy
    respond_to do |format|
      format.html { redirect_to wish_lists_url, notice: 'Wish list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pledge
    tracker = Tracker.find_or_initialize_by(tracker_params).tap do |tracker|
      items_count = params['pledge']['item_count'].to_i
      tracker.item_count += items_count
      if tracker.save
        wish_list = WishList.find tracker_params['wish_list_id']
        required_quantity = wish_list.required_quantity
        wish_list.required_quantity = required_quantity - items_count
        wish_list.save
      end
    end
    tracker.save
    respond_to do |format|
      format.html { redirect_to wish_lists_url, notice: 'Thank you for your help.' }
    end
  end

  def add_to_cart
    cart_item = current_user.cart.new(cart_params)
    respond_to do |format|
      if cart_item.save
        format.html { redirect_to wish_lists_url, notice: 'Item added to cart.' }
      else
        format.html { redirect_to wish_lists_url, alert: cart_item.errors.message }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_list
      @wish_list = WishList.find(params[:id])
    end

    def tracker_params
      options = {}
      options['wish_list_id'] = params['wish_list_id']
      options['user_id'] = current_user.id
      options
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_list_params
      params[:wish_list].permit(:title, :price, :required_quantity, :discreption)
    end
end
