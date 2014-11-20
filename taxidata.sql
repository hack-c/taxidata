


--Most Winningest Cabbies
-------------------------

SELECT 
  earnings, 
  trips,
  (earnings / trips) as avg_fare
  medallion, 
FROM
  (SELECT
    ROUND(SUM(FLOAT(total_amount)), 2) AS earnings,
    medallion,
    count(*) AS trips
  FROM
    [833682135931:nyctaxi.trip_fare]
  GROUP EACH BY
    medallion
  ORDER BY
    hustle DESC
  LIMIT
    10)


earnings,trips,avg_fare,medallion
894549.01,15151,59.04224209623127,89EDAF45090C74611B52AFFC3E10A69D
739888.6,12278,60.26132920671119,CC664699259C9867E735976611A82F64
427608.96,19744,21.657666126418153,155EBAC6C5A22D6CFD3518F6A0E9190C
324753.63,18895,17.187278645144218,D4CA68ECC21536DE406F3D58C7813241
316144.67,22735,13.9056375632285,19E063791B0DF5A558B8488180DDAB67
314569.01,21066,14.932545808411659,8DEB70907D00AA1D7FF5E2683240549B
314350.28,22460,13.996005342831703,C2A40A5B0F1B26BF17FD07F91CD6176C
310220.79,23227,13.356042106169543,B6585890F68EE02702F32DECDEABC2A8
309505.65,23011,13.450334622571814,DACFA6EF35923081481A22BE96339B6E
307047.84,20834,14.737824709609294,49618C1CB1B96F6884917A4FF2A849D2
305662.46,24536,12.457713563743072,20BA941F62CC07F1FA3EF3E122B1E9B2
304590.85,22607,13.47329809351086,9F1FEF916240E64AD4EC5B7883E6A435
304512.95,21363,14.254222253428827,2C159C8FCCDE50174CF6CFC07E75F1BA
303085.82,21563,14.055828038770116,E5D06DBAEF87F704EA5D8F5D584C22D4
303047.85,20729,14.619511312653769,6945300E90C69061B463CCDA370DE5D6
303043.32,22733,13.330546782210883,8CE240F0796D072D5DCFE06A364FB5A0
302885.46,22421,13.509007626778468,2F2F160D8428A7757500371F980468D5
301504.86,22150,13.611957562076748,33955A2FCAF62C6E91A11AE97D96C99A
301251.87,21868,13.775922352295591,BC9EE7F807E71ACA2AEA11CAB51604F8
300969.58,20488,14.690041975790708,F2967DBF707C06314CEB745A83332D62


--'Best' Cabbies (highest distance per fare)
----------------------------------------------

SELECT
  ROUND((total_distance / earnings),2) AS miles_per_dolla,
  total_distance,
  earnings,
  tips,
  trips,
  trip_data.medallion AS medallion
FROM
  (SELECT
    trip_data.medallion,
    ROUND(SUM( (3959 * acos( cos(radians(FLOAT(trip_data.pickup_latitude)))*cos(radians(FLOAT(trip_data.dropoff_latitude)))*cos(radians(FLOAT(trip_data.dropoff_longitude))-radians(FLOAT(trip_data.pickup_longitude))) + sin(radians(FLOAT(trip_data.pickup_latitude)))*sin(radians(FLOAT(trip_data.dropoff_latitude))) )) ),2) AS total_distance, --haversine formula.
    ROUND(SUM(FLOAT(trip_fare.total_amount)), 2) AS earnings,
    ROUND(SUM(FLOAT(trip_fare.tip_amount)), 2) AS tips,
    SUM(COUNT(*)) AS trips
  FROM [833682135931:nyctaxi.trip_data] AS trip_data
  JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
  ON trip_data.medallion = trip_fare.medallion
  AND trip_data.pickup_datetime = trip_fare.pickup_datetime
  GROUP EACH BY trip_data.medallion)
ORDER BY miles_per_dolla DESC
LIMIT 20


miles_per_dolla,total_distance,earnings,tips,trips,medallion
134.97,43062.99,319.05,2.0,48,08F04B9FDB246C105F9DADEB232C1C35
126.48,16148.83,127.68,3.02,24,28B646E3B0A34F8756AC60E2E7670F0D
100.45,1.137581447E7,113249.57,10130.52,7721,342381FAD34CA62E35CF71409DFEED43
95.0,80824.57,850.8,0.47,45,14B938A25E96E2928E3B167A038D17D5
94.31,16148.62,171.23,9.0,36,1CD95D7378F2999FE588A598A466ABC8
90.01,10765.77,119.6,0.0,12,AD8ABBDDFAF82EF07592BA9107B05D9F
78.47,269144.28,3430.07,327.5,429,4CE74C6E7448FF1D5BD4E54162508CF1
74.56,1.543145627E7,206974.76,19919.07,13387,DD9022A19340DE6C974072C5A6C8A732
68.57,5849870.86,85310.43,8145.66,6323,266CCA39BBE9D879BB5CF8DEA1B19871
62.11,22002.18,354.25,0.0,47,994D1CAD9132E48C993D58B492F71FC1
58.97,37360.54,633.5,127.0,156,220E43F9890CBB691F8348EA51B19F19
57.56,5385.09,93.55,6.25,2,0EE3FFCBDFD8B2979E87F38369A28FD9
54.88,3511595.83,63988.56,6608.52,2805,4EF7FFB140F99C849410B914939B4949
48.17,10765.79,223.5,0.0,51,3282D437BDE390612023C5237BE0FA6D
43.59,10765.78,246.99,0.0,8,7A0FB79952AD02B1AD496FB9BA9A61FB
42.89,1.006932368E7,234752.38,21797.37,16654,399DB6E048D813564DA0358503474A2C
41.69,2423260.9,58126.42,5635.17,3931,4CBBA37839940ADE243D1B4B2A4583C4
38.04,4154827.29,109226.34,10678.33,6884,C751E707D7D20AA0761EE82793EFC6BD
36.51,4699712.71,128717.79,12124.26,6795,D2D00AA857BA7917A99D1E1781A897D1
35.14,59212.35,1685.23,194.95,238,00C1977D0DFAA5D97557054EDF473017



-- Longest rides
-- note: the distance data is pretty messy it turns out, lots of zero values, truncated decimals
-- etc. that throw the distance calculation out of whack. sort by fare instead
----------------

SELECT
  ROUND(3959 * acos( cos(radians(FLOAT(trip_data.pickup_latitude)))*cos(radians(FLOAT(trip_data.dropoff_latitude)))*cos(radians(FLOAT(trip_data.dropoff_longitude))-radians(FLOAT(trip_data.pickup_longitude))) + sin(radians(FLOAT(trip_data.pickup_latitude)))*sin(radians(FLOAT(trip_data.dropoff_latitude))) ) ,2) AS distance, --haversine formula.
  trip_data.pickup_latitude AS pickup_latitude,
  trip_data.pickup_longitude AS pickup_longitude,
  trip_data.dropoff_latitude AS dropoff_latitude,
  trip_data.dropoff_longitude AS dropoff_longitude,
  trip_fare.total_amount AS total_fare,
  trip_fare.tip_amount AS tip,
  INTEGER((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100) AS tip_percent,
  trip_data.medallion AS medallion
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
ORDER BY total_fare DESC
LIMIT 100


-- looks like it's popular to hand over a thou or a hunny. the first guy must have done a loop

distance,pickup_latitude,pickup_longitude,dropoff_latitude,dropoff_longitude,total_fare,tip,tip_percent,medallion
0.0,40.811169,-73.930168,40.811165,-73.930153,999.99,0,0,0E1DBB68725F8E2F36BCF596C2719561
6.45,40.773533,-73.870659,40.732693,-73.981476,995.59,0,0,08B54C66963A4F5894CC4EDA638FD27F
0.0,40.784782,-73.951828,40.784782,-73.951836,995,0,0,81D63C85750AF2C4D125380942446905
0.47,40.80946,-73.93795,40.812065,-73.929642,99.99,0,0,1D53A0A8DBFD2F3382F764180633C1EF
17.86,40.749981,-73.991196,40.751194,-73.650047,99.99,16.66,16,69D3ACF9CEAD3386114387EF57BB02DF
1.26,40.768665,-73.892746,40.772736,-73.86937,99.99,0,0,1D53A0A8DBFD2F3382F764180633C1EF
0.0,41.377293,-73.961311,41.3773,-73.961281,99.99,0,0,8E7A10A881DEF75BE6BA7AFF896610FD
12.45,40.758072,-73.99295,40.813076,-74.219482,99.99,19.99,19,14D8F54D4F64DB9B8C4D79EBC2DA8218
0.0,-180,-180,-180,-180,99.99,0,0,A485E6CAA482169A2A3837DEC32AEBAB
13.72,40.702736,-74.012192,40.541527,-74.164764,99.99,28,28,3F38E295118F0BFFEF93ED81A5EFB47D
19.83,40.646698,-73.777184,40.928585,-73.848419,99.99,16.66,16,60091B1217A9E629BEA6AF080AAB9BCD
18.01,40.731499,-74.001038,40.801723,-73.669609,99.99,16.66,16,AE9E14F1EBFECEFF6ADFD437CA64F957
7.08,40.751312,-73.897438,40.781467,-74.026772,99.99,16.66,16,D2A54CCEA77527E69E6C65125CACD01D
0.0,40.95599,-74.090607,40.95599,-74.090607,99.99,0,0,22508C4A859E71B0813F497AC1C121B9
14.6,40.751839,-74.004364,40.594513,-74.190369,99.99,20,20,DD8B42664C68A4C8150C758FC6329C27
0.0,-180,-180,-180,-180,99.99,0,0,A485E6CAA482169A2A3837DEC32AEBAB
10.59,40.758919,-73.968468,40.632305,-74.08223,99.99,10,10,3E976497A2B2CCF52F65AF4445DC0C06
18.01,40.644379,-73.782486,40.897877,-73.862343,99.99,16.66,16,192B01C2388EEDC4DE83390968AC4B05
9.12,40.768761,-73.965942,40.651649,-73.885582,99.99,16.66,16,320555E0D5D0923D8459C3A40D51FE91
0.0,40.763649,-73.424728,40.763649,-73.424728,99.99,29.99,29,E54A6159E17B9398A80A2BFEB5D9ACDA
5394.56,40.687668,-74.182289,0,0,99.99,0,0,F8A8ABAC67BA08A9849A9441EEEFE57F
14.69,40.789658,-73.966225,40.619907,-74.135132,99.99,22,22,41616BA59DDF38D72D64035003F37121
0.04,40.77253,-73.950912,40.772251,-73.95018,99.99,0,0,1D53A0A8DBFD2F3382F764180633C1EF
0.0,40.71767,-73.67366,40.71767,-73.67366,99.99,0,0,CB2886AFC0534BF64EB96F3C57765BDE
10.26,40.698895,-73.98674,40.625103,-74.156708,99.99,0,0,AA6701594EFA199552E4EE0E2252DB98
17.63,40.64444,-73.782486,40.879074,-73.914818,99.99,16.66,16,A9FC1706D08811C2806A13C9BA9D98FA
10.01,40.718903,-73.988724,40.695045,-74.177155,99.99,11.49,11,237F49C3ECC11F5024B254268F054384
6.93,40.721233,-73.983414,40.812817,-73.929649,99.99,0,0,8837AEAF2F76C2DD5BDB3CAF682D3896
18.7,40.649616,-73.804207,40.918228,-73.848007,99.99,16.66,16,8AADE866F4F6808B5F06E47492820DBF
11.47,40.647568,-73.78138,40.72414,-73.587189,99.99,19.99,19,915D5155B2A1977B71EBA5029DB58B11
9.19,40.748421,-73.986938,40.733349,-74.16127,99.99,16.66,16,B38262AB7D12F6B7CE35A0456889097B
21.53,40.756226,-73.970482,40.516617,-74.233025,99.99,0,0,20176D06D17A5E121714ED437FA9F6F0
2.99,40.773613,-73.955597,40.812008,-73.929382,99.99,0,0,979F1186E65F700F51DE78ADF2647620
7.08,40.751312,-73.897438,40.781467,-74.026772,99.99,16.66,16,D2A54CCEA77527E69E6C65125CACD01D
12.7,40.755684,-73.973564,40.638763,-73.786545,99.99,16.66,16,722D8583ED699F4B615603CE8C3A8366
19.83,40.646698,-73.777184,40.928585,-73.848419,99.99,16.66,16,60091B1217A9E629BEA6AF080AAB9BCD
14.82,40.754883,-73.995369,40.956573,-74.091606,99.99,18.99,18,14D8F54D4F64DB9B8C4D79EBC2DA8218
0.0,-180,-180,-180,-180,99.99,0,0,A485E6CAA482169A2A3837DEC32AEBAB
0.71,40.665527,-73.802315,40.662804,-73.78933,99.99,16.66,16,95B0E8E13FF920DC35841D766241FDEE
15.66,40.770424,-73.864838,40.968445,-73.719162,99.99,16.66,16,30109A4DDF2625999908DC64EB2A768D
7.25,40.774036,-73.873383,40.713699,-73.986687,99.99,16.66,16,F8BCBAB01C70F4ACA1FA506EC8F1D0E1
5385.62,40.760986,-73.9907,0,0,99.99,0,0,EDD8D48B8507A547A4F44691C4E14AD7
11.78,40.761387,-73.974709,40.689434,-74.178581,99.99,9.3,9,21FC58AFBC8598230242F146B81D65A7
0.0,40.980625,-73.709892,40.98064,-73.709923,99.99,9.99,9,8FCED8833E91F75673B4B4B4A7D720AB



-- Tips
-------

SELECT 
  INTEGER(ROUND(FLOAT(tip_amount) / FLOAT(fare_amount) * 100)) tip_pct,
  count(*) trips
FROM [833682135931:nyctaxi.trip_fare] 
WHERE payment_type='CRD' and float(fare_amount) > 0.00
GROUP BY tip_pct
ORDER BY tip_pct 


-- Tips grouped by geo blocks
-----------------------------

SELECT
  CONCAT(STRING(ROUND(FLOAT(trip_data.pickup_latitude), 4)), ',', STRING(ROUND(FLOAT(trip_data.pickup_longitude), 4))) AS geobox,
  ROUND(AVG(FLOAT(trip_data.pickup_latitude)), 4) as lat,
  ROUND(AVG(FLOAT(trip_data.pickup_longitude)), 4) as lon,
  COUNT(*) AS trips,
  ROUND(AVG(trip_fare.total_amount), 2) AS avg_fare,
  ROUND(AVG(trip_fare.tip_amount), 2) AS avg_tip,
  INTEGER(AVG((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100)) AS avg_tip_percent
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
WHERE FLOAT(trip_data.pickup_longitude) != 0 AND FLOAT(trip_data.pickup_latitude) != 0
GROUP EACH BY geobox
ORDER BY trips DESC


-- Most ridiculous tips
-----------------------

SELECT 
  tip_pct, 
  hack_license,
  pickup_datetime,
  fare_amount,
  payment_type,
  tip_amount
FROM 
  (SELECT
    hack_license,
    INTEGER(ROUND(FLOAT(tip_amount) / FLOAT(fare_amount) * 100)) AS tip_pct,
    pickup_datetime,
    fare_amount,
    payment_type,
    tip_amount
  FROM
    [833682135931:nyctaxi.trip_fare]
  WHERE 
    float(fare_amount) > 50.00)
WHERE hack_license != "CFCD208495D565EF66E7DFF9F98764DA"
ORDER BY 1 DESC
LIMIT 10



-- Laziest neighborhoods
------------------------

SELECT
  CONCAT(STRING(ROUND(FLOAT(trip_data.pickup_latitude), 3)), '|', STRING(ROUND(FLOAT(trip_data.pickup_longitude), 3))) AS geobox,
  ROUND(AVG(FLOAT(trip_data.pickup_latitude)), 3) as lat,
  ROUND(AVG(FLOAT(trip_data.pickup_longitude)), 3) as lon,
  COUNT(*) AS trips,
  ROUND(AVG(3959 * acos( cos(radians(FLOAT(trip_data.pickup_latitude)))*cos(radians(FLOAT(trip_data.dropoff_latitude)))*cos(radians(FLOAT(trip_data.dropoff_longitude))-radians(FLOAT(trip_data.pickup_longitude))) + sin(radians(FLOAT(trip_data.pickup_latitude)))*sin(radians(FLOAT(trip_data.dropoff_latitude))) ) ,2)) AS distance, --haversine formula.
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
WHERE FLOAT(trip_data.pickup_longitude) != 0 AND FLOAT(trip_data.pickup_latitude) != 0
GROUP EACH BY geobox
ORDER BY trips DESC


-- Pickup density
-----------------

SELECT
  CONCAT(STRING(ROUND(FLOAT(trip_data.pickup_latitude), 4)), ',', STRING(ROUND(FLOAT(trip_data.pickup_longitude), 4))) AS geobox,
  ROUND(AVG(FLOAT(trip_data.pickup_latitude)), 4) as lat,
  ROUND(AVG(FLOAT(trip_data.pickup_longitude)), 4) as lon,
  COUNT(*) AS trips,
  ROUND(AVG(trip_fare.total_amount), 2) AS avg_fare,
  ROUND(AVG(trip_fare.tip_amount), 2) AS avg_tip,
  INTEGER(AVG((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100)) AS avg_tip_percent
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
WHERE FLOAT(trip_data.pickup_longitude) != 0 AND FLOAT(trip_data.pickup_latitude) != 0
GROUP EACH BY geobox
ORDER BY trips DESC



-- Dropoff density
------------------

SELECT
  CONCAT(STRING(ROUND(FLOAT(trip_data.dropoff_latitude), 3)), '|', STRING(ROUND(FLOAT(trip_data.dropoff_longitude), 3))) AS geobox,
  ROUND(AVG(FLOAT(trip_data.dropoff_latitude)), 3) as lat,
  ROUND(AVG(FLOAT(trip_data.dropoff_longitude)), 3) as lon,
  COUNT(*) AS trips,
  ROUND(AVG(trip_fare.total_amount), 2) AS avg_fare,
  ROUND(AVG(trip_fare.tip_amount), 2) AS avg_tip,
  INTEGER(AVG((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100)) AS avg_tip_percent
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
WHERE FLOAT(trip_data.pickup_longitude) != 0 AND FLOAT(trip_data.pickup_latitude) != 0
GROUP EACH BY geobox
ORDER BY trips DESC


-- Some aggregate stats
-----------------------

SELECT
  COUNT(*) AS trips,
  ROUND(AVG(trip_fare.total_amount), 2) AS avg_fare,
  ROUND(AVG(trip_fare.tip_amount), 2) AS avg_tip,
  INTEGER(AVG((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100)) AS avg_tip_percent
FROM
 [833682135931:nyctaxi.trip_fare] AS trip_fare




-- Total trips: 187287452
-- Trips with 0 tip: 89099496

-- Total CRD trips: 101089735
-- Total CRD trips with 0 tip: 3133890



-- Most common trips
--------------------

SELECT
  CONCAT(STRING(ROUND(FLOAT(trip_data.pickup_latitude), 3)), '|', STRING(ROUND(FLOAT(trip_data.pickup_longitude), 3)), '|', CONCAT(STRING(ROUND(FLOAT(trip_data.dropoff_latitude), 3)), '|', STRING(ROUND(FLOAT(trip_data.dropoff_longitude), 3)))) AS trip_string,
  COUNT(*) AS trips,
  ROUND(AVG(trip_fare.total_amount), 2) AS avg_fare,
  ROUND(AVG(trip_fare.tip_amount), 2) AS avg_tip,
  INTEGER(AVG((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100)) AS avg_tip_percent
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
WHERE FLOAT(trip_data.pickup_longitude) != 0 AND FLOAT(trip_data.pickup_latitude) != 0
GROUP EACH BY trip_string
ORDER BY trips DESC
LIMIT 20


-- Largest fares
----------------

SELECT
  ROUND(3959 * acos( cos(radians(FLOAT(trip_data.pickup_latitude)))*cos(radians(FLOAT(trip_data.dropoff_latitude)))*cos(radians(FLOAT(trip_data.dropoff_longitude))-radians(FLOAT(trip_data.pickup_longitude))) + sin(radians(FLOAT(trip_data.pickup_latitude)))*sin(radians(FLOAT(trip_data.dropoff_latitude))) ) ,2) AS distance, --haversine formula.
  trip_data.pickup_datetime,
  trip_data.dropoff_datetime,
  trip_data.trip_time_in_secs,
  trip_data.pickup_latitude AS pickup_latitude,
  trip_data.pickup_longitude AS pickup_longitude,
  trip_data.dropoff_latitude AS dropoff_latitude,
  trip_data.dropoff_longitude AS dropoff_longitude,
  trip_fare.payment_type AS payment_type,
  trip_fare.total_amount AS total_fare,
  trip_fare.tip_amount AS tip,
  INTEGER((FLOAT(trip_fare.tip_amount) / FLOAT(trip_fare.total_amount))*100) AS tip_percent,
  trip_data.medallion AS medallion
FROM
 [833682135931:nyctaxi.trip_data] AS trip_data
JOIN EACH [833682135931:nyctaxi.trip_fare] AS trip_fare
ON trip_data.medallion = trip_fare.medallion AND trip_data.pickup_datetime = trip_fare.pickup_datetime
ORDER BY total_fare DESC
LIMIT 100


