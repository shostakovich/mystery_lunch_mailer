require_relative 'group'

class GroupBuilder
  def initialize(raw_groups)
    @raw_groups = raw_groups
  end

  def build
    if last_groups_make_full_group
      build_full_group
    else
      @raw_groups
    end.map do |group|
      Group.new(group)
    end
  end

  def build_full_group
    @raw_groups[0...-2].push(@raw_groups.last(2).flatten)
  end

  def last_groups_make_full_group
    @raw_groups.last(2).flatten.size == 4
  end
end