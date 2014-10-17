# -*- mode: ruby -*-
# vi: set ft=ruby :

$app_name = "YOUR_APP_NAME"
$DB_USER = "YOUR_DEV_USER"
$DB_PASS = "YOUR_DEV_USER_PASSWORD"

# -----------------------------------------------------------------------------
#
# Setup
#
# -----------------------------------------------------------------------------

# run apt-get update, but only if neccessary
exec { "apt-get update":
	command => "/usr/bin/apt-get update",
	onlyif => "/bin/sh -c '[ ! -f /tmp/apt.update ] || /usr/bin/find /etc/apt -cnewer /tmp/apt.update | /bin/grep . > /dev/null'"
}

# make sure apt-get update is run before
# anything else
Exec["apt-get update"] -> Package <| |>

# install vim
package { "vim": }

# update bashrc based on template
file { "bashrc": 
  path => "/home/vagrant/.bashrc",
  content => template("bashrc.erb")
}

# create database.yml from template
file { "database.yml": 
	path => "/vagrant/config/database.yml",
	content => template("database.yml.erb")
}

# -----------------------------------------------------------------------------
#
# Ruby
#
# -----------------------------------------------------------------------------

rbenv::install { 'vagrant':
  group => 'vagrant',
  home  => '/home/vagrant',
}

rbenv::compile { '1.9.3-p327':
  user => 'vagrant',
  home => '/home/vagrant',
  global => true
}

# -----------------------------------------------------------------------------
#
# Postgresql
#
# -----------------------------------------------------------------------------

# install postgresql
class { 'postgresql::server': }

# create the user (DEV)
postgresql::database_user { "${DB_USER}":
  password_hash => postgresql_password("${DB_USER}", "${DB_PASS}"),
  createdb => true,
  superuser => true
}

# need this package too...
package { "libpq-dev": }

# -----------------------------------------------------------------------------
#
# Rails, etc.
#
# -----------------------------------------------------------------------------

package { "nodejs": }


