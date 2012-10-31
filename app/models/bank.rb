class Bank < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]
  has_magick_columns name: :string

  ACCOUNT_KINDS = {
    checking_account: 'c',
    savings_account: 's'
  }.with_indifferent_access.freeze

  MONEY_KINDS = {
    dollar: 'd',
    local: 'l'  
  }.with_indifferent_access.freeze

  scope :with_name, ->(name) { where("#{table_name}.name like ?", "#{name}%") }

  default_scope order('name ASC')

  attr_accessible :name, :website, :phone, :address, :contact_name, 
    :bank_accounts_attributes

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :bank_accounts, dependent: :destroy
  #has_many :movements

  accepts_nested_attributes_for :bank_accounts, allow_destroy: true,
    reject_if: ->(attrs) { 
      attrs['number'].blank? && attrs['office_number'].blank? 
    }


  def initialize(attributes = nil, options = {})
    super(attributes, options)
  
  end

  def to_s
    self.name
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
