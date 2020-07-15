class Revenue
  attr_reader :revenue

  def initialize (revenue)
    @revenue = revenue
  end

  def self.total_revenue_date_range(start_date, end_date)
    first_date = Date.parse(start_date).beginning_of_day
    last_date = Date.parse(end_date).end_of_day

    total_rev = Invoice.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .where('date(invoices.created_at) BETWEEN ? AND ?', first_date, last_date)
      .sum('quantity * unit_price')

    new(total_rev)
  end
end
