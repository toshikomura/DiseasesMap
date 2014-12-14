#!/bin/bash

echo "Seta variável de ambiente para encontrar GMaps4Rails"
export GEM_PATH=$GEM_PATH:/var/lib/gems/1.8/

#echo "Get CoffeeScript by Google-Maps-For-Rails"
#rails g gmaps4rails:copy_coffee

echo "Compila CoffeeScript em Javascript"
RAILS_ENV=development bundle exec rake assets:precompile
RAILS_ENV=development rake assets:precompile

echo "Run server com porta 2342"
echo "Acesso: localhost:2342/locations"
rails server -p2342
