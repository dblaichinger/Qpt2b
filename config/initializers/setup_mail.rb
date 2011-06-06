    ActionMailer::Base.smtp_settings = {  
      :address              => "smtp.gmail.com",  
      :port                 => 587,  
      :domain               => "trashcan.heroku.com",  
      :user_name            => "trashcanny.service@gmail.com",  
      :password             => "qpt2bmmt",  
      :authentication       => "plain",  
      :enable_starttls_auto => true  
    }  
