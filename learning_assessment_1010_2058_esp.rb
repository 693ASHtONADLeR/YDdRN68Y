# 代码生成时间: 2025-10-10 20:58:44
# 学习效果评估程序
# 该程序用于评估学生学习效果

require 'active_record'
require 'sqlite3'

# 建立数据库连接
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'learning_assessment.db')

# 定义学生模型
class Student < ActiveRecord::Base
  # 学生模型关联测试成绩
  has_many :assessments
end

# 定义测试成绩模型
class Assessment < ActiveRecord::Base
  # 测试成绩模型关联学生
  belongs_to :student
  
  # 评估学生学习效果
  def evaluate_performance
    # 根据测试成绩计算平均分
    avg_score = score / 100.0
    
    if avg_score >= 90
      "优秀"
    elsif avg_score >= 80
      "良好"
    elsif avg_score >= 70
      "中等"
    elsif avg_score >= 60
      "及格"
    else
      "不及格"
    end
  end
end

# 定义评估学习效果的服务
class LearningAssessmentService
  # 初始化方法
  def initialize(student_id)
    @student = Student.find(student_id)
  end
  
  # 获取学生的平均测试成绩
  def average_score
    total_score = @student.assessments.sum(:score)
    avg_score = total_score / @student.assessments.count
    avg_score
  end
  
  # 评估学习效果
  def evaluate_learning_effect
    assessment = @student.assessments.last
    result = assessment.evaluate_performance
    result
  end
  
  # 错误处理
  rescue ActiveRecord::RecordNotFound
    puts "学生不存在"
  end
end

# 示例代码
if __FILE__ == $0
  # 创建数据库和表
  ActiveRecord::Schema.define(version: 1) do
    create_table :students, force: true do |t|
      t.string :name
    end
    create_table :assessments, force: true do |t|
      t.integer :student_id
      t.integer :score
    end
  end
  
  # 创建学生和测试成绩记录
  Student.create(name: '张三')
  Assessment.create(student_id: 1, score: 85)
  Assessment.create(student_id: 1, score: 90)
  Assessment.create(student_id: 1, score: 78)
  
  # 评估学习效果
  service = LearningAssessmentService.new(1)
  avg_score = service.average_score
  puts "平均测试成绩: #{avg_score}"
  result = service.evaluate_learning_effect
  puts "学习效果评估: #{result}"
end