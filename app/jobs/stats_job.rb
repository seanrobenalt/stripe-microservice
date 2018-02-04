class StatsJob < ApplicationJob
  queue_as :mailers

  after_perform do |job|
    self.class.set(wait: 1.week).perform_later
  end

  def perform
    AdminMailer.send_all_stats.deliver_later
  end
end
