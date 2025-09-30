# 代码生成时间: 2025-09-30 21:18:50
# health_risk_assessment.rb
# This file contains the logic for health risk assessment.

require 'date'

# Define a class for HealthRiskAssessment to encapsulate the assessment logic.
class HealthRiskAssessment
  # Initialize with attributes necessary for the assessment.
  attr_accessor :age, :sex, :weight, :height

  # Constructor for the HealthRiskAssessment class.
  def initialize(age:, sex:, weight:, height:)
    @age = age
    @sex = sex
    @weight = weight
    @height = height
  end

  # Method to calculate Body Mass Index (BMI).
  def bmi
    # Ensure weight is in kg and height is in meters for accurate BMI calculation.
    weight_in_kg = weight
    height_in_meters = height / 100.0 # Convert height from cm to meters
    bmi_value = weight_in_kg / (height_in_meters ** 2)
    bmi_value
  end

  # Method to assess health risk based on BMI.
  def assess_risk
    risk_level = :unknown
    bmi_value = bmi

    case
    when bmi_value < 18.5
      risk_level = :underweight
    when bmi_value >= 18.5 && bmi_value < 25
      risk_level = :normal
    when bmi_value >= 25 && bmi_value < 30
      risk_level = :overweight
    else
      risk_level = :obese
    end

    risk_level
  end

  # Method to provide a health advice based on assessed risk level.
  def health_advice
    advice = {
      underweight: "Consider increasing your calorie intake and consult a nutritionist.",
      normal: "Maintain your current habits for a healthy lifestyle.",
      overweight: "Consider reducing calorie intake and increasing physical activity.",
      obese: "Seek medical advice for weight loss strategies and increase physical activity."
    }
    advice[assess_risk]
  end

  # Method to validate input data.
  def validate_data
    raise ArgumentError, "Age must be a positive integer." unless age.is_a?(Integer) && age > 0
    raise ArgumentError, "Sex must be either 'male' or 'female'." unless %w[male female].include?(sex.downcase)
    raise ArgumentError, "Weight must be a positive number." unless weight.is_a?(Numeric) && weight > 0
    raise ArgumentError, "Height must be a positive number." unless height.is_a?(Numeric) && height > 0
  end
end

# Example usage:
begin
  # Create an instance of HealthRiskAssessment with sample data.
  assessment = HealthRiskAssessment.new(age: 30, sex: 'male', weight: 80, height: 175)
  # Validate data before assessment.
  assessment.validate_data
  # Perform the health risk assessment.
  risk_level = assessment.assess_risk
  # Get health advice based on the assessed risk level.
  advice = assessment.health_advice
  puts "Health Risk Level: #{risk_level.to_s.capitalize}"
  puts "Health Advice: #{advice}"
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
