## Gulp Rails Vagrant
This is a boilerplate vagrant + puppet setup to use Gulp & Rails.

## Things you Need
1. Vagrant - https://www.vagrantup.com/
2. VirtualBox - https://www.virtualbox.org/

## Setup
To get started place the Vagrantfile in the root of your application.
1. Move the `puppet` folder to your `config` directory
2. Open `puppet/manifests/vagrant.pp`
3. Change the variables in at the top of the file & save.
4. Place the Gulp Rails Boilerplate in a directory called `frontend` in the root of your application
5. Add the following to your `config/application.rb`
<pre>
    config.after_initialize do
        Thread.new do
            cmd = "cd frontend/ && gulp"

            if ENV['RAILS_ENV'] == "development"
                system(cmd)
            end
        end
    end
</pre>
This will run `gulp` each time your application starts, it will run silently in the background. You will still see errors popup if something goes wrong.
6. Adjust the `config/puppet/manifests/database.yml/erb` and supply the same credentials you did for your dev user in the `vagrant.pp` file

## Notes:
You can still run the boilerplate like a normal gulp project by `cd frontend/` and running `gulp`

## Install
1. vagrant up
2. vagrant ssh
3. `sudo apt-get install imagemagick libmagickwand-dev`
4. bundle install
5. rake db:create
6. rake db:migrate
7. rails s

## Node, NPM & Gulp
1. `sudo apt-get update`
2. `sudo apt-get install -y python-software-properties`
3. `sudo add-apt-repository ppa:chris-lea/node.js`
4. `sudo apt-get update`
5. `sudo apt-get install nodejs`
6. `sudo npm install gulp -g`

## How to work with the project
To work with the project a few things you will need to know.

1. All front-end related code ( styles / JS ) is in the `frontend` directory
2. All views and markup should be templated there first, you can edit these files by manually running gulp in the frontend directory.
3. When you're ready to bring those templates over to the app just copy your markup.