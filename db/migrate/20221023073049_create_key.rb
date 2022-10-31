class CreateKey < ActiveRecord::Migration[7.0]
  def change
    create_table :glueby_keys do |t|
      t.string     :private_key
      t.string     :public_key
      t.string     :script_pubkey
      t.string     :label, index: true
      t.integer    :purpose
      t.belongs_to :wallet
      t.timestamps
    end

    add_index :glueby_keys, [:script_pubkey], unique: true
    add_index :glueby_keys, [:private_key], unique: true
  end
end
