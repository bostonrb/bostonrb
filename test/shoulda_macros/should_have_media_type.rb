class Test::Unit::TestCase
  def raw_content_type
    (@response.headers["Content-Type"] || @response.headers["type"]).to_s
  end

  def content_type
    raw_content_type.split(';').first
  end

  def assert_response_media_type(expected)
    actual = content_type

    message = "Content Type '#{actual.inspect}' isn't '#{expected.inspect}'\n"
    message += "Body: #{@response.body.first(100).chomp} ..."

    assert_equal expected, actual, message
  end

  def self.should_have_media_type(media_type)
    should "have #{media_type.inspect} media type" do
      assert_response_media_type media_type
    end
  end
end

