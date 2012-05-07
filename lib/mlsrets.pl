#!/usr/bin/perl

use strict;
use warnings;
use Net::FTP;
use LWP::UserAgent;
use HTTP::Cookies;

my $imagesPath = "/home/eric/dev/rails/realtorest/app/assets/images/mls/photo";
my $idxFile = "idx.txt.sorted";
my $retsHost = "rets.mlspin.com";

my $ua = LWP::UserAgent->new;
$ua->cookie_jar(HTTP::Cookies->new(file => "$ENV{HOME}/.cookies.txt"));
$ua->timeout(10);
$ua->credentials("$retsHost:80","H3RETS", "CT002681", "kXTJVPQt");
my $response = $ua->get("http://rets.mlspin.com/login/index.asp");
print $response->content;

open(IDX, "<$idxFile") or die ("Could not open <$idxFile>: $!");

while (my $id = <IDX>) {
    chomp($id);
    my $id_1 = substr $id, 0, 2;
    my $id_2 = substr $id, 2, 3;
    my $id_3 = substr $id, 5, 3;

    #No need to download if the file already exists
    next if (-f "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");

    #create the directory structure if it doesn't exist
    mkdir "$imagesPath/$id_1"       unless ( -d "$imagesPath/$id_1");
    mkdir "$imagesPath/$id_1/$id_2" unless ( -d "$imagesPath/$id_1/$id_2");

    print "Downloading <$imagesPath/$id_1/$id_2/${id_3}_0.jpg>\n";
    $response = $ua->get("http://rets.mlspin.com/getobject/index.asp?Type=Photo&Resource=Property&ID=$id:0",
                         ":content_file" => "$imagesPath/$id_1/$id_2/${id_3}_0.jpg");
    
}

close IDX;
