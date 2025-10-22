# 代码生成时间: 2025-10-23 03:53:31
# membership_points_system.rb
# This Ruby on Rails application provides a simple membership points system.

# Represents a User with points.
class User < ApplicationRecord
  # Associations
  has_many :transactions

  # Adds points to the user's balance.
  def add_points(points)
    self.points += points
    save!
  end

  # Subtracts points from the user's balance.
  def subtract_points(points)
    self.points -= points
    save!
  end
end

# Represents a transaction that affects a user's points.
class Transaction < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :points, presence: true, numericality: { greater_than: 0 }
end

# Controller for managing user points.
class PointsController < ApplicationController
  # POST /users/:user_id/points
  def add
    user = User.find(params[:user_id])
    points_to_add = params[:points].to_i
    if user.add_points(points_to_add)
      render json: { success: true, message: "Points added successfully", user_points: user.points }
    else
      render json: { success: false, message: "Error adding points", user_points: user.points }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: "User not found" }, status: :not_found
  end

  # POST /users/:user_id/points/subtract
  def subtract
    user = User.find(params[:user_id])
    points_to_subtract = params[:points].to_i
    if user.points >= points_to_subtract && user.subtract_points(points_to_subtract)
      render json: { success: true, message: "Points subtracted successfully", user_points: user.points }
    else
      render json: { success: false, message: "Error subtracting points, insufficient balance or invalid input", user_points: user.points }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: "User not found" }, status: :not_found
  end
end

# Routes for points management.
Rails.application.routes.draw do
  resources :users do
    post 'points', to: 'points#add', as: :add_points
    post 'points/subtract', to: 'points#subtract', as: :subtract_points
  end
end
