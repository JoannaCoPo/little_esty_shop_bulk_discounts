# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'
Rails.application.load_tasks
# csv_tasks = [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]

namespace :load_csv do
  desc "Import cusomters from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/customers.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data customers.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end
  end

  desc "Import merchants from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/merchants.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data merchants.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end
  end

  desc "Import invoices from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/invoices.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data invoices.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
    end
  end

  desc "Import items from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/items.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data items.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
    end
  end

  desc "Import invoice items from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/invoice_items.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data invoice_items.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
    end
  end

  desc "Import transactions from CSV file"
  task :import => :environment do
    path = END.fetch('db/data/invoice_items.csv') {
      File.join(File.dirname(__FILE__), %w[.. .. db data transactions.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
    end
  end

  desc 'run all csv files'
  task all: %W(customers merchants invoices items invoice_items transactions) do
    Rails.env = 'development'
    print "All CSV files loaded. \n"
  end
end
