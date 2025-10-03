# 代码生成时间: 2025-10-04 02:16:24
# Customer Relationship Management System using Ruby on Rails
# This file outlines the basic structure and functionality of the CRM system.

# Load the required gems and initialize the Rails application
require 'rails/all'
require_relative 'application_controller'
require_relative 'models/customer'
require_relative 'models/contact'
require_relative 'services/customer_service'

# Application controller
class ApplicationController < ActionController::API
  # Include the necessary modules for authentication and error handling
  include ActionController::Serialization
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Token::Request
  include ActionController::HttpAuthentication::Token::Response
  include ActionController::HttpAuthentication::Token::Exception
end

# Customer model
class Customer < ApplicationRecord
  # Associations
  has_many :contacts

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Callbacks
  before_create :send_welcome_email

  # Send a welcome email to the newly created customer
  def send_welcome_email
    # Email sending logic goes here
  end
end

# Contact model
class Contact < ApplicationRecord
  # Associations
  belongs_to :customer

  # Validations
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: { scope: :customer_id }
end

# Customer Service class
class CustomerService
  # Find a customer by ID
  def self.find_customer(id)
    customer = Customer.find(id)
    customer || raise(ActiveRecord::RecordNotFound, 'Customer not found')
  end

  # Create a new customer
  def self.create_customer(customer_params)
    customer = Customer.new(customer_params)
    customer.save
    customer
  end

  # Update an existing customer
  def self.update_customer(customer, customer_params)
    customer.update(customer_params)
    customer
  end

  # Delete a customer
  def self.delete_customer(customer)
    customer.destroy
  end
end

# Example of a controller using the CustomerService
class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    customers = Customer.all
    render json: customers, status: :ok
  end

  # GET /customers/:id
  def show
    render json: @customer, status: :ok
  end

  # POST /customers
  def create
    customer = CustomerService.create_customer(customer_params)
    render json: customer, status: :created, location: customer
  rescue ActiveRecord::RecordInvalid
    render json: { errors: customer.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /customers/:id
  def update
    customer = CustomerService.update_customer(@customer, customer_params)
    render json: customer, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: { errors: customer.errors }, status: :unprocessable_entity
  end

  # DELETE /customers/:id
  def destroy
    CustomerService.delete_customer(@customer)
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = CustomerService.find_customer(params[:id])
  end

  # Only allow a trusted parameter 'white list' through.
  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
