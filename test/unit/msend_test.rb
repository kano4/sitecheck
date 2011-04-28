require 'test_helper'

class MsendTest < ActionMailer::TestCase
  test "send1" do
    @expected.subject = 'Msend#send1'
    @expected.body    = read_fixture('send1')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Msend.create_send1(@expected.date).encoded
  end

end
