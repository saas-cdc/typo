
Given /^the following articles exist$/ do |table|
  # table is a Cucumber::Ast::Table
  Article.create table.hashes
end

Given /^the following comments exist$/ do |table|
	table.hashes.each do |row|
		article = Article.find_by_title(row["articleTitle"])
		comment = article.comments.build
		comment.body = row["comment"]
		comment.author = User.find_by_email("joe@snow.com")
		comment.save!
	end
end

Then /^the article "(.*?)" should have body "(.*?)"$/ do |title, body|
	Article.find_by_title(title).body.should eq body
end

Then /^the article "(.*?)" should have comment "(.*?)"$/ do |article_title, comment|
	Article.find_by_title(article_title).comments.find_by_body(comment).should_not be_nil
end

Given /^I fill in "(.*?)" with the article id for "(.*?)"$/ do |input, articleTitle|
	article_id = Article.find_by_title(articleTitle).id
	steps %Q{
		Given I fill in "#{input}" with "#{article_id}"
	}	
end
