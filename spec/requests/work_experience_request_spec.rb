require 'rails_helper'

RSpec.describe 'Work Experience API', type: :request do
  let!(:work_experiences) { create_list :work_experience, 2 }
  let(:work_experience) { work_experiences.first }

  describe 'GET /api/v1/work_experiences' do
    before { get '/api/v1/work_experiences' }

    it 'returns the all work experiences' do
      expect(json.size).to eq(2)
    end

    it 'returns a status code 200' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/work_experiences/:id' do
    before { get "/api/v1/work_experiences/#{work_experience_id}" }

    context 'when the record exists' do
      let(:work_experience_id) { work_experience.id }

      it 'returns work experiences' do
        expect(json['company_name']).to eq(work_experience.company_name)
        expect(json['company_location']).to eq(work_experience.company_location)
        expect(json['job_title']).to eq(work_experience.job_title)
        expect(json['description']).to eq(work_experience.description)
      end

      it 'returns a status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when the record does NOT exist' do
      let(:work_experience_id) { 999 }

      it 'returns status code 404' do
        expect(response.status).to eq(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find WorkExperience/)
      end
    end
  end

  describe 'POST /api/v1/work_experiences' do
    let(:valid_attributes) do
      {
        company_name: 'Company Name',
        company_location: 'Company Location',
        start_date: Time.now - 1.day,
        end_date: Time.now,
        job_title: 'Job Title',
        description: 'Description'
      }
    end

    context 'when the request is valid' do
      subject(:make_request) do
        post '/api/v1/work_experiences', params: valid_attributes
      end

      it 'creates a work experience' do
        aggregate_failures do
          expect{make_request}.to change(WorkExperience, :count).by(1)
          expect(json['company_name']).to eq('Company Name')
        end
      end

      it 'returns status code 201' do
        make_request
        expect(response.status).to eq(200)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        {
          company_location: 'Company Location',
          start_date: Time.now - 1.day,
          end_date: Time.now,
          job_title: 'Job Title',
          description: 'Description'
        }
      end
      before { post '/api/v1/work_experiences', params: invalid_attributes }

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Company name can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/work_experiences/:id' do
    let(:valid_attributes) do
      {
        company_name: 'New Company Name'
      }
    end

    context 'when the record exists' do
      before { put "/api/v1/work_experiences/#{work_experience.id}"}

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'DELETE /api/v1/work_experiences/:id' do
    before { delete "/api/v1/work_experiences/#{work_experience.id}"}

    it 'returns status code 204' do
      expect(response.status).to eq(204)
    end
  end
end
