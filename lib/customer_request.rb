require_relative './notifiers/customer_request_notifier'

class CustomerRequest
  attr_reader :name, :covers, :notify, :notify_to

  TOP_COVER_LIMIT = 3

  def initialize(name:, covers:, notify:, notify_to:)
    @name = name
    @covers = covers
    @notify = notify
    @notify_to = notify_to
  end

  def top_covers
    @top_covers ||= Hash[covers.sort_by { |_key, value| value }.last(TOP_COVER_LIMIT).reverse]
  end

  def matching_covers(covers_to_match)
    top_covers.keys & covers_to_match
  end

  def level_for_cover(cover)
    top_covers.keys.index(cover)
  end

  def cover_limit(cover)
    top_covers[cover]
  end

  def sum_cover_limits(covers)
    top_covers.values_at(*covers).sum
  end

  def notify_insurance(insurance_prices)
    notifier.notify_insurance(insurance_prices)
  end

  private

  def notifier
    @notifier ||= ::Notifiers::CustomerRequestNotifier.new(self)
  end
end
