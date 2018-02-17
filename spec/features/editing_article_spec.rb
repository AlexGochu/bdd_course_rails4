require 'rails_helper'

RSpec.feature "Editing an article" do
  
  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "Title One", body: "Body of article one", user: john)
  end
  
  scenario 'User updates an article' do
    
    visit "/"
    
    click_link @article.title
    click_link "Edit article"
    
    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body"
    
    click_button "Update Article"
    
    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article.id)) 
  end
  
  scenario 'User fail to update an article' do
    visit "/"
    
    click_link @article.title
    click_link "Edit article"
    
    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body of article"
    
    click_button "Update Article"
    
    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article.id)) 
  end
  
  
end