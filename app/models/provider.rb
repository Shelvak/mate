class Provider < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]
  has_magick_columns name: :string, ident: :string, firm_name: :string

  attr_accessible :email, :ident, :name, :phone, :address, :iva_responsive,
    :firm_name, :job_areas_attributes


  validates :name, :firm_name, :ident, :iva_responsive, presence: true 
  validates :name, :ident, uniqueness: true 

  has_many :job_areas, dependent: :destroy

  accepts_nested_attributes_for :job_areas, allow_destroy: true,
    reject_if: ->(attrs) { attrs['job_area'].blank? }
  
  def to_s
    [self.firm_name, self.name].join(' - ')
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
