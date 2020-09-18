require_relative './../lib/insurer'
require 'rspec/its'

RSpec.describe Insurer do
  subject(:insurer) { described_class.new attributes }

  let(:attributes) { { name: name, covers: covers } }
  let(:name) { 'insurer_a' }
  let(:covers) { %w[windows contents] }
  let(:expected_percentages) { [0.2, 0.25, 0.3] }

  its(:name) { is_expected.to eq name }
  its(:covers) { is_expected.to eq covers }
  its(:percentages) { is_expected.to match_array expected_percentages }
end
