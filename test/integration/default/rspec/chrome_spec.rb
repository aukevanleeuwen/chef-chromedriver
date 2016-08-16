require 'rspec_helper'
require 'rbconfig'

unless RbConfig::CONFIG['host_os'] =~ /linux/ && `cat /etc/*-release` =~ /CentOS release 6/
  describe 'Chrome Grid' do
    before(:all) do
      @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: :chrome)
    end

    after(:all) do
      @selenium.quit
    end

    res = MAC || WINDOWS ? '1024 x 768' : '1280 x 1024' # xvfb default res

    it "Should return display resolution of #{res}" do
      @selenium.get 'http://www.whatismyscreenresolution.com/'
      element = @selenium.find_element(:id, 'resolutionNumber')
      expect(element.text).to eq(res)
    end
  end
end
