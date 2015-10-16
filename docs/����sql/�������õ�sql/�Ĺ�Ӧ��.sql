select gdsmst_brandname,gdsmst_brand,gdsmst_provide,gdsmst_providestr
 from gdsmst where gdsmst_brand ='000672'

update gdsmst set gdsmst_provide='00000902',gdsmst_providestr='00001041,00000622' where gdsmst_brand ='000672'