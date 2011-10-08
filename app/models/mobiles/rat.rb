class Mobiles::Rat < Mobile
  after_save :init_data

  def take_action
    timeout = data_fields.find_by_key('timeout')
    val = timeout.value
    if val > 0
      timeout.value = val-1
    else
      room.echo "A filthy rat scurries about and growls at you."
      timeout.value = "10"
    end
    timeout.save!
  end

  def short_name
    "a filty rat"
  end
  def long_name
    "a filthy rat is scurries about here."
  end

  private
  def init_data
    data_fields.create(:key => 'timeout', :value => 10.to_s)
  end
end
