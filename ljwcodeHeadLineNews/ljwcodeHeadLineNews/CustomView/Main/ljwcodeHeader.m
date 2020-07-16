//
//  ljwcodeHeader.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/20.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeHeader.h"

NSString *ljwcode_Base_url = @"https://is.snssdk.com/";
NSString *KHomeStopRefreshNot = @"homeStopRefreshNot";

NSString *ljwcode_VideoBase_url = @"https://i.snssdk.com/";

//http://i.snssdk.com/video/urls/v/1/toutiao/mp4/9583cca5fceb4c6b9ca749c214fd1f90?r=18723666135963302&s=3807690062&callback=tt_playerzfndr
/*
 import requests
 from pyquery import PyQuery as pq

 r = requests.get('http://www.toutiao.com/a6296462662335201793/')
 d = pq(r.content)
 vid = d('#video').attr('tt-videoid')

 import random

 r = str(random.random())[2:]

 import urlparse

 def right_shift(val, n):
     return val >> n if val >= 0 else (val + 0x100000000) >> n

 url = 'http://i.snssdk.com/video/urls/v/1/toutiao/mp4/%s' % vid
 n = urlparse.urlparse(url).path + '?r=' + r
 c = binascii.crc32(n)
 s = right_shift(c, 0)
 
 http://v4.pstatp.com/3fba24c5ac154ee6b10d8e02e8a4d1d3/5791c380/video/c/b880fb5c3561472e98e4e4ce97c2c89e/
 */

