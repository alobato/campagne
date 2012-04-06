# encoding: UTF-8
require 'mail'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    begin
      # http://my.rails-royce.org/2010/07/21/email-validation-in-ruby-on-rails-without-regexp/
      m = Mail::Address.new(value)
      # We must check that value contains a domain and that value is an email address
      r = m.domain && m.address == value
      t = m.__send__(:tree)
      # We need to dig into treetop
      # A valid domain must have dot_atom_text elements size > 1
      # user@localhost is excluded
      # treetop must respond to domain
      # We exclude valid email values like <user@localhost.com>
      # Hence we use m.__send__(tree).domain
      r &&= (t.domain.dot_atom_text.elements.size > 1)
    rescue Exception => e   
      r = false
    end
    record.errors[attribute] << (options[:message] || 'inválido') unless r
  end
end

class IncorrectEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    domains = %w(
      hotmail.com.br gmail.com.br
      hotamil.com hotimail.com hotmail.com.br hotmail.com.com hotmail.con hotmal.com hoymail.com hotmil.com
      gamil.com gmail.com.br gmal.com gmeil.com.br gmial.com
      teste.com teste.com.br
      yaoo.com
      .com.be
    )
    domains.each do |d|
      if value && value.include?("@#{d}")
        record.errors[attribute] << 'está incorreto'
        break
      end
    end
  end
end

class DeniedEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    domains = %w(mailinator.com dodgit.com uggsrock.com spambox.us spamhole.com spam.la trashymail.com guerrillamailblock.com spamspot.com spamfree tempomail.fr jetable.net maileater.com meltmail.com)
    domains.each do |d|
      if value && value.include?("@#{d}")
        record.errors[attribute] << 'inválido'
        break
      end
    end
  end
end
