class CreateCurrencies < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :currencies, id: :uuid do |t|
      t.json   :rates

      t.timestamps null: false
    end
  end
end
