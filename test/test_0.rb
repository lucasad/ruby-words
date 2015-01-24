require 'simplecov'
SimpleCov.start  do
  add_filter "/engine/" # Don't test the engine here
  add_filter "/test/"
end
require 'scrabble'
