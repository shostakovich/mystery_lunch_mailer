class Group
  attr_reader :participants

  def initialize(emails)
    @participants = emails.map do |email|
      full_name, _ = email.split '@'
      first_name, last_name = full_name.split '.'
      OpenStruct.new({ first_name: first_name.capitalize, last_name: last_name.capitalize, email: email })
    end
  end

  def size
    @participants.length
  end

  def to_h
    { size: size, participants: @participants }
  end
end