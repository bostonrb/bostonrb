require 'test/unit'
require 'rubygems'
require 'fake_web'
require 'quietbacktrace'
require 'redgreen'

FakeWeb.allow_net_connect = false

CONTEXT_NOISE = %w(context)

backtrace_cleaner = QuietBacktrace::BacktraceCleaner.new
backtrace_cleaner.add_silencer { |line| line.include?(CONTEXT_NOISE) }

require 'context'
require 'matchy'
require 'pending'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib') )
require 'le_git'

