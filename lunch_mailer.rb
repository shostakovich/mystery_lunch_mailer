require 'mail'
require 'dotenv'
require_relative 'lib/lunch_csv_parser'
require_relative 'lib/group_builder'
require_relative 'lib/lunch_mail'


Dotenv.load

Mail.defaults do
  delivery_method :smtp, {
    address: ENV.fetch('OUTLOOK_SERVER'),
    port: ENV.fetch('OUTLOOK_PORT'),
    domain: ENV.fetch('OUTLOOK_DOMAIN'),
    user_name: ENV.fetch('OUTLOOK_USER'),
    password: ENV.fetch('OUTLOOK_PASSWORD'),
    authentication: :login,
    enable_starttls_auto: true
  }
end

lunch_groups = LunchCsvParser.parse(ENV.fetch('CSV'))

@groups = GroupBuilder.new(lunch_groups).build

@groups.each do |group|
  mail = LunchMail.new(group)
  Mail.deliver do
    from    ENV.fetch('OUTLOOK_SENDER')
    to mail.to
    reply_to mail.to
    subject mail.subject
    body mail.body
  end
end

