class Test::Unit::TestCase
  class << self
    def passing_captcha_context
      context 'When passing recaptcha' do
        setup do
          @controller.stubs(:verify_recaptcha).returns(true)
        end
        yield
      end
    end
    
    def failing_captcha_context
      context 'When not passing recaptcha' do
        setup do
          @controller.stubs(:verify_recaptcha).returns(false)
        end
        yield
      end
    end
  end
end