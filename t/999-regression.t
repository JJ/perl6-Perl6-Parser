use v6;

use Test;
use Perl6::Parser;

my $pt = Perl6::Parser.new;
my $*VALIDATION-FAILURE-FATAL = True;
my $*FACTORY-FAILURE-FATAL = True;
my $*DEBUG = True;

subtest {
	plan 2;

	my $source = Q:to[_END_];
say <closed open>;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{say <closed open>};

my @quantities = flat (99 ... 1), 'No more', 99;

subtest {
	plan 2;

	my $source = Q:to[_END_];
my @quantities = flat (99 ... 1), 'No more', 99;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
sub foo( $a is copy ) { }
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
grammar Foo {
    token TOP { ^ <exp> $ { fail } }
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
grammar Foo {
    rule exp { <term>+ % <op> }
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
my @blocks;
@blocks.grep: { }
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{grep: {}};

subtest {
	plan 2;

	my $source = Q:to[_END_];
my \y = 1;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{my \y};

subtest {
	plan 2;

	my $source = Q:to[_END_];
class Bitmap {
  method fill-pixel($i) { }
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{method fill-pixel($i)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
my %dir = (
   "\e[A" => 'up',
   "\e[B" => 'down',
);
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{method fill-pixel($i)};

grammar Exp24 { rule term { <exp> | <digits> } }

subtest {
	plan 2;

	my $source = Q:to[_END_];
grammar Exp24 { rule term { <exp> | <digits> } }
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{alternation};

subtest {
	plan 2;

	my $source = Q:to[_END_];
say $[0];
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{contextualized};

subtest {
	plan 2;

	my $source = Q:to[_END_];
my @solved = [1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,' '];
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{list reference};

subtest {
	plan 2;

	my $source = Q:to[_END_];
role a_role {             # role to add a variable: foo,
   has $.foo is rw = 2;   # with an initial value of 2
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{class attribute traits};

subtest {
	plan 2;

	my $source = Q:to[_END_];
constant expansions = 1;
 
expansions[1].[2]
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{infix period};

subtest {
	plan 2;

	my $source = Q:to[_END_];
my @c;
rx/<@c>/;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{rx with bracketed array};

subtest {
	plan 2;

	my $source = Q:to[_END_];
for 99...1 -> $bottles { }

#| Prints a verse about a certain number of beers, possibly on a wall.
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
	ok $pt.validate( $p ), Q{valid};
	is $pt.to-string( $tree ), $source, Q{formatted};
}, Q{rx with bracketed array};

done-testing;

# vim: ft=perl6
