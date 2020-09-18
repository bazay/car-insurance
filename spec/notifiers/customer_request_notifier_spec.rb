require_relative './../../lib/notifiers/customer_request_notifier'
require_relative './../../lib/customer_request'
require 'rspec/its'

RSpec.describe Notifiers::CustomerRequestNotifier do
  subject(:notifier) { described_class.new(customer_request) }

  let(:customer_request) do
    CustomerRequest.new(name: name, covers: covers, notify: notify, notify_to: notify_to)
  end
  let(:name) { 'John' }
  let(:covers) { {"tires"=>10, "windows"=>50, "engine"=>20, "contents"=>30, "doors"=>15} }
  let(:notify) { 'email' }
  let(:notify_to) { 'john@gg.com' }

  its(:customer_request) { is_expected.to eq customer_request }

  describe '#notify_insurance' do
    subject(:notify_insurance) { notifier.notify_insurance(insurance) }

    let(:insurance) { { 'insurer_a' => 8.0 } }

    it { is_expected.to eql insurance }

    context 'when notify is sms' do
      let(:notify) { 'sms' }
      let(:notify_to) { '07111111111' }

      it { is_expected.to eql insurance }
    end

    context 'when notify is unsupported' do
      let(:notify) { 'cups_and_string' }

      it { expect { notify_insurance }.to raise_error(ArgumentError) }
    end
  end
end
