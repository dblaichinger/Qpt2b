class UserMailer < ActionMailer::Base
  default :from => "trashcanny.service@gmail.com"

  def order_recieved(user)
    mail(:to => user.email, :subject => "Bestellung erhalten")
  end

  def order_declined(user_id)
    mail(:to => user.email, :subject => "Bestellung abgelehnt")
  end

  def order_confirmed(user_id)
    mail(:to => user.email, :subject => "Bestellung erfolgreich!")
  end

end
