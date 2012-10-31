class CreateJobAreas < ActiveRecord::Migration
  def change
    create_table :job_areas do |t|
      t.string :job_area
      t.integer :provider_id

      t.timestamps
    end

    add_index :job_areas, :provider_id
  end
end
