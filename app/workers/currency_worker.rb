class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}"

  def work(message)
    currency = JSON.parse(message)
    currency = Currency.create!(id: currency['id'], rates: currency['rates'])

    direct_exchange = channel.direct('currencies.direct', routing_key: 'acknowledgements')
    direct_exchange.publish({ id: ENV['QUEUE_ID'], uuid: currency.id }.to_json)

    ack!
  end

  private

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end
end
