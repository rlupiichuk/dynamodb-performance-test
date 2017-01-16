# DynamoDB Performance Test

This is a performance testing of AWS DynamoDB database. The purpose of it was to find out how DynamoDB behaves in a loaded system.

All tests were performed on a t2-micro instance against 3 tables:
 * table *performance-1* didn't have secondary indices
 * table *performance-2* had one secondary index
 * table *performance-3* had two secondary indices

Axes are time in seconds and operations per second.

Feel free to investigate the source code of the test for more details.

![records: 1000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:DFLKT,JOal9,EFHHM,BDHJO,FKQZb,,&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+1000)&cht=lc&chs=600x300&chxr=1,0.014120031875296757,0.4804469841904938)

![records: 10000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:HNSXd,Pbkz9,HNPPZ,DJNUY,JUeqv,,&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+10000)&cht=lc&chs=600x300&chxr=1,0.014717743662844812,0.24007440203661098)

![records: 100000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:AABEG,AAOn9,AACFI,AAAAA,AAABB,,&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+100000)&cht=lc&chs=600x300&chxr=1,0.017725435918291153,10.526821139906067)

![records: 1000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:DMSZg,Kap49,DJNRe,DHKQY,IQZro,DFQQZ,IPmlt&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+1000)&cht=lc&chs=600x300&chxr=1,0.016371830722426886,0.30759089968167247)

![records: 10000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:HNTae,OYly9,HMTZe,DJQVV,JVfnt,DLQWe,IWfp0&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+10000)&cht=lc&chs=600x300&chxr=1,0.013735300933376198,0.2608892501378432)

![records: 100000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:AABEG,AAOn9,AACFI,AAAAA,AAAAB,AAAAA,AAABB&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+100000)&cht=lc&chs=600x300&chxr=1,0.01632581711767567,10.623907468800061)

![records: 1000, table: performance-3](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:DLQXb,KWl9z,DKNOW,CJLRU,FPZik,DHNPQ,IOZpi&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-3+(size+1000)&cht=lc&chs=600x300&chxr=1,0.01315569595994798,0.3467134748119861)

![records: 10000, table: performance-3](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:HOUbh,Oao19,HOUbd,DFOXZ,JNeq0,EISYf,KSir3&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-3+(size+10000)&cht=lc&chs=600x300&chxr=1,0.01515239770369154,0.24871675834571944)

![records: 100000, table: performance-3](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:AABEG,AANm9,AACFI,AAAAA,AAABB,AAAAA,AAABB&chdl=Write+avg|Write+top+avg|Write+full+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-3+(size+100000)&cht=lc&chs=600x300&chxr=1,0.016166297633346094,10.711134573750616)
