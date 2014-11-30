require 'csv'

class LunchCsvParser
  def self.parse(csv)
    lunch_groups = []
    CSV.foreach(csv, :headers => true) do |row|
      lunch_group = [row["member 1"], row["member 2"], row["member 3"]]
      lunch_group.reject! {|email| email.empty? }
      lunch_groups << lunch_group
    end
    lunch_groups
  end
end