sudo /etc/init.d/postgresql stop
sudo cp /etc/postgresql/9.1/main/pg_hba.conf ./
sudo apt-get remove postgresql postgresql-9.1 -qq --purge
source /etc/lsb-release
echo "deb http://apt.postgresql.org/pub/repos/apt/ $DISTRIB_CODENAME-pgdg main" > pgdg.list
sudo mv pgdg.list /etc/apt/sources.list.d/
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install postgresql-9.2 postgresql-contrib-9.2 -qq
sudo /etc/init.d/postgresql stop
sudo cp ./pg_hba.conf /etc/postgresql/9.2/main
sudo /etc/init.d/postgresql start
psql -c 'create database test;' -U postgres
sudo apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -qq libgeos-dev libproj-dev postgresql-9.2-postgis
psql -d test -c 'CREATE EXTENSION postgis;' -U postgres