class CreateTimestamp < ActiveRecord::Migration[7.0]
  def change
    create_table :glueby_timestamps do |t|
      t.string   :txid
      t.integer  :status
      t.string   :content_hash
      t.string   :prefix
      t.string   :wallet_id
    end
  end
end
