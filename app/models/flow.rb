class Flow < ActiveRecord::Base
  has_paper_trail

  attr_accessible :code, :subcode, :charged_at, :detail, :receipt, :register,
    :total_amount, :in, :cashes_attributes

  before_save :delete_void_cashes

  validates :code, :subcode, :charged_at, :detail, :total_amount, presence: true
  validates :receipt, :register, numericality: true, allow_blank: true, 
    allow_nil: true
  validates :in, inclusion: { in: [true, false] }

  has_many :cashes, dependent: :destroy

  accepts_nested_attributes_for :cashes, allow_destroy: false,
    reject_if: ->(attributes) { attributes['amount'].to_f <= 0 }

  def initialize(attributes = nil, options = {})
    super(attributes, options)
  
    self.cashes.build if self.cashes.count == 0
  end

  def to_s
    [self.code, self.subcode].join(' - ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end

  def delete_void_cashes
    self.cashes.each { |c| c.destroy if c.amount <= 0 }
  end
end
