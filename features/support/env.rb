$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__) + '/../../configs')
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'lib_helper'
require 'file_helper'
require 'global_configs'
require 'bus_configs'
require 'aria_configs'
require 'zimbra_configs'