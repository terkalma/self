require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  describe 'GET event_table' do
    describe 'Simple user' do
      login_user

      it 'should not be allowed to access the table' do
        expect(subject.current_user).to be_an_instance_of User

        get :event_table, id: subject.current_user.id, format: :json
        expect(response).to redirect_to root_path(date: Date.today)
      end
    end

    describe 'Admin user' do
      login_admin

      let(:user) do
        user = FactoryGirl.create :user_with_projects, project_count: 1
        FactoryGirl.create :active_rate_for_user, payable: user

        7.times do |i|
          FactoryGirl.create :event, user: user, project: user.projects.first, worked_at: i.days.ago
        end
        user
      end

      it 'should be allowed to access the table' do
        get :event_table, id: user.id, format: :json

        expect(response).to be_success

        body = JSON.parse response.body
        expect(body['recordsFiltered']).to eq 7
        expect(body['aaData'].first.try :count).to eq 6
      end

      it 'should not respond to html' do
        get :event_table, id: user.id
        expect(response).to redirect_to admin_user_path(user.id)
      end
    end
  end
end
