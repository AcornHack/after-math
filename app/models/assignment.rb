require 'twilio-ruby'

class Assignment < ActiveRecord::Base
  def send_update recipient
    twilio.messages.create(
      from: @from,
      to: recipient,
      body: message_text
    )
  end

  def message_text
    "You have #{due_assignments.count} pieces of work due tomorrow.\n #{assignment_text}"
  end

  def is_due
    due = Date.today...Date.current+2
    due === self.due_date.to_date
  end

  def is_past
    self.due_date.to_date < Date.today
  end

  private

  def twilio
    @twilio_sid ="AC633f83a8bfa280708ebe78a8cd7e8fbd"
    @twilio_auth_token = "783ae2538e34370ceb1a03fab434047d"
    @from = "+441491352066"
    Twilio::REST::Client.new @twilio_sid, @twilio_auth_token
  end

  def due_assignments
    Assignment.where('due_date BETWEEN ? AND ?', DateTime.now.tomorrow.beginning_of_day, DateTime.now.tomorrow.end_of_day).all
  end

  def assignment_text
    text = ""
    due_assignments.each do |assignment|
      text += "#{assignment.subject} - #{assignment.title}\n"
    end
    text
  end

end
