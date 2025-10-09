# 代码生成时间: 2025-10-09 23:16:56
# user_authentication.rb
# This file contains the UserAuthentication class responsible for handling user authentication

class UserAuthentication
  # Authenticate a user based on their username and password
  #
  # @param username [String] The username of the user
  # @param password [String] The password of the user
  # @return [Boolean] True if authentication is successful, false otherwise
  def self.authenticate(username, password)
    # Find the user by username
    user = User.find_by(username: username)

    # If user not found, return false
    return false unless user

    # Check if the provided password matches the user's password
    user.authenticate(password)
  end

  # Register a new user
  #
  # @param username [String] The username of the new user
  # @param password [String] The password of the new user
  # @return [User] The newly created user object
  def self.register(username, password)
    # Create a new user with the given username and password
    user = User.create(username: username, password: password)

    # Check if the user was created successfully
    if user.persisted?
      user
    else
      raise 'Failed to create user'
    end
  end
end

# The User model that includes the has_secure_password method for password encryption
#
# @attr username [String] The username of the user
# @attr password_digest [String] The encrypted password of the user
class User < ApplicationRecord
  has_secure_password
end