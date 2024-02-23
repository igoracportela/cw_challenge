require "csv"
require "date"

namespace :report do
  desc "Generate token in database"

  task call: :environment do
    dataset_path = "./data-sample.csv"

    transaction_ids = []
    merchant_ids = []
    user_ids = []
    card_numbers = []
    transaction_dates = []
    transaction_amounts = []
    device_ids = []
    has_cbks = []

    CSV.foreach(dataset_path, headers: true) do |row|
      transaction_ids << row["transaction_id"]
      merchant_ids << row["merchant_id"]
      user_ids << row["user_id"]
      card_numbers << row["card_number"]
      transaction_dates << Date.parse(row["transaction_date"])
      transaction_amounts << row["transaction_amount"].to_f
      device_ids << row["device_id"]
      has_cbks << row["has_cbk"]
    end

    total_transactions = transaction_ids.length
    total_amount = transaction_amounts.sum
    average_amount = (total_amount / total_transactions).round(2)
    max_amount = transaction_amounts.max
    min_amount = transaction_amounts.min

    transaction_dates_by_month = transaction_dates.group_by { |date| date.strftime("%Y-%m") }
    most_common_month = transaction_dates_by_month.max_by { |_, dates| dates.length }.first

    user_transaction_counts = user_ids.tally
    most_active_users = user_transaction_counts.max_by(5) { |_, count| count }

    device_location_counts = device_ids.tally
    suspicious_devices = device_location_counts.select { |_, count| count > 1 }

    average_transactions_per_user = total_transactions / user_ids.uniq.length

    user_agents = device_ids.tally
    inconsistent_user_agents = user_agents.select { |_, count| count > 1 }

    transaction_dates = transaction_dates.map { |date| date.strftime("%D") }
    suspicious_dates = transaction_dates.tally.select { |count| count > (total_transactions / 24) * 2 }

    puts "Basic Analysis:"
    puts "Total transactions: #{total_transactions}"
    puts "Total amount: $#{total_amount}"
    puts "Avg transaction amount: $#{average_amount.round(2)}"
    puts "Max transaction amount: $#{max_amount}"
    puts "Min transaction amount: $#{min_amount}"

    puts "\nPattern Recognition:"
    puts "Most common month for transactions: #{most_common_month}"

    puts "\nUser Behavior Analysis:"
    puts "Top five most active users:"
    most_active_users.each { |user, count| puts "User: #{user}, Transaction Count: #{count}" }

    puts "\nGeographic Analysis:"
    puts "Suspicious devices with multiple transactions:"
    suspicious_devices.each { |device, count| puts "Device: #{device}, Transaction Count: #{count}" }

    puts "\nTransaction Frequency:"
    puts "Avg transactions per user: #{average_transactions_per_user}"

    puts "\nUser Agent Data:"
    puts "Devices with inconsistent user agents:"
    inconsistent_user_agents.each { |device, count| puts "Device: #{device}, Count: #{count}" }

    puts "\nTime Patterns:"
    puts "Unusual transaction dates:"
    suspicious_dates.each { |date, count| puts "Date: #{date}, Transaction Count: #{count}" }
  end
end
