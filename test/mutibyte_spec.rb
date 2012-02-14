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
    @jarow.getDistance( "ａｌ",              "ａｌ"             ).should == 1.0
    @jarow.getDistance( "ｍａｒｔｈａ",      "ｍａｒｈｔａ"     ).should be_within(0.0001).of(0.9611)
    @jarow.getDistance( "ｊｏｎｅｓ",        "ｊｏｈｎｓｏｎ"   ).should be_within(0.0001).of(0.8323)
    @jarow.getDistance( "ａｂｃｖｗｘｙｚ",  "ｃａｂｖｗｘｙｚ" ).should be_within(0.0001).of(0.9583)
    @jarow.getDistance( "ｄｗａｙｎｅ",      "ｄｕａｎｅ"       ).should be_within(0.0001).of(0.8400)
    @jarow.getDistance( "ｄｉｘｏｎ",        "ｄｉｃｋｓｏｎｘ" ).should be_within(0.0001).of(0.8133)
    @jarow.getDistance( "ｆｖｉｅ",          "ｔｅｎ"           ).should == 0.0
    lambda {
      d1 = @jarow.getDistance("ｚａｃ　ｅｐｈｒｏｎ", "ｚａｃ　ｅｆｒｏｎ")
      d2 = @jarow.getDistance("ｚａｃ　ｅｐｈｒｏｎ", "ｋａｉ　ｅｐｈｒｏｎ")
      d1 > d2
    }.should be_true
    lambda {
      d1 = @jarow.getDistance("ｂｒｉｔｔｎｅｙ　ｓｐｅａｒｓ", "ｂｒｉｔｎｅｙ　ｓｐｅａｒｓ")
      d2 = @jarow.getDistance("ｂｒｉｔｔｎｅｙ　ｓｐｅａｒｓ", "ｂｒｉｔｔｎｅｙ　ｓｔａｒｔｚｍａｎ")
      d1 > d2
    }.should be_true
    @jarow.getDistance( "スパゲティー",              "スパゲッティー"             ).should be_within(0.0001).of(0.9666)
    @jarow.getDistance( "スパゲティー",              "スパゲティ"                 ).should be_within(0.0001).of(0.9722)
    @jarow.getDistance( "スティービー・ワンダー",    "スピーディー・ワンダー"     ).should be_within(0.0001).of(0.8561)
    @jarow.getDistance( "マイケル・ジャクソン",      "ジャイケル・マクソン"       ).should be_within(0.0001).of(0.8000)
    @jarow.getDistance( "まつもとゆきひろ",          "まつもとひろゆき"           ).should be_within(0.0001).of(0.9500)
    @jarow.getDistance( "クライエント",              "クライアント"               ).should be_within(0.0001).of(0.9222)
    @jarow.getDistance( "サーバー",                  "サーバ"                     ).should be_within(0.0001).of(0.9416)

    @jarow.pure?( ).should be_true
  end
end
