class UserMailer < ActionMailer::Base
  default :from => "trashcanny.service@gmail.com"

  def order_recieved(user)
    mail(:to => user.email, :subject => "Bestellung erhalten", )
  end
end
