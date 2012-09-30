class Advance < BasicMove
  has_paper_trail

  has_magick_columns detail: :string

  attr_accessible :amount, :charged_at, :detail, :state

  validates :amount, :charged_at, :detail, presence: true

  validates :state, inclusion: { in: [true, false]}

  def to_s
    self.detail
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
