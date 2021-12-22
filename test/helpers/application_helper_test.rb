class ApplicationHelperTest < ActionView::TestCase
  test 'flash type' do
    assert_equal 'danger', flash_type('error')
    assert_equal 'success', flash_type('success')
    assert_equal 'warning', flash_type('warning')
    assert_equal 'info', flash_type('info')
    assert_equal 'info', flash_type('info2')
  end
end
