require 'csv'

desc "Import CSV data"
  task import: :environment do
    puts 'Resetting the database'

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_h)
    end

    puts 'Customers have been created'

    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    puts 'Merchants have been created'

    CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create({
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price].to_f / 100,
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end

    puts 'Items have been created'

    CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_h)
    end

    puts 'Invoices have been created'

    CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_h)
    end

    puts 'Invoice Items have been created'

    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end

    puts 'Transactions have been created'

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    puts 'Congratulations. You have imported the data!'
  end
