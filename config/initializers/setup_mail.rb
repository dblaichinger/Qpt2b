    ActionMailer::Base.smtp_settings = {  
      :address              => "smtp.gmail.com",  
      :port                 => 587,  
      :domain               => "heroku.com",  
      :user_name            => "trashcanny.service@gmail.com",  
      :password             => "*****",  
      :authentication       => "plain",  
      :enable_starttls_auto => true  
    }  
