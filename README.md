# Kisichallenge

## Rails Sever

1. Configure the google pub sub adapter with your information. Currenlty you have to edit it, cause I didn't get autoload to work properly... The file resides in lib/active_job/queue_adapters/
2. Set GOOGLE_APPLICATION_CREDENTIALS to your service-account file e.g. export GOOGLE_APPLICATION_CREDENTIALS=/files_on_your_computer/service-account-file.json
3. Run `bin/rails server`
4. Visit localhost:3000 where you can schedule a job

## Background Job Execution

1. Configure subscription.rb with your google pub sub information.
2. Set GOOGLE_APPLICATION_CREDENTIALS to your service-account file e.g. export GOOGLE_APPLICATION_CREDENTIALS=/files_on_your_computer/service-account-file.json
3. Run ruby subscription.rb
4. It will start to consume messages
