class Client < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]
  has_magick_columns name: :string, ident: :string

  IVA_KINDS = {
    iva_resp_insc: 'i',
    iva_resp_not_insc: 'R',
    not_resp: 'n',
    exempt_iva: 'e',
    resp_monot: 'm',
    final_consumer: 'f',
    not_categoriced: 's',
    social_monot: 't',
    small_event_contributor: 'c',
    social_small_event_contributor: 'v'
  }.with_indifferent_access.freeze

  #has_many :movements

  attr_accessible :email, :ident, :name, :phone, :address, :iva_responsive,
    :firm_name

  validates :name, :firm_name, :ident, :iva_responsive, presence: true 
  validates :name, :ident, uniqueness: true 

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
