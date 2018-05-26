rails new notre-nouveau-projet 
cd notre-nouveau-projet 
git init 
git add . 
git commit 
 hub create 
rails generate model User id:integer first_name:text last_name:text email:text password:text description:text photos:text age:text avatar:text facebook_picture_url:text uid:integer 
rails generate model Submission id:integer user_id:integer trip_id:integer content:text accepted:binary 
rails generate model Hike id:integer duration:time location:text distance:text asc_elevation:text desc_elevation:text alt_min:text alt_max:text difficulty:text hike_type:text description:text department:text photo:text title:text link:text photo_url:text site_id:text coordinates:text 
rails generate model Trip id:integer date:date location:text user_id:integer hike_id:integer description:text photos:text auto_accept:binary seats:integer trip_type:text 
rails generate model Review id:integer rating:text content:text sender_id:integer receiver_id:integer trip_id:integer 
rails generate model Message id:integer trip_id:integer content:text user_id:integer 
rails generate model Checkpoint id:integer hike_id:integer lat:decimal lng:decimal ele:integer order:integer 
rails db:create 
rails db:migrate