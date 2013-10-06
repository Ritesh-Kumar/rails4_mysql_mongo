require 'spec_helper'

describe "movies/edit" do
  before(:each) do
    @movie = assign(:movie, stub_model(Movie,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit movie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", movie_path(@movie), "post" do
      assert_select "input#movie_name[name=?]", "movie[name]"
      assert_select "textarea#movie_description[name=?]", "movie[description]"
    end
  end
end
