# 代码生成时间: 2025-09-23 20:35:36
# 使用RUBY和RAILS框架的哈希值计算工具
# 文件名: hash_calculator.rb

require 'digest'
require 'rails'

class HashCalculator
  # 计算字符串的哈希值
  # @param string [String] 需要计算哈希值的字符串
  # @param hash_type [Symbol] 哈希算法类型（如:md5, :sha1, :sha256等）
  # @return [String] 计算得到的哈希值
  def calculate_hash(string, hash_type = :md5)
    # 检查输入字符串是否为空
    raise ArgumentError, '输入字符串不能为空' if string.blank?

    # 检查哈希算法类型是否支持
    unless Digest::Digest.respond_to?(hash_type)
      raise ArgumentError, "不支持的哈希算法类型: #{hash_type}. 支持的类型包括: #{Digest::Digest.subclasses.map(&:name).join(', ')}"
    end

    # 计算哈希值
    hash = Digest.const_get(hash_type.to_s.camelize).hexdigest(string)
    hash
  end
end

# 示例用法
if __FILE__ == $0
  calculator = HashCalculator.new
  puts '请输入字符串:'
  string = gets.chomp
  hash_type = :md5 # 默认使用MD5算法
  puts "计算得到的#{hash_type}哈希值: #{calculator.calculate_hash(string, hash_type)}"
end