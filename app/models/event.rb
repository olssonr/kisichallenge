class Event < ApplicationRecord
  # TODO: we could also track number of retries in another field if we want
  enum status: {
    "Enqueued" => 0,
    "Started" => 1,
    "Performed" => 2,
    "Rejected" => 3,
    "Moved" => 4
  }
end
