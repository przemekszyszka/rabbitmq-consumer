class ReplaceUuidWithIdInCurrencies < ActiveRecord::Migration
  def change
    remove_column :currencies, :id
    add_column :currencies, :id, :primary_key
    add_column :currencies, :uuid, :string
  end
end
