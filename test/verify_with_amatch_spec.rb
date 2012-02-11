#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# basic_spec.rb -  "Verify test-cases for FuzzyStringMatch module "
#  
#   Copyright (c) 2011  Kiyoka Nishiyama  <kiyoka@sumibi.org>
#
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  
require 'fuzzystringmatch'
require 'amatch'


def amatch_getDistance( s1, s2 )
  @jarow = Amatch::JaroWinkler.new( s1 )
  @jarow.match( s2 )
end

describe Amatch, "when use Amatch gem, results are" do
  it "should" do
    amatch_getDistance( "henka",     "henkan"    ).should be_within(0.0001).of(0.9666)  ## amatch's result value is different from lucene version.
    amatch_getDistance( "al",        "al"        ).should == 1.0
    amatch_getDistance( "martha",    "marhta"    ).should be_within(0.0001).of(0.9611)
    amatch_getDistance( "jones",     "johnson"   ).should be_within(0.0001).of(0.8323)
    amatch_getDistance( "abcvwxyz",  "cabvwxyz"  ).should be_within(0.0001).of(0.9583)
    amatch_getDistance( "dwayne",    "duane"     ).should be_within(0.0001).of(0.8400)
    amatch_getDistance( "dixon",     "dicksonx"  ).should be_within(0.0001).of(0.8133)
    amatch_getDistance( "fvie",      "ten"       ).should == 0.0
    lambda {
      d1 = amatch_getDistance("zac ephron", "zac efron")
      d2 = amatch_getDistance("zac ephron", "kai ephron")
      d1 > d2
    }.should be_true
    lambda {
      d1 = amatch_getDistance("brittney spears", "britney spears")
      d2 = amatch_getDistance("brittney spears", "brittney startzman")
      d1 > d2
    }.should be_true
  end
end
