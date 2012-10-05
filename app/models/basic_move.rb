class BasicMove < ActiveRecord::Base
  self.abstract_class = true

  has_paper_trail

  has_magick_columns detail: :string

  attr_accessible :amount, :charged_at, :detail, :state

  validates :amount, :charged_at, :detail, presence: true
  validates :amount, numericality: { allow_nil: true, allow_blank: true }
  validates :state, inclusion: { in: [true, false]}

  def initialize(attributes = nil, options = {})
    super(attributes, options)

    self.state ||= false
  end

  def to_s
    self.detail
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
