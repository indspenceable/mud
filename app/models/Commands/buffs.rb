class Commands::Buffs < Command
  def perform player, arguments
    all_buffs = player.buffs
    if all_buffs.count > 0
      all_buffs.buffs.tap do |b|
        if b.count > 0
          player.output "Buffs:"
          b.each do |buff|
            player.output buff.name
          end
        end
      end
      all_buffs.debuffs.tap do |b|
        if b.count > 0
          player.output "Debuffs:"
          b.each do |buff|
            player.output buff.name
          end
        end
      end
    end
  else
    player.output "No buffs."
  end
end