class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :revenue
  set_id 'nil?'
end
