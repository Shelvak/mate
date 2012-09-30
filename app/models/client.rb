class Client < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  has_magick_columns name: :string, ident: :string

  has_many :movements
  belongs_to :workplace

  attr_accessible :email, :ident, :name, :phone, :website, :workplace_id,
    :auto_workplace_name

  attr_accessor :auto_workplace_name

  validates :name, :email, :ident, presence: true 
  validates :name, :email, :ident, uniqueness: true 

  def to_s
    [self.name, self.ident].join(' - ')
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
