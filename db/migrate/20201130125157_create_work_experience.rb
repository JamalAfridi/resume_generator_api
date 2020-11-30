class CreateWorkExperience < ActiveRecord::Migration[5.2]
  def change
    create_table :work_experiences do |t|
      t.string :company_name
      t.string :company_location
      t.datetime :start_date
      t.datetime :end_date
      t.string :job_title
      t.string :description

      t.timestamps
    end
  end
end
