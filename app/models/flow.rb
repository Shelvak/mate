class Flow < ActiveRecord::Base
  has_paper_trail

  attr_accessible :code, :subcode, :charged_at, :detail, :receipt, :register,
    :total_amount, :in

  validates :code, :subcode, :charged_at, :detail, :total_amount, presence: true
  validates :receipt, :register, numericality: true, allow_blank: true, 
    allow_nil: true
  validates :in, inclusion: { in: [true, false] }

  def to_s
    [self.code, self.subcode].join(' - ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
