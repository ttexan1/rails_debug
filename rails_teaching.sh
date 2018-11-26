#!/bin/bash
echo "start setting"
SCRIPTDIR=$(cd $(dirname $BASH_SOURCE); pwd)
echo $SCRIPTDIR
cd ~/Desktop; mkdir rails-debugger
cd rails-debugger
rails new $1
cd $1

echo "gem 'devise'" >> Gemfile;
echo "gem 'simple_form'" >> Gemfile;
echo "gem 'kaminari'" >> Gemfile;
echo "gem 'seed-fu', '~> 2.3'" >> Gemfile;
echo "gem 'pry-rails'" >> Gemfile;
echo "gem 'html2slim'" >> Gemfile;
echo "gem 'slim-rails'" >> Gemfile;
bundle install;

echo "~==========================~"
pwd

while true;do
  read -p "Do you use devise? [y/n] " yn
  case $yn in
      [Yy]* )
        echo "Start"
        rails g devise:install;
        echo "Middle"
        rails g devise user name:string;
        echo "End"
        break;
      ;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
  esac
done

echo "setting1"

while true;do
  read -p "Do you want to use scaffold? [y/n]" yn
  case $yn in
      [Yy]* )
        rails g scaffold store name:string age:integer description:string;
        break
      ;;
      [Nn]* )
        rails g model author name:string age:integer description:string;
        rails g controller stores index new create edit show update;
        break
      ;;
      * ) echo "Please answer yes or no.";;
  esac
done

echo "setting2"

while true;do
  read -p "Do you want to use nested models? [y/n]" yn
  case $yn in
      [Yy]* )
        rails g model book author_id:integer name:string published_at:datetime;
        break
      ;;
      [Nn]* )
        break
      ;;
      * ) echo "Please answer yes or no.";;
  esac
done

echo "setting3"

while true;do
  read -p "Do you want to use slim syntax instead of erb? [y/n]" yn
  case $yn in
      [Yy]* )
        for i in app/views/**/*.erb; do erb2slim $i ${i%erb}slim && rm $i; done
        break
      ;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
  esac
done

echo "finish setting"
rails db:migrate
