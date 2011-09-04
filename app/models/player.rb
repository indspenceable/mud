class Player < ActiveRecord::Base
  def process_input command
    output "You entered: #{command}"
  end
  def output text
    OUTPUT_BUFFERS[name] += text
  end
end
