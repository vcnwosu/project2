#!/usr/bin/perl

use strict;
use warnings;

# module for database connection
use DBI;

# connection configuration
my $usr = "";
my $passwd = "";
my $db = "db.sqlite3";
my $driver = "SQLite";
my $dsn = "DBI:$driver:dbname=$db";

#connect to the database
my $dbh = DBI->connect($dsn, $usr, $passwd);

# prepare and execute the statement
my $sth = $dbh->prepare("SELECT * FROM table_data");
$sth->execute();

print "-------------------------------------------\n";
print "First Name\tLast Name\tHome\n";
print "-------------------------------------------\n";

while(my $row = $sth->fetchrow_hashref) {
	# fetchrow_hashref apparently results in "undef" for database NULL
	# avoid "unitialized value" error by assinging empty string
	my $fname = $row->{first_name} ? $row->{first_name} : "";
	my $lname = $row->{last_name} ? $row->{last_name} : "";
	my $home = $row->{home} ? $row->{home} : "";

	print "$fname\t\t$lname\t\t$home\n";
}

print "\n\n";

# done.. disconnect
$dbh->disconnect;
