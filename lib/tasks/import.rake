require 'csv'

desc "Import CSV data"
  task import: :environment do

    puts 'Destroying the database'
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all

    CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create!({
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
        })
    end
    puts "#{Customer.count} customers have been created"

    CSV.foreach('db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create!({
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
        })
    end
    puts "#{Merchant.count} merchants have been created"

    CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create({
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price].to_f/100,
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
    puts "#{Item.count} items have been created"

    CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create!({
        id: row[:id],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        status: row[:status],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
    puts "#{Invoice.count} invoices have been created"

    CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!({
        id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        quantity: row[:quantity],
        unit_price: row[:unit_price].to_f/100,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
        })
    end
    puts "#{InvoiceItem.count} invoice items have been created"

    CSV.foreach('db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      Transaction.create!({
        id: row[:id],
        invoice_id: row[:invoice_id],
        credit_card_number: row[:credit_card_number],
        credit_card_expiration_date: row[:credit_card_expiration_date],
        result: row[:result],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
    puts "#{Transaction.count} transactions have been created"

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    puts 'Congratulations. You have imported the data!'
  end
