require 'spec_helper'

feature 'BostonRB Admin Interface', %{
  As the BostonRB admin
  I want to manage blogs
} do

  include Blog::TestHelpers

  let(:blog_feed_directory) { "#{Rails.root}/tmp/blog_feeds" }
  let(:blog_1) { create(:blog, :author => 'Alex', :twitter_username => '@alex', :feed_url => "file://#{blog_feed_directory}/alex_atom.xml") }
  let(:blog_2) { build(:blog, :feed_url => "file://#{blog_feed_directory}/pat_feedburner_atom.xml")                                    }

  background do
    setup_blog_feeds('12_01_2011')
    visit root_path
    blog_1
  end

  scenario 'Logging in' do
    login
    visit admin_blogs_path
    page.driver.response.status.should == 200
  end

  scenario 'View existing blogs' do
    login
    visit admin_blogs_path
    have_basic_blog_content(blog_1, :should)
  end

  scenario 'Delete an existing blog' do
    login
    visit admin_blogs_path
    click_link 'Delete'
    have_basic_blog_content(blog_1, :should_not)
  end

  scenario 'Edit an existing blog' do
    login
    visit admin_blogs_path
    click_link 'Edit'
    blog_1.author = 'Alex Rothenberg'
    fill_in 'Author', :with => blog_1.author

    click_button 'Save Blog'

    have_basic_blog_content(blog_1, :should)
  end

  scenario 'Add new blog' do
    login
    visit admin_blogs_path
    click_link 'Add a blog'
    fill_in 'Author',            :with => blog_2.author
    fill_in 'Twitter Username',  :with => blog_2.twitter_username
    fill_in 'RSS/Atom feed url', :with => blog_2.feed_url

    click_button 'Save Blog'

    current_path.should eq(admin_blogs_path)
    have_basic_blog_content(blog_1, :should)
    have_basic_blog_content(blog_2, :should)
  end

  def login
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(name, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(name, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(name, password)
    else
      raise "I don't know how to log in!"
    end
  end

  def name
    'admin'
  end

  def password
    'password'
  end

end
