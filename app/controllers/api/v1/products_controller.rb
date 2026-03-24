# app/controllers/api/v1/products_controller.rb
class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
    before_action :admin_only, only: [:create, :update, :destroy]


  # GET /products
  def index
    if params[:query].present?
      @products = Product.search(params[:query], page: params[:page], per_page: 10)
    else
      @products = Product.page(params[:page]).per(10)
    end

    render json: @products
  end

  # GET /products/:id
  def show
    render json: @product
  end

  # POST /products
    def create
    @product = Product.new(product_params)

    if @product.save
        render json: { message: "Product created successfully", data: @product }, status: :created
    else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
    end


  # PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end


def admin_only
  render json: { error: "Not authorized" } unless @current_user.admin?
end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :quantity)
  end
end


