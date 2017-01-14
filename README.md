# DynamoDB Performance Test

This is a performance testing of AWS DynamoDB database. The purpose of it was to find out how DynamoDB behaves in a loaded system.

All tests were performed on a t2-micro instance against 3 tables filled with 1000, 10000 and 100000 rows (9 tests in total):
 * table *performance-1* didn't have secondary indices
 * table *performance-2* had one secondary index
 * table *performance-3* had two secondary indices

Feel free to investigate the source code of the test for more details.

![records: 1000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:ADFGB,Ahw9C,AAAAA,AABBB,,&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+1000)&cht=lc&chs=600x300&chxr=1,0.015922005201776425,8.759163408433087)

![records: 10000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:CEGEJ,McmJ9,ABCDE,BDFHJ,,&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+10000)&cht=lc&chs=600x300&chxr=1,0.014344453891731241,1.2414189605331047)

![records: 100000, table: performance-1](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:AABEG,AANn9,AAAAA,AAABB,,&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-1+(size+100000)&cht=lc&chs=600x300&chxr=1,0.017482292239108528,10.717166832184791)

![records: 1000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:BDEGB,Qiu9C,AAAAA,AAABB,AAAAB,AAABC&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+1000)&cht=lc&chs=600x300&chxr=1,0.024073964673337285,8.939037857325747)

![records: 10000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:CEHJL,NYq09,ABDEG,BDFIL,ACDEG,CEGIK&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+10000)&cht=lc&chs=600x300&chxr=1,0.013894481412571345,1.3324629840417765)

![records: 100000, table: performance-2](http://chart.apis.google.com/chart?chxl=0:|20|40|60|80|100&chxt=x,y&chco=da4242,d141b9,41d1c3,41d146,27477a,35277a&chd=s:AABEG,AAOm9,AAAAA,AAABB,AAAAA,AAABB&chdl=Write+avg|Write+top+avg|Read+avg|Read+top+avg|Query+avg|Query+top+avg&chtt=performance-2+(size+100000)&cht=lc&chs=600x300&chxr=1,0.014985507818097266,10.780680693998)
