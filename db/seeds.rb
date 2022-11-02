Faker::Config.locale = :ja

12.times do
  g_wallet = Glueby::Wallet.create
  wallet = Wallet.create! { |u| u.id = g_wallet.id }
  name = Faker::Name.name
  user = User.create!(name:, wallet_id: wallet.id)
  Glueby::Internal::RPC.client.generatetoaddress(1, g_wallet.internal_wallet.receive_address, ENV['AUTHORITY_KEY'])

  4.times do
    title = Faker::JapaneseMedia::Doraemon.gadget
    description = Faker::Lorem.paragraph
    price = rand(5..300) * 100
    Item.create!(user_id: user.id,
                 title:,
                 description:,
                 price:)
  end
end

`rails glueby:block_syncer:start`
