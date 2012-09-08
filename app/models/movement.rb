class Movement < ActiveRecord::Base
  attr_accessible :amount, :bank_id, :charged_at, :client_id, :code_id, :comment, :deposited_in, :devoted, :devoted_at, :mov_number, :total_amount
end
