#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# basic_spec.rb -  "Basic test-cases for FuzzyStringMatch module "
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

describe FuzzyStringMatch, "when some string distances (Native) are" do
  before do
    @jarow = FuzzyStringMatch::JaroWinkler.create( :native )
  end
  it "should" do
    @jarow.getDistance( "henka",     "henkan"    ).should be_within(0.0001).of(0.9722)
    @jarow.getDistance( "al",        "al"        ).should == 1.0
    @jarow.getDistance( "martha",    "marhta"    ).should be_within(0.0001).of(0.9611)
    @jarow.getDistance( "jones",     "johnson"   ).should be_within(0.0001).of(0.8323)
    @jarow.getDistance( "abcvwxyz",  "cabvwxyz"  ).should be_within(0.0001).of(0.9583)
    @jarow.getDistance( "dwayne",    "duane"     ).should be_within(0.0001).of(0.8400)
    @jarow.getDistance( "dixon",     "dicksonx"  ).should be_within(0.0001).of(0.8133)
    @jarow.getDistance( "fvie",      "ten"       ).should == 0.0
    lambda {
      d1 = @jarow.getDistance("zac ephron", "zac efron")
      d2 = @jarow.getDistance("zac ephron", "kai ephron")
      d1 > d2
    }.should be_true
    lambda {
      d1 = @jarow.getDistance("brittney spears", "britney spears")
      d2 = @jarow.getDistance("brittney spears", "brittney startzman")
      d1 > d2
    }.should be_true

    @jarow.pure?( ).should == (RUBY_PLATFORM == "java")
  end
end


describe FuzzyStringMatch, "create Native mode object is default behavior" do
  before do
    @jarow = FuzzyStringMatch::JaroWinkler.create( )
  end
  it "should" do
    pending ("because JRuby always in pure mode.") if (RUBY_PLATFORM == "java")
    @jarow.pure?( ).should be_false
  end
end


describe FuzzyStringMatch, "when older factory method was called, (Native) are" do
  it "should" do
    lambda { FuzzyStringMatch::JaroWinkler.new.create( :native ) }.should    raise_error(NoMethodError)
  end
end
