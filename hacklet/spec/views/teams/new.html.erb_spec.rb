require 'rails_helper'

RSpec.describe "teams/new", type: :view do
  before(:each) do
    assign(:team, Team.new(
      :name => "MyString",
      :user => nil,
      :event => nil
    ))
  end

  it "renders new team form" do
    render

    assert_select "form[action=?][method=?]", teams_path, "post" do

      assert_select "input#team_name[name=?]", "team[name]"

      assert_select "input#team_user_id[name=?]", "team[user_id]"

      assert_select "input#team_event_id[name=?]", "team[event_id]"
    end
  end
end
