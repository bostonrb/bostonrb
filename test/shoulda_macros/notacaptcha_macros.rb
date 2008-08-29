
module NotACaptchaMacros
  def should_render_captcha
    should 'render anticaptcha' do
      assert_select '#captcha'
    end
  end
  
  def should_foil_bots
    should_respond_with 404
  end
end

require 'action_controller/test_case'
ActionController::TestCase.extend(NotACaptchaMacros)