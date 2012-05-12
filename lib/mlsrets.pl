#!/usr/bin/perl

use strict;
use warnings;
use Net::FTP;
use LWP::UserAgent;
use HTTP::Cookies;
use IO::Socket;
use threads;
use threads::shared;
use Email::MIME;
use Data::Dumper;

my $imagesPath  = "/var/www/0-devizee.com/public/images/photo";
my $retsHost    = "rets.mlspin.com";

my $photo_num_map = {
       0     =>  0,
       1     =>  1,  2     =>  2,  3     =>  3,
       4     =>  4,  5     =>  5,  6     =>  6,
       7     =>  7,  8     =>  8,  9     =>  9,
       10    => 'A', 11    => 'B', 12    => 'C',
       13    => 'D', 14    => 'E', 15    => 'F',
       16    => 'G', 17    => 'H', 18    => 'I',
       19    => 'J', 20    => 'K', 21    => 'L',
       22    => 'M', 23    => 'N', 24    => 'O',
       25    => 'P', 26    => 'Q', 27    => 'R',
       28    => 'S', 29    => 'T', 30    => 'U',
       31    => 'V', 32    => 'W', 33    => 'X',
       34    => 'Y', 35    => 'Z'
   };

#Setup the LWP agent
my $ua = LWP::UserAgent->new;
$ua->cookie_jar(HTTP::Cookies->new(file => "$ENV{HOME}/.cookies.txt"));
$ua->timeout(10);
$ua->credentials("$retsHost:80","H3RETS", "CT002681", "kXTJVPQt");

#Login to mlspin
my $response = $ua->get("http://rets.mlspin.com/login/index.asp");

my $sock = new IO::Socket::INET (
    LocalHost   => 'localhost',
    LocalPort   => 7070,
    Proto       => 'tcp',
    Listen      => SOMAXCONN,
    Reuse       => 1
) or die ("Unable to create listening socket");

print "Ready to accept connections...\n";

while( my $client = $sock->accept() ) {

    my $mlsnum = <$client>;
    chomp($mlsnum);

    my ($thr) = threads->create(\&download_photo, $mlsnum, $client, $ua);
    $thr->detach();
}

sub download_photo {
    my $id     = shift;
    my $clfh   = shift;
    my $thua   = shift;

    my $id_1 = substr $id, 0, 2;
    my $id_2 = substr $id, 2, 3;
    my $id_3 = substr $id, 5, 3;

    #create the directory structure if it doesn't exist
    mkdir "$imagesPath/$id_1"       unless ( -d "$imagesPath/$id_1");
    mkdir "$imagesPath/$id_1/$id_2" unless ( -d "$imagesPath/$id_1/$id_2");

    print "Downloading photos for <$id>\n";

    my $thresponse = $thua->get("http://rets.mlspin.com/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:*");

    unless( $thresponse->is_success ) {
        print "Error downloading photos for <$id> ( http://rets.mlspin.com/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:* )\n";
        print $clfh "error\n";
        close $clfh;
        return;
    }

    #Concatinate the headers and content to form a valid response for Email::MIME
    my $full_response = $thresponse->headers()->as_string() . "\r\n" . $thresponse->content(); 

    #Stupid server isn't standards complient
    $full_response =~ s/(Object-ID.*?\r\n)/$1\r\n/mg;

    my $parsed = Email::MIME->new($full_response);
    my @images = $parsed->parts;

    #don't download photo 0
    for my $i (1 .. $#images) {
        print "downloading photo $i\n";
        open (FH, ">$imagesPath/$id_1/$id_2/${id_3}_" . $photo_num_map->{$i} . ".jpg");
            print FH $images[$i]->body_raw;
        close FH;
    }

    print $clfh "success\n";

    close $clfh;
}
