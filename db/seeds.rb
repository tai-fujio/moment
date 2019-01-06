cp = CurrencyPair.create!(
  name: 'btcjpy',
  key_currency: 'btc',
  settlement_currency: 'jpy'
)

u = User.create!(email: 'm@gmail.com', password: 'llllll')
b = DollcostAverageBot.create!(
  currency_pair_id: cp.id,
  start_at: Time.zone.now,
  level_base: 4_000_000,
  level_slope: -0.011_575,
  dca_interval_day: 1,
  dca_interval_hour: 0,
  dca_interval_minute: 0,
  dca_settlment_amount: 500,
  user_id: u.id
)

50.times do
  OrderLog.create!(
    bot_id: b.id,
    currency_pair_id: cp.id,
    job_id: SecureRandom.hex(16).to_s,
    message: Faker::Lorem.sentence
  )
end

b = TrailingStopBot.create(
  currency_pair_id: cp.id,
  start_at: Time.zone.now,
  level_base: 4_000_000,
  level_slope: 0.011_575,
  ts_key_amount: 0.004,
  user_id: u.id
)

50.times do
  OrderLog.create!(
    bot_id: b.id,
    currency_pair_id: cp.id,
    job_id: SecureRandom.hex(16).to_s,
    message: Faker::Lorem.sentence
  )
end

30.times do |i|
  u = User.create!(email: "user#{i}@gmail.com", password: 'llllll')
  if [true, false].sample
    b = DollcostAverageBot.create!(
      currency_pair_id: cp.id,
      start_at: Time.zone.now,
      level_base: 4_000_000,
      level_slope: -0.011_575,
      dca_interval_day: 1,
      dca_interval_hour: 0,
      dca_interval_minute: 0,
      dca_settlment_amount: 500,
      user_id: u.id
    )
  end

  rand(1..10).times do
    OrderLog.create!(
      bot_id: b.id,
      currency_pair_id: cp.id,
      job_id: SecureRandom.hex(16).to_s,
      message: Faker::Lorem.sentence
    )
  end

  next if [true, false].sample

  b = TrailingStopBot.create(
    currency_pair_id: cp.id,
    start_at: Time.zone.now,
    level_base: 4_000_000,
    level_slope: 0.011_575,
    ts_key_amount: 0.004,
    user_id: u.id
  )

  rand(1..10).times do
    OrderLog.create!(
      bot_id: b.id,
      currency_pair_id: cp.id,
      job_id: SecureRandom.hex(16).to_s,
      message: Faker::Lorem.sentence
    )
  end
end
