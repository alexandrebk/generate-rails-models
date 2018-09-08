rails new notre-nouveau-projet 
cd notre-nouveau-projet 
git init 
git add . 
git commit -m 'my first commit' 
hub create 
rails generate scaffold User first_name:text last_name:text email:text password:text description:text photos:text age:text avatar:text facebook_picture_url:text uid:integer 
rails generate scaffold Submission user:references trp:references content:text accepted:boolean 
rails generate scaffold Hike duration:datetime location:text distance:text asc_elevation:text desc_elevation:text alt_min:text alt_max:text difficulty:text hike_type:text description:text department:text photo:text title:text link:text photo_url:text ste:references coordinates:text 
rails generate scaffold Trip date:datetime location:text user:references hke:references description:text photos:text auto_accept:boolean seats:integer trip_type:text 
rails generate scaffold Review rating:text content:text sener:references recever:references trp:references 
rails generate scaffold Message trp:references content:text user:references 
rails generate scaffold Checkpoint hke:references lat:float lng:float ele:integer order:integer 
rails db:create 
rails db:migrate