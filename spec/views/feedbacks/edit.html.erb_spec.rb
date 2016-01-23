require 'rails_helper'

RSpec.describe "feedbacks/edit", type: :view do
  before(:each) do
    @feedback = assign(:feedback, Feedback.create!(
      :comment => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit feedback form" do
    render

    assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do

      assert_select "textarea#feedback_comment[name=?]", "feedback[comment]"

      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"
    end
  end
end
