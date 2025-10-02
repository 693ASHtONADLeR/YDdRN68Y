# 代码生成时间: 2025-10-03 02:23:24
# math_toolbox.rb
# A simple math toolbox that provides a set of mathematical operations.

require 'active_support'

# MathToolbox module encapsulates a set of mathematical operations.
module MathToolbox
  # Adds two numbers
  #
  # @param num1 [Float] the first number
  # @param num2 [Float] the second number
  # @return [Float] the sum of num1 and num2
  def self.add(num1, num2)
    num1 + num2
  end

  # Subtracts num2 from num1
  #
  # @param num1 [Float] the first number
  # @param num2 [Float] the second number
  # @return [Float] the difference of num1 and num2
  def self.subtract(num1, num2)
    num1 - num2
  end

  # Multiplies two numbers
  #
  # @param num1 [Float] the first number
  # @param num2 [Float] the second number
  # @return [Float] the product of num1 and num2
  def self.multiply(num1, num2)
    num1 * num2
  end

  # Divides num1 by num2, returns Float
  #
  # @param num1 [Float] the dividend
  # @param num2 [Float] the divisor
  # @return [Float] the quotient of num1 divided by num2
  # @raise [ZeroDivisionError] if num2 is zero
  def self.divide(num1, num2)
    num2.zero? ? raise(ZeroDivisionError, 'Cannot divide by zero') : num1.to_f / num2.to_f
  end

  # Calculates the power of num1 raised to the power of num2
  #
  # @param num1 [Float] the base number
  # @param num2 [Float] the exponent
  # @return [Float] num1 raised to the power of num2
  def self.power(num1, num2)
    num1 ** num2
  end
end

# Example usage of MathToolbox:
# puts MathToolbox.add(5, 3)
# puts MathToolbox.subtract(10, 4)
# puts MathToolbox.multiply(2, 5)
# puts MathToolbox.divide(20, 4)
# puts MathToolbox.power(2, 3)