class Movement < ActiveRecord::Base
  has_paper_trail  

  has_magick_columns mov_number: :string, devoted_at: :date, charged_at: :date

  belongs_to :bank
  belongs_to :client
  belongs_to :code

  attr_accessible :amount, :bank_id, :charged_at, :client_id, :code_id,
    :comment, :deposited_in, :devoted, :devoted_at, :mov_number, :total_amount, 
    :auto_bank_name, :auto_client_name, :auto_code_number

  attr_accessor :auto_bank_name, :auto_client_name, :auto_code_number

  validates :amount, :bank_id, :charged_at, :client_id, :code_id, :mov_number,
    presence: true

  validates :mov_number, uniqueness: true

  def to_s
    self.mov_number
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end

  def auto_attr_accessor_names
    attrs = []

    Movement.attr_accessible[:default].each do |a|
      matcher = a.match(/auto_(\w+)_\w+/)
      attrs << matcher[1] if matcher
    end

    attrs
  end
end
