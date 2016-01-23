require 'rails_helper'

RSpec.describe "feedbacks/index", type: :view do
  before(:each) do
    assign(:feedbacks, [
      Feedback.create!(
        :comment => "MyText",
        :user_id => 1
      ),
      Feedback.create!(
        :comment => "MyText",
        :user_id => 1
      )
    ])
  end

  it "renders a list of feedbacks" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
