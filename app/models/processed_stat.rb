class ProcessedStat < ActiveRecord::Base
  attr_accessible :stat_id, :league_id, :value

  belongs_to :stat
  belongs_to :league

end
