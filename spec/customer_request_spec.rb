require_relative './../lib/customer_request'
require 'rspec/its'

RSpec.describe CustomerRequest do
  subject(:request) { described_class.new attributes }

  let(:attributes) { { name: name, covers: covers, notify: notify, notify_to: notify_to } }
  let(:name) { 'John' }
  let(:covers) { {"tires"=>10, "windows"=>50, "engine"=>20, "contents"=>30, "doors"=>15} }
  let(:notify) { 'email' }
  let(:notify_to) { 'john@gg.com' }

  its(:name) { is_expected.to eq name }
  its(:covers) { is_expected.to eq covers }
  its(:notify) { is_expected.to eq notify }
  its(:notify_to) { is_expected.to eq notify_to }

  describe '#top_covers' do
    subject { request.top_covers }

    let(:expected_output) do
      {
        'windows' => 50,
        'contents' => 30,
        'engine' => 20
      }
    end

    it { is_expected.to eql expected_output }
  end

  describe '#matching_covers' do
    subject { request.matching_covers covers_to_match }

    let(:covers_to_match) { %w[windows contents excluded] }

    it { is_expected.to match_array %w[windows contents] }
  end

  describe '#level_for_cover' do
    subject { request.level_for_cover(cover) }

    let(:cover) { 'windows' }

    it { is_expected.to eql 0 }
  end

  describe '#cover_limit' do
    subject { request.cover_limit cover }

    let(:cover) { 'windows' }

    it { is_expected.to eql covers[cover] }
  end

  describe '#sum_cover_limits' do
    subject { request.sum_cover_limits selected_covers }

    let(:selected_covers) { %w[windows engine] }
    let(:expected) { covers['windows'] + covers['engine'] }

    it { is_expected.to eql expected }
  end
end
