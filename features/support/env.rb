$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__) + '/../../test_data')
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'lib_helper'
require 'bus_data'
require 'aria_data'