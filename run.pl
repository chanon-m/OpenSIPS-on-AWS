#!/usr/bin/perl -w
use strict;

my ($public_ip,$private_ip,$voice_mail,$sip_trunk) = @ARGV;
my @keys = ("PUBLIC_IP","PRIVATE_IP","VOICE_MAIL_IP","SIP_TRUNK_IP");
my $lines;

if(-d "/etc/opensips") {

    #read opensips configuration file
    open(my $fh, '<', "opensips.cfg") or die "1";
    while(my $line = <$fh>) {
           my $i = 0;
           foreach my $key (@keys) {
               $line =~ s/$key/$ARGV[$i]/;
               $i++;
           }
           $lines .= $line;
    }
    close $fh;

    #save and copy opensips.cfg
    open($fh, '>',"opensips.cfg.save") or die "2";
    print $fh $lines;
    close $fh;

    my $returncode = system("mv -f ./opensips.cfg.save /etc/opensips/opensips.cfg");
    print "3" if($returncode != 0); #failed

    print "0"; #success

} else {
    print "4"; #can't find opensips directory
}
