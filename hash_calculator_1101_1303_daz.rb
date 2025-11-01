# 代码生成时间: 2025-11-01 13:03:04
# HashCalculator class
# This class is used to calculate hash values of strings using various algorithms.

require 'digest'

class HashCalculator
  # Calculate the hash of the given string using the specified algorithm.
  #
  # @param string [String] The string to calculate the hash for.
# NOTE: 重要实现细节
  # @param algorithm [String] The hash algorithm to use (e.g., 'md5', 'sha256').
  # @return [String] The calculated hash in hexadecimal format.
# NOTE: 重要实现细节
  #
  # @raise [ArgumentError] If the algorithm is not supported.
  def calculate_hash(string, algorithm)
    # Check if the algorithm is supported
    unless Digest::Digest.respond_to?(algorithm)
      raise ArgumentError, "Unsupported algorithm: #{algorithm}"
    end

    # Calculate and return the hash
    hash = Digest.const_get(algorithm.to_s.capitalize).hexdigest(string)
    hash
  end
end

# Example usage:
# hash_calculator = HashCalculator.new
# puts hash_calculator.calculate_hash('Hello, World!', 'sha256')
