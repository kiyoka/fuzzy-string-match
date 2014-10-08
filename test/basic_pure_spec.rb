#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# basic_pure_spec.rb -  "Basic test-cases for FuzzyStringMatch module "
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

describe FuzzyStringMatch, "when some string distances (Pure) are" do
  before do
    @jarow = FuzzyStringMatch::JaroWinkler.create
  end
  it "should" do
    expect( @jarow.getDistance( "henka",     "henkan"    )).to be_within(0.0001).of(0.9722)
    expect( @jarow.getDistance( "al",        "al"        )).to be_within(0.0001).of(1.0)
    expect( @jarow.getDistance( "martha",    "marhta"    )).to be_within(0.0001).of(0.9611)
    expect( @jarow.getDistance( "jones",     "johnson"   )).to be_within(0.0001).of(0.8323)
    expect( @jarow.getDistance( "abcvwxyz",  "cabvwxyz"  )).to be_within(0.0001).of(0.9583)
    expect( @jarow.getDistance( "dwayne",    "duane"     )).to be_within(0.0001).of(0.8400)
    expect( @jarow.getDistance( "dixon",     "dicksonx"  )).to be_within(0.0001).of(0.8133)
    expect( @jarow.getDistance( "fvie",      "ten"       )).to be_within(0.0001).of(0.0)
    expect( @jarow.getDistance("zac ephron", "zac efron" )).to be > ( @jarow.getDistance("zac ephron", "kai ephron" ))
    expect( @jarow.getDistance("brittney spears", "britney spears" )).to be > ( @jarow.getDistance("brittney spears", "brittney startzman" ))
    expect( @jarow.pure?( )).to be true
  end
end

describe FuzzyStringMatch, "when older factory method was called, (Native) are" do
  it "should" do
    expect { FuzzyStringMatch::JaroWinkler.new.create( :pure ) }.to    raise_error(NoMethodError)
  end
end

