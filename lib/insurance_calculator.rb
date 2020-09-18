require_relative './customer_request'
require_relative './insurer'

class InsuranceCalculator
  attr_reader :customer_request, :insurers

  def initialize(customer_request, insurers)
    @customer_request = customer_request # CustomerRequest obj
    @insurers = insurers # Array[Insurer]
  end

  def calculate
    output = insurers.map do |insurer|
      [insurer.name, calculate_price(insurer)]
    end

    Hash[output]
  end

  private

  def calculate_price(insurer)
    matches = customer_request.matching_covers(insurer.covers)
    percentage = case matches.count
    when 1
      cover = matches.first
      level = customer_request.level_for_cover(cover)
      # 20% if highest
      # 25% if middle
      # 30% if lowest
      insurer.percentages[level]
    when 2
      # 10% of sum
      0.1
    else
      0
    end

    customer_request.sum_cover_limits(matches) * percentage
  end
end
