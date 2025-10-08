# 代码生成时间: 2025-10-09 02:20:33
# B2B Purchase System
# This is a Ruby on Rails application that simulates a basic B2B purchasing system.

# Gemfile
# List of gems required for the application
# Add the necessary gems to run the Rails application

# config/routes.rb
# Define the routes for the application
Rails.application.routes.draw do
  # Define the route for the products resource
  resources :products
end

# app/controllers/products_controller.rb
# The controller to handle product-related operations
class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @products = Product.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, notice: 'Product was successfully created.') }
        format.xml  { render xml: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to(@product, notice: 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end
end

# app/models/product.rb
# The model representing a product in the B2B system
class Product < ApplicationRecord
  # Validations can be added here to ensure data integrity
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end

# app/views/products/index.html.erb
# The view to display the list of products
<h1>Products</h1>
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Price</th>
    <th>Quantity</th>
    <th></th>
  </tr>
  <% @products.each do |product| %>
  <tr>
    <td><%= product.name %></td>
    <td><%= product.description %></td>
    <td><%= number_to_currency(product.price) %></td>
    <td><%= product.quantity %></td>
    <td><%= link_to 'Show', product %></td>
    <td><%= link_to 'Edit', edit_product_path(product) %></td>
    <td><%= link_to 'Destroy', product, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  </tr>
  <% end %>
</table>

# app/views/products/show.html.erb
# The view to display a single product
<h1><%= @product.name %></h1>
<p>Description: <%= @product.description %></p>
<p>Price: <%= number_to_currency(@product.price) %></p>
<p>Quantity: <%= @product.quantity %></p>

# app/views/products/new.html.erb
# The view to create a new product
<h1>New Product</h1>
<%= form_for @product do |f| %>
  <p>
    <b>Name:</b><br />
    <%= f.text_field :name %></p>
  <p>
    <b>Description:</b><br />
    <%= f.text_area :description %></p>
  <p>
    <b>Price:</b><br />
    <%= f.text_field :price %></p>
  <p>
    <b>Quantity:</b><br />
    <%= f.number_field :quantity %></p>
  <p>
    <%= f.submit "Create" %>
  </p>
<% end %>

# app/views/products/edit.html.erb
# The view to edit an existing product
<h1>Edit Product</h1>
<%= form_for [@product] do |f| %>
  <p>
    <b>Name:</b><br />
    <%= f.text_field :name %></p>
  <p>
    <b>Description:</b><br />
    <%= f.text_area :description %></p>
  <p>
    <b>Price:</b><br />
    <%= f.text_field :price %></p>
  <p>
    <b>Quantity:</b><br />
    <%= f.number_field :quantity %></p>
  <p>
    <%= f.submit "Update" %>
  </p>
<% end %>
