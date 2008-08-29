
module NotACaptchaMacros
  def should_render_captcha
    should 'render anticaptcha' do
      assert_select '#captcha'
    end
  end
end

require 'action_controller/test_case'
ActionController::TestCase.extend(NotACaptchaMacros)