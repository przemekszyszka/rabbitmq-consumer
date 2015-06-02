class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}"

  def work(message)
    currency = JSON.parse(message)
    currency = Currency.create(uuid: currency['id'], rates: currency['rates'])

    Publisher.publish({ id: ENV['QUEUE_ID'], uuid: currency.uuid })

    ack!
  end
end
