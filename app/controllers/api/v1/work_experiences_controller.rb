module Api
  module V1
    class WorkExperiencesController < ApplicationController
      before_action :find_work_experience, only: [:show, :update, :destroy]

      def index
        @work_experiences = WorkExperience.all
        json_response @work_experiences
      end

      def show
        json_response @work_experience
      end

      def create
        @work_experience = WorkExperience.create!(work_experience_params)
        json_response @work_experience
      end

      def update
        @work_experience.update(work_experience_params)
        head :no_content
      end

      def destroy
        @work_experience.destroy
        head :no_content
      end

      private

      def find_work_experience
        @work_experience = WorkExperience.find(params[:id])
      end

      def work_experience_params
        params.permit(:company_name,
                      :company_location,
                      :start_date,
                      :end_date,
                      :job_title,
                      :description)
      end
   end
  end
end
