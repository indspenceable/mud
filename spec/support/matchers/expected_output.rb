RSpec::Matchers.define :have_output do |expected|
  match do |player|
    player.pending_output.gsub(/\e\[\d+m/,'').start_with? expected
  end
end