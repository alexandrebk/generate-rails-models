rails new notre-nouveau-projet 
cd notre-nouveau-projet 
git init 
git add . 
git commit -m 'my first commit' 
hub create 
rails generate scaffold User first_name:text last_name:text email:text password:text description:text photos:text age:text avatar:text facebook_picture_url:text uid:integer 
rails generate scaffold Submission content:text accepted:boolean 
rails generate scaffold Hike duration:datetime location:text distance:text asc_elevation:text desc_elevation:text alt_min:text alt_max:text difficulty:text hike_type:text description:text department:text photo:text title:text link:text photo_url:text coordinates:text 
rails generate scaffold Trip date:datetime location:text description:text photos:text auto_accept:boolean seats:integer trip_type:text 
rails generate scaffold Review rating:text content:text 
rails generate scaffold Message content:text 
rails generate scaffold Checkpoint lat:float lng:float ele:integer order:integer 
rails generate migration AddUserToSubmission user:references 
rails generate migration AddTripToSubmission trip:references 
rails generate migration AddSiteToHike site:references 
rails generate migration AddUserToTrip user:references 
rails generate migration AddHikeToTrip hike:references 
rails generate migration AddSenderToReview sender:references 
rails generate migration AddReceiverToReview receiver:references 
rails generate migration AddTripToReview trip:references 
rails generate migration AddTripToMessage trip:references 
rails generate migration AddUserToMessage user:references 
rails generate migration AddHikeToCheckpoint hike:references 
rails db:create 
rails db:migrate