# encoding: utf-8

require 'helper'

class Nanoc::Haml::FilterTest < Minitest::Test

  def test_filter
    # Create filter
    filter = ::Nanoc::Haml::Filter.new({ :question => 'Is this the Payne residence?' })

    # Run filter (no assigns)
    result = filter.run('%html')
    assert_match(/<html>.*<\/html>/, result)

    # Run filter (assigns without @)
    result = filter.run('%p= question')
    assert_equal("<p>Is this the Payne residence?</p>\n", result)

    # Run filter (assigns with @)
    result = filter.run('%p= @question')
    assert_equal("<p>Is this the Payne residence?</p>\n", result)
  end

  def test_filter_with_params
    # Create filter
    filter = ::Nanoc::Haml::Filter.new({ :foo => 'bar' })

    # Check with HTML5
    result = filter.run('%img', :format => :html5)
    assert_match(/<img>/, result)

    # Check with XHTML
    result = filter.run('%img', :format => :xhtml)
    assert_match(/<img\s*\/>/, result)
  end

  def test_filter_error
    # Create filter
    filter = ::Nanoc::Haml::Filter.new({ :foo => 'bar' })

    # Run filter
    raised = false
    begin
      filter.run('%p= this isn\'t really ruby so it\'ll break, muahaha')
    rescue SyntaxError, Haml::SyntaxError => e
      e.message =~ /(.+?):\d+: /
      assert_match '?', $1
      raised = true
    end
    assert raised
  end

  def test_filter_with_yield
    # Create filter
    filter = ::Nanoc::Haml::Filter.new({ :content => 'Is this the Payne residence?' })

    # Run filter
    result = filter.run('%p= yield')
    assert_equal("<p>Is this the Payne residence?</p>\n", result)
  end

  def test_filter_with_yield_without_content
    # Create filter
    filter = ::Nanoc::Haml::Filter.new({ :location => 'Is this the Payne residence?' })

    # Run filter
    assert_raises LocalJumpError do
      filter.run('%p= yield')
    end
  end

  def test_filter_with_proper_indentation
    # Create file to include
    File.open('stuff', 'w') do |io|
      io.write("<pre>Max Payne\nMona Sax</pre>")
    end

    # Run filter
    filter = ::Nanoc::Haml::Filter.new
    result = filter.run("%body\n  ~ File.read('stuff')")
    assert_match(/Max Payne&#x000A;Mona Sax/, result)
  end

end
