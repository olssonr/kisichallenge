# Kisichallenge

- [x] Transparent enqueing with ActiveJob to Google Pub/Sub
- [ ] Adapter configuration
- [x] Worker script that subscribes to Pub/Sub and executes ActiveJobs
- [x] Rake task for worker script
- [ ] Pretty worker script
- [x] Retry 3 times if job fails
- [x] Retry at least 5 minutes apart
- [x] Move messages to dead letter queue after max retries
- [x] Collect Jobs performed total count and duration with ActiveSupport::Instrumentation
- [x] README

## Rails Sever

1. Configure the google pub sub adapter with your information. Currenlty you have to edit it, cause I didn't get autoload to work properly... The file resides in lib/active_job/queue_adapters/
2. Set GOOGLE_APPLICATION_CREDENTIALS to your service-account file e.g. export GOOGLE_APPLICATION_CREDENTIALS=/files_on_your_computer/service-account-file.json
3. Run `bin/rails server`
4. Visit localhost:3000 where you can schedule a job

## Background Job Execution

1. Configure subscription.rb with your google pub sub information.
2. Set GOOGLE_APPLICATION_CREDENTIALS to your service-account file e.g. export GOOGLE_APPLICATION_CREDENTIALS=/files_on_your_computer/service-account-file.json
3. Start the subscription in the rails environment. The reason we need to do this is to be able to subscribe to notifications from ActiveSupport.
    1. Start a rails console e.g `bin/rails console`
    2. In the console run `Kisichallenge::Application.load_tasks`
    3. In the console run `Rake::Task["jobs:subscribe"].invoke`
4. If you queue messages now they should be performed and counted
    1. To queue messages go to http://localhost:3000
    2. To view metrics for the Active Jobs go to http://localhost:3000/metrics

## How to configure Google Pub/Sub

1. To implement "enqueue" job to morgue queue, enable dead lettering in Google Pub/Sub and set max attempts to 5.
    1. Note that since we can not set to lower than 5 we need to check for number of delivery attempts and reject messages after 3 attempts. This is not optimal since unusful jobs will be left in the queue. I did a quick check in pub/sub API and did not find a method for giving up earlier. One way to implement this could be to manually queue the message to a dead letter queue and after that is successful ack the message to original queue.
2. To implement retry at least 5 minutes a part we simple go to "Retry policy" under our subscription in Google Pub/Sub and fill in 5 minutes as minimum. Exponential backoff delays are standard practice for retries so that is really good we have that out of the box in pub/sub.
