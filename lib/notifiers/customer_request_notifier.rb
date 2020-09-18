module Notifiers
  class CustomerRequestNotifier
    attr_reader :customer_request

    def initialize(customer_request)
      @customer_request = customer_request
    end

    def notify_insurance(insurance)
      dispatcher.notify_async(insurance)
    end

    private

    def dispatcher
      @dispatcher ||= begin
        case customer_request.notify
        when 'email'
          # Dispatch email e.g. ActionMailer
          ::Mailer.new(to: customer_request.notify_to)
        when 'sms'
          # Dispatch SMS e.g. TwilioSMS
          ::TwilioSMS.new(to: customer_request.notify_to)
        else
          raise ArgumentError, "Unsupported value: #{customer_request.notify}"
        end
      end
    end
  end
end

# Provided as an example
class Mailer
  attr_reader :to

  def initialize(to:)
    @to = to
  end

  def notify_async(insurance)
    # In reality this would enqueue a job providing insurance as a param
    # However, I simply return insurance to make it easier to test
    insurance
  end
end

class TwilioSMS < Mailer; end
