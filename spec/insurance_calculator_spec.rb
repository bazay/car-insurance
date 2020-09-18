require_relative './../lib/insurance_calculator'

RSpec.describe InsuranceCalculator do
  subject(:calculator) { described_class.new request, insurers }

  let(:request) do
    CustomerRequest.new(name: 'John', covers: covers, notify: 'email', notify_to: 'john@gg.com' )
  end
  let(:covers) { {"tires"=>10, "windows"=>50, "engine"=>20, "contents"=>30, "doors"=>15} }
  let(:insurers) { [insurer_a, insurer_b, insurer_c] }
  let(:insurer_a) { Insurer.new(name: 'insurer_a', covers: %w[windows contents]) }
  let(:insurer_b) { Insurer.new(name: 'insurer_b', covers: %w[tires contents]) }
  let(:insurer_c) { Insurer.new(name: 'insurer_c', covers: %w[doors engine]) }

  describe '#calculate' do
    subject { calculator.calculate }

    let(:expected_output) do
      {
        'insurer_a' => 8.0,
        'insurer_b' => 7.5,
        'insurer_c' => 6.0
      }
    end

    it { is_expected.to eql(expected_output) }
  end
end
