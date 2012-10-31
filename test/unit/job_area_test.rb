require 'test_helper'

class JobAreaTest < ActiveSupport::TestCase
  def setup
    @job_area = Fabricate(:job_area)
  end

  test 'create' do
    assert_difference ['JobArea.count', 'Version.count'] do
      @job_area = JobArea.create(Fabricate.attributes_for(:job_area))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'JobArea.count' do
        assert @job_area.update_attributes(job_area: 'Updated')
      end
    end

    assert_equal 'Updated', @job_area.reload.job_area
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('JobArea.count', -1) { @job_area.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @job_area.job_area = ''
    
    assert @job_area.invalid?
    assert_equal 1, @job_area.errors.size
    assert_equal [error_message_from_model(@job_area, :job_area, :blank)],
      @job_area.errors[:job_area]
  end

  test 'magick search' do
    3.times { Fabricate(
      :job_area, job_area: "enginer #{rand(99)}", provider_id: 1
    ) }
    
    job_areas = JobArea.magick_search('enginer')
    
    assert_equal 3, job_areas.count
    assert job_areas.all? { |u| u.to_s =~ /enginer/ }
    
    job_areas = JobArea.magick_search('inexisten')
    
    assert job_areas.empty?
  end
end
