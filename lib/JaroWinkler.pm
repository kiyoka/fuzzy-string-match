package Text::JaroWinkler;
use strict;
use warnings;
use Exporter::Lite;

our @EXPORT_OK = qw/distance/;

use Params::Validate qw/validate_pos/;
use List::Util qw/max min/;

sub distance {
    my ($s1, $s2) = validate_pos(@_, 1, 1);
    my @s1 = split //, $s1;
    my @s2 = split //, $s2;

    my ($max, $min);
    if (@s1 > @s2) {
        ($max, $min) = (\@s1, \@s2);
    } else {
        ($max, $min) = (\@s2, \@s1);
    }

    my $max_len = scalar @$max;
    my $min_len = scalar @$min;

    my $range = max($max_len / 2 - 1, 0);

    my $m_indexes = [];
    for (my $i = 0; $i < $min_len; $i++) {
        $m_indexes->[$i] = -1;
    }

    my $m_flags   = [];
    for (my $i = 0; $i < $max_len; $i++) {
        $m_flags->[$i] = undef;
    }

    my $matches   = 0;
    for (my $mi = 0; $mi < $min_len; $mi++) {
        my $c1 = $min->[$mi];

        my $xi = max($mi - $range, 0);
        my $xn = min($mi + $range + 1, $max_len);

        for (; $xi < $xn; $xi++) {
            if (!$m_flags->[$xi] && $c1 eq $max->[$xi]) {
                $m_indexes->[$mi] = $xi;
                $m_flags->[$xi] = 1;
                $matches++;
                last;
            }
        }
    }

    my $ms1 = [];
    my $ms2 = [];

    for (my ($i, $si) = (0, 0); $i < $min_len; $i++) {
        if ($m_indexes->[$i] != -1) {
            $ms1->[$si] = $min->[$i];
            $si++;
        }
    }

    for (my ($i, $si) = (0, 0); $i < $max_len; $i++) {
        if ($m_flags->[$i]) {
            $ms2->[$si] = $max->[$i];
            $si++;
        }
    }

    my $transpositions = 0;
    for (my $mi = 0; $mi < @$ms1; $mi++) {
        if ($ms1->[$mi] ne $ms2->[$mi]) {
            $transpositions++;
        }
    }

    my $prefix = 0;
    for (my $mi = 0; $mi < $min_len; $mi++) {
        if ($s1[$mi] eq $s2[$mi]) {
            $prefix++;
        } else {
            last;
        }
    }

    if ($matches == 0) {
        return 0;
    }
    my $t = sprintf "%d", $transpositions/ 2;

    my $j = (($matches / @s1) + ($matches / @s2) + (($matches - $t) / $matches)) / 3;
    my $jw = $j < 0.7 ? $j : $j + min(0.1, 1 / @$max) * $prefix * (1 - $j);
    return $jw;
}

1;

__END__

Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
