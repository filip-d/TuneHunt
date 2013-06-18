class Flag < ActiveRecord::Base

  def self.useful_flags
    self.all.select{|flag| ["hit", "maybe", "shit", "joke"].include?(flag.key)}
  end

end
