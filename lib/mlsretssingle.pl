#!/usr/bin/perl

use strict;
use warnings;
use Net::FTP;
use LWP::UserAgent;
use HTTP::Cookies;
use IO::Socket;
use threads;
use threads::shared;
use Data::Dumper;
use File::Copy;

#my $imagesPath  = "/home/eric/dev/rails/realtorest/public/images/photo";

my $basePath    = "/var/www";
my $imagesPath  = "$basePath/public/images/photo";
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

my $INPUT;
open($INPUT, "<$ARGV[0]") or die("Could not open <$ARGV[0]>: $!");

#Skip the first line
my $line = <$INPUT>;

while( $line = <$INPUT> ) {

    my @data = split(/\|/, $line);
    download_photo($data[1]);
}

sub download_photo {
    my $id     = shift;

    my $id_1 = substr $id, 0, 2;
    my $id_2 = substr $id, 2, 3;
    my $id_3 = substr $id, 5, 3;

    #create the directory structure if it doesn't exist
    mkdir "$imagesPath/$id_1"       unless ( -d "$imagesPath/$id_1");
    mkdir "$imagesPath/$id_1/$id_2" unless ( -d "$imagesPath/$id_1/$id_2");

    return if ( -s "$imagesPath/$id_1/$id_2/${id_3}_0.jpg" > 100);
    #return if ( -f "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");

    print "Downloading photo for <$id> <http://$retsHost/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:0>\n";

    my $thresponse = $ua->get("http://$retsHost/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:0");

    unless( $thresponse->is_success ) {
        print "Error downloading photos for <$id> ( http://$retsHost/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:0 )\n";
        return;
    }

    if ($thresponse->content =~ /No Object Found/) {
        print "Photo not available <$id> " . $thresponse->content . "\n";
        copy( "$basePath/app/assets/images/photo-not-available.jpeg", "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");
        return;
    }

    print "Found photo for <$id>\n";

    open (FH, ">$imagesPath/$id_1/$id_2/${id_3}_0.jpg");
        print FH $thresponse->content;
    close FH;

    return;
}
