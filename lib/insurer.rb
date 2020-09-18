class Insurer
  attr_reader :name, :covers

  def initialize(name:, covers:)
    @name = name
    @covers = covers
  end

  def percentages
    [0.2, 0.25, 0.3]
  end
end
