class WorkExperience < ApplicationRecord
  validates :company_name,
            :company_location,
            :start_date,
            :end_date,
            :job_title,
            :description,
            presence: :true
end
