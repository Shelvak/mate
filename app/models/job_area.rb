class JobArea < ActiveRecord::Base
  has_paper_trail

  attr_accessible :job_area, :provider_id

  belongs_to :providers

  validates :job_area, presence: true
  
  def to_s
    self.job_area
  end
end
