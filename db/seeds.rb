Faker::Config.locale = :ja

titles = [
  'ドロップイヤリング ブラウン',
  '目玉焼きのピンブローチ',
  'KYUSU (kuro) / 急須 (黒)',
  '本革 ネームタグ オイルレザー',
  'ハーブ石鹸',
  '手編みベビーシューズ',
  'クリスマスオーナメント',
  'アウターポンチョ ニット',
  'キャンバストートバッグ',
  '手編みニット帽子',
  'ラウンドプレート レッド',
  'ストライプ ガラスコップ',
  '金木犀のアロマキャンドル',
  '木のヨーグルトスプーン',
  '木製 花瓶',
  'ハーブ×フルーツジャム'
]

descriptions = [
  'ガーネット色とゴールド色組合わせがゴージャスなイヤリングです。華やかなデザインが装いのワンポイントにお勧めです',
  '目玉焼きのピンバッチを作りました！帽子やバッグ、ポーチなど色々なところにつけてお楽しみください！',
  '伝統的文様「アラレ」がほどこされた鉄製の急須です。贈り物や内祝いにも人気の高い商品です。',
  '本革を使ったシンプルなネームタグです。本革ならではの深い味わい、経年変化をお楽しみ下さい。',
  '3種類のオーガニックのハーブを混ぜ込んだ石鹸です。香りが良いのはもちろん、ハーブの栄養を含んでいるのでお肌にも良いです。',
  '手触りの良いコットン100%の糸で編んでいます。出産のお祝いにもおすすめです。',
  'ドアに飾ったりもみの木の飾り、お子様のお部屋にもおすすめ。',
  '模様編みを繋げてポンチョを作りました。フリーフォームで編み上げました。',
  'シンプルなデザインのトートバッグです。通勤・通学にもおすすめのアイテムです。',
  '手編みニット帽子です。プレゼント用の簡易ラッピングもございます。4種類のカラーバリエーションがあります。',
  'アイコニックなロングセラーのプレートです。メイン料理だけではなくサラダや前菜、パスタやカレーなど幅広くお使い頂けます。',
  '持ちやすくてしっかりしたコップです。ジュースやワイン、カクテルなど様々なリラックスタイムをおしゃれに彩ります。',
  'シンプルなアロマキャンドルなため、流行にかかわらず長い期間お使いいただけます。秋の夜長の読書など、リラックスタイムのお供に。',
  '底の平らな容器でも使いやすいサーバースプーンです。深めの容器でもすくいやすいように柄を長めにしてあります。',
  'サイズが小さめなので、少量のお花を飾るのにオススメです。そのまま飾っても素敵なインテリアになります。',
  '【手作り ハーブ×フルーツジャム】トーストやヨーグルトはもちろん、アイスクリームのトッピングにも最適です！'
]

def create_user(name: nil)
  g_wallet = Glueby::Wallet.create
  wallet = Wallet.create! { |u| u.id = g_wallet.id }
  Glueby::Internal::RPC.client.generatetoaddress(1, g_wallet.internal_wallet.receive_address, ENV['AUTHORITY_KEY'])
  User.create!(name: name || Faker::Name.name, wallet_id: wallet.id)
end

# create default user
create_user(name: '秋本 隼勢')

# create users
n = 0
12.times do |i|
  user = create_user
  next if i >= 8

  # create items
  2.times do
    Item.create!(user_id: user.id,
                 title: titles[n],
                 description: descriptions[n],
                 price: rand(5..300) * 100)
    n += 1
  end
end

# create dummy vote
dummy_user = create_user(name: 'dummy')
dummy_user.update!(id: 999)
2.upto(13) do |i|
  item = Item.create!(title: 'dummy', user: dummy_user, price: 1, txid: 'dummy', purchased_at: Time.current)
  vote_token = VoteToken.create!(user: dummy_user, item:, token_id: 'dummy', amount: 1)
  Vote.create!(votee: User.find(i), voter: dummy_user, vote_token:, amount: rand(50..300), txid: 'dummy')
end

# start block syncer
`rails glueby:block_syncer:start`
