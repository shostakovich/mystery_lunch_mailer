require 'mustache'
class LunchMail
  def initialize(group)
    @group = group
  end

  def body
    template = File.read('./views/lunch_mail.txt')

    Mustache.render(template, @group.to_h)
  end

  def subject
    '[Mystery Lunch] Ihr seid heute Lunch-Partner'
  end

  def to
    @group.participants.map(&:email)
  end
end