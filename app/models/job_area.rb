class JobArea < ActiveRecord::Base
  has_paper_trail
  has_magick_columns job_area: :string

  attr_accessible :job_area, :provider_id

  belongs_to :providers

  validates :job_area, presence: true
  
  def to_s
    self.job_area
  end

  alias_method :label, :to_s
  
  def as_json(options = nil)
    default_options = {
      only: [:id],
      methods: [:label]
    }
    
    super(default_options.merge(options || {}))
  end
  
  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
