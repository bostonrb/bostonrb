require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase
  context 'pages routing' do
    should 'route /site/about to :controller => :pages, :action => :show, :name => :about' do
      assert_routing '/site/about', :controller => 'pages', :action => 'show', :name => 'about'
    end
  end
  
  context 'A GET to show the about page' do
    setup do
      get :show, :name => 'about'
    end
    
    should_respond_with :success
    should_render_template :about
  end
  
  context 'A GET to a nonexistant page' do
    setup do
      get :show, :name => 'something-fake'
    end
    
    should_respond_with 404
  end
end