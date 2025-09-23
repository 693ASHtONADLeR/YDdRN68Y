# 代码生成时间: 2025-09-23 08:37:10
# file_backup_sync.rb
#
# 这是一个简单的文件备份和同步工具，使用Ruby和Rails框架。
# 它允许用户指定源目录和目标目录，然后同步源目录到目标目录。
#
# 用法：
# 1. 确保安装了Rails框架。
# 2. 将此脚本放置在Rails项目的根目录下。
# 3. 运行脚本：rails runner file_backup_sync.rb
#
# 注意：
# 此工具假设目标目录已经存在，如果不存在，将会创建它。
#
require 'fileutils'
require 'active_support/all'

# 文件备份和同步类
class FileBackupSync
  # 初始化方法，接受源目录和目标目录作为参数
  def initialize(source_dir, target_dir)
    @source_dir = source_dir
    @target_dir = target_dir
  end

  # 同步源目录到目标目录的方法
  def sync
    # 检查源目录是否存在
    unless File.exist?(@source_dir)
      raise '源目录不存在'
    end

    # 检查目标目录是否存在，如果不存在则创建
    unless File.exist?(@target_dir)
      FileUtils.mkdir_p(@target_dir)
    end

    # 遍历源目录下的所有文件和子目录
    Dir.foreach(@source_dir) do |entry|
      next if entry == '.' || entry == '..' # 跳过当前目录和上级目录

      source_path = File.join(@source_dir, entry)
      target_path = File.join(@target_dir, entry)

      # 如果是文件，则复制到目标目录
      if File.file?(source_path)
        FileUtils.cp(source_path, target_path)
        puts "文件已同步: #{source_path} -> #{target_path}"

      # 如果是目录，则递归同步
      elsif File.directory?(source_path)
        FileUtils.mkdir_p(target_path) unless File.exist?(target_path)
        sync_directory(source_path, target_path)
      end
    end
  end

  # 递归同步目录的方法
  def sync_directory(source_path, target_path)
    Dir.foreach(source_path) do |entry|
      next if entry == '.' || entry == '..' # 跳过当前目录和上级目录

      source_subpath = File.join(source_path, entry)
      target_subpath = File.join(target_path, entry)

      # 如果是文件，则复制到目标目录
      if File.file?(source_subpath)
        FileUtils.cp(source_subpath, target_subpath)
        puts "文件已同步: #{source_subpath} -> #{target_subpath}"

      # 如果是目录，则递归同步
      elsif File.directory?(source_subpath)
        FileUtils.mkdir_p(target_subpath) unless File.exist?(target_subpath)
        sync_directory(source_subpath, target_subpath)
      end
    end
  end
end

# 主程序
if __FILE__ == $0
  # 命令行参数：源目录和目标目录
  source_dir = ARGV[0]
  target_dir = ARGV[1]

  # 检查参数是否正确
  unless source_dir && target_dir
    puts '请提供源目录和目标目录作为参数'
    exit
  end

  # 创建文件备份和同步工具的实例
  backup_sync = FileBackupSync.new(source_dir, target_dir)

  # 执行同步操作
  backup_sync.sync
end