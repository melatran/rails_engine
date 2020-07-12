require 'csv'

desc "Import CSV data"
  task import: :environment do
    puts 'Resetting the database'

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(
        id: row[0],
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end

    puts 'Customers have been created'

    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(
        id: row[0],
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4].to_f / 100,
        created_at: row[5],
        updated_at: row[6]
      )
    end

    puts 'Invoice Items have been created'

    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create(
        id: row[0],
        customer_id: row[1],
        merchant_id: row[2],
        status: row[3],
        created_at: row[4],
        updated_at: row[5]
      )
    end

    puts 'Invoices have been created'

    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create(
        id: row[0],
        name: row[1],
        description: row[2],
        unit_price: row[3].to_f / 100,
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end

    puts 'Items have been created'

    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create(
        id: row[0],
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
      )
    end

    puts 'Merchants have been created'

    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create(
        id: row[0],
        invoice_id: row[1],
        credit_card_number: row[2],
        credit_card_expiration_date: row[3],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end

    puts 'Transactions have been created'

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    puts 'Congratulations. You have imported the data!'
  end
