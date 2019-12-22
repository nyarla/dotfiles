#!/usr/bin/env perl

use strict;
use warnings;

our $BASE_DIR = $ENV{'HOME'} . '/local/dev/src/github.com/nyarla/the.kalaclista.com-v2';
our $URI_RE   = qr{kalaclista:([^/]+?)/([^.]+)\.md};

sub main {
  my $protocol = shift;
  my ( $website, $path ) = ( $protocol =~ $URI_RE );

  $path =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/eg;

  my $file = join q{/}, ( $BASE_DIR, "src", $website, "content", "${path}.md" );

  if ( ! -e $file ) {
    my $out   = q{};

    if ( $website eq 'notes' ) {
      my $slug  = $path;
      my $date  = `date +%Y-%m-%dT%H:%M:%S`;
      chomp($date);

      $out .= <<~"EOF";
          ---
          type: notes
          title: "${slug}"
          slug: '${slug}'
          date: '${date}+09:00'
          ads: true
          fixme: false
          ---
          EOF
    } else {
      my ( $year, $month, $day, $hms ) = ( split qr{/}, $path );
      my ( $hour, $minute, $second ) = ( $hms =~ m{^(\d{2})(\d{2})(\d{2})$} );

      $out .= <<~"EOF";
          ---
          type: ${website}
          title: ""
          date: '${year}-${month}-${day}T${hour}:${minute}:${second}+09:00'
          slug: '${hms}'
          EOF

      if ( $website eq 'posts' ) {
        $out .= <<~'EOF';
        tags:
          -
        EOF
      }

      $out .= <<~'EOF';
        ads: true
        fixme: false
        ---
        EOF
    }
    
    if ( $website ne 'notes' ) {
      my $dir = `dirname ${file}`;
      chomp($dir);
      system(qw(mkdir -p), $dir);
    }

    open(my $fh, '>', $file);
    print $fh $out;
    close($fh);
  }

  my $code = system(qw(tmux list-sessions));
  if ( $code != 0 ) {
    open(my $eh, '>', $BASE_DIR . "/.edit");
    print $eh $file;
    close($eh);

    system(qq< mlterm -e zsh -c 'cd "${BASE_DIR}" && tmux-up' >);
  } else {
    system(qq< tmux new-window -a -c "${BASE_DIR}" vim -c NERDTree ${file} >);
  }
}

main(@ARGV);
