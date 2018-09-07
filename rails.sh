rails new notre-nouveau-projet 
cd notre-nouveau-projet 
git init 
git add . 
git commit -m 'my first commit' 
hub create 
rails generate model User first_name:text last_name:text email:text password:text description:text photos:text age:text avatar:text facebook_picture_url:text uid:integer 
rails generate model Submission user:references trip:references content:text accepted:boolean 
rails generate model Hike duration:datetime location:text distance:text asc_elevation:text desc_elevation:text alt_min:text alt_max:text difficulty:text hike_type:text description:text department:text photo:text title:text link:text photo_url:text site:references coordinates:text 
rails generate model Trip date:datetime location:text user:references hike:references description:text photos:text auto_accept:boolean seats:integer trip_type:text 
rails generate model Review rating:text content:text sender:references receiver:references trip:references 
rails generate model Message trip:references content:text user:references 
rails generate model Checkpoint hike:references lat:float lng:float ele:integer order:integer 
rails db:create 
rails db:migrate