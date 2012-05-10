#!/usr/bin/perl

use strict;
use warnings;
use Net::FTP;
use LWP::UserAgent;
use HTTP::Cookies;
use IO::Socket;
use threads;
use Email::MIME;
use Data::Dumper;

my $imagesPath  = "/home/eric/dev/rails/realtorest/public/images/photo";
my $retsHost    = "rets.mlspin.com";

#Setup the LWP agent
my $ua = LWP::UserAgent->new;
$ua->cookie_jar(HTTP::Cookies->new(file => "$ENV{HOME}/.cookies.txt"));
$ua->timeout(10);
$ua->credentials("$retsHost:80","H3RETS", "CT002681", "kXTJVPQt");

#Login to mlspin
my $response = $ua->get("http://rets.mlspin.com/login/index.asp");

#my $sock = new IO::Socket::INET (
#    LocalHost   => 'localhost',
#    LocalPort   => 7070,
#    Proto       => 'tcp',
#    Listen      => SOMAXCONN,
#    Reuse       => 1
#) or die ("Unable to create listening socket");
#
#print "Ready to accept connections...\n";
#
#while( my $client = $sock->accept() ) {
#
#    my $mlsnum = <$client>;
#    print $mlsnum;
#
#    print $client "Done with socket\n";
#
#    close $client or die ("Failed to close connection!");
#}



    my $id = '71359563';
    my $id_1 = substr $id, 0, 2;
    my $id_2 = substr $id, 2, 3;
    my $id_3 = substr $id, 5, 3;

    #No need to download if the file already exists
    #next if (-f "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");

    #create the directory structure if it doesn't exist
    mkdir "$imagesPath/$id_1"       unless ( -d "$imagesPath/$id_1");
    mkdir "$imagesPath/$id_1/$id_2" unless ( -d "$imagesPath/$id_1/$id_2");

    #print "Downloading <$imagesPath/$id_1/$id_2/${id_3}_0.jpg>\n";

    $response = $ua->get("http://rets.mlspin.com/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:*");

    my $full_response = $response->headers()->as_string() . "\r\n" . $response->content(); 


    #Stupid server isn't standards complient
    $full_response =~ s/(Object-ID.*?\r\n)/$1\r\n/mg;

    my $parsed = Email::MIME->new($full_response);
    my @images = $parsed->parts;

    for my $i (0 .. $#images) {
        open (FH, ">$imagesPath/$id_1/$id_2/${id_3}_$i.jpg");
            print FH $images[$i]->body_raw;
        close FH;
    }

    #$response = $ua->get("http://rets.mlspin.com/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:0",
    #                     ":content_file" => "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");
    
