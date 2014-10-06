#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# mutibyte_spec.rb -  "Multibyte test-cases for FuzzyStringMatch module "
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

describe FuzzyStringMatch, "when some UTF8 string distances (Pure) are" do
  before do
    @jarow = FuzzyStringMatch::JaroWinkler.create
  end
  it "should" do
    expect( @jarow.getDistance( "ａｌ",              "ａｌ"             )).to be_within(0.0001).of(1.0)
    expect( @jarow.getDistance( "ｍａｒｔｈａ",      "ｍａｒｈｔａ"     )).to be_within(0.0001).of(0.9611)
    expect( @jarow.getDistance( "ｊｏｎｅｓ",        "ｊｏｈｎｓｏｎ"   )).to be_within(0.0001).of(0.8323)
    expect( @jarow.getDistance( "ａｂｃｖｗｘｙｚ",  "ｃａｂｖｗｘｙｚ" )).to be_within(0.0001).of(0.9583)
    expect( @jarow.getDistance( "ｄｗａｙｎｅ",      "ｄｕａｎｅ"       )).to be_within(0.0001).of(0.8400)
    expect( @jarow.getDistance( "ｄｉｘｏｎ",        "ｄｉｃｋｓｏｎｘ" )).to be_within(0.0001).of(0.8133)
    expect( @jarow.getDistance( "ｆｖｉｅ",          "ｔｅｎ"           )).to be_within(0.0001).of(0.0)
    expect( @jarow.getDistance("ｚａｃ　ｅｐｈｒｏｎ", "ｚａｃ　ｅｆｒｏｎ")).to be > ( @jarow.getDistance("ｚａｃ　ｅｐｈｒｏｎ", "ｋａｉ　ｅｐｈｒｏｎ" ))
    expect( @jarow.getDistance("ｂｒｉｔｔｎｅｙ　ｓｐｅａｒｓ", "ｂｒｉｔｎｅｙ　ｓｐｅａｒｓ")).to be > ( @jarow.getDistance("ｂｒｉｔｔｎｅｙ　ｓｐｅａｒｓ", "ｂｒｉｔｔｎｅｙ　ｓｔａｒｔｚｍａｎ" ))
    expect( @jarow.getDistance( "スパゲティー",              "スパゲッティー"             )).to be_within(0.0001).of(0.9666)
    expect( @jarow.getDistance( "スパゲティー",              "スパゲティ"                 )).to be_within(0.0001).of(0.9722)
    expect( @jarow.getDistance( "スティービー・ワンダー",    "スピーディー・ワンダー"     )).to be_within(0.0001).of(0.8561)
    expect( @jarow.getDistance( "マイケル・ジャクソン",      "ジャイケル・マクソン"       )).to be_within(0.0001).of(0.8000)
    expect( @jarow.getDistance( "まつもとゆきひろ",          "まつもとひろゆき"           )).to be_within(0.0001).of(0.9500)
    expect( @jarow.getDistance( "クライエント",              "クライアント"               )).to be_within(0.0001).of(0.9222)
    expect( @jarow.getDistance( "サーバー",                  "サーバ"                     )).to be_within(0.0001).of(0.9416)
    expect( @jarow.pure?( )).to be true
  end
end
