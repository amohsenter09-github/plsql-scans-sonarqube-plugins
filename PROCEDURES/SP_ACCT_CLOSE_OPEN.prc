CREATE OR REPLACE PROCEDURE VMSCMS.SP_ACCT_CLOSE_OPEN wrapped 
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
7
9000000
1
4
0 
33
2 :e:
1SP_ACCT_CLOSE_OPEN:
1ERRMSG:
1OUT:
1VARCHAR2:
1CURSOR:
1C1:
1ACCT_NO:
1ROWID:
1TEMP_ACCT_OPEN:
1INVALID_ACCOUNT:
1V_CAM_ACCT_ID:
1CMS_ACCT_MAST:
1CAM_ACCT_ID:
1TYPE:
1V_CPA_ACCT_ID_CNT:
1NUMBER:
120:
1V_CAP_ACCT_NO:
1CMS_APPL_PAN:
1CAP_ACCT_NO:
1V_CPA_PAN_CODE:
1CMS_PAN_ACCT:
1CPA_PAN_CODE:
1V_CPA_ACCT_POSN:
1CPA_ACCT_POSN:
1OK:
1X:
1LOOP:
1CAM_INST_CODE:
1=:
11:
1CAM_ACCT_NO:
1NO_DATA_FOUND:
1ACCOUNT NO:: :
1||:
1 NOT FOUND IN ACCOUNT MASTERS:
1RAISE:
1OTHERS:
1ACCOUNT CHK:::
1SQLERRM:
1CAM_STAT_CODE:
1CMS_CUST_ACCT:
1CCA_REL_STAT:
1Y:
1CCA_ACCT_ID:
1PROCESS_FLAG:
1O:
1PROC_DESC:
1COMPLETED:
1E:
1ERR:::
0
0
0
13a
2
0 9a 96 :2 a0 b0 54 b4 55
6a a0 f4 b4 bf c8 :2 a0 ac
a0 b2 ee ac d0 e5 e9 bd
b7 11 a4 b1 8b b0 2a a3
:2 a0 6b :2 a0 f 1c 81 b0 a3
a0 51 a5 1c 81 b0 a3 :2 a0
6b :2 a0 f 1c 81 b0 a3 :2 a0
6b :2 a0 f 1c 81 b0 a3 :2 a0
6b :2 a0 f 1c 81 b0 a0 6e
d 91 :2 a0 37 a0 ac :2 a0 b2
ee a0 7e 51 b4 2e :2 a0 7e
a0 6b b4 2e a 10 ac e5
d0 b2 e9 b7 :2 a0 6e 7e :2 a0
6b b4 2e 7e 6e b4 2e d
:2 a0 62 b7 a6 9 a0 53 a0
6e 7e a0 b4 2e d :2 a0 62
b7 a6 9 a4 b1 11 4f :2 a0
51 e7 a0 7e 51 b4 2e :2 a0
7e a0 6b b4 2e a 10 ef
f9 e9 :2 a0 6e e7 :2 a0 7e b4
2e ef f9 e9 :2 a0 6e e7 a0
6e e7 :2 a0 7e a0 6b b4 2e
:2 a0 7e a0 6b b4 2e a 10
ef f9 e9 b7 :3 a0 6e e7 :2 a0
e7 :2 a0 7e a0 6b b4 2e :2 a0
7e a0 6b b4 2e a 10 ef
f9 e9 a0 6e d b7 a6 9
a0 53 a0 6e 7e a0 b4 2e
d :2 a0 6e e7 :2 a0 e7 :2 a0 7e
a0 6b b4 2e :2 a0 7e a0 6b
b4 2e a 10 ef f9 e9 a0
6e d b7 a6 9 a4 b1 11
4f b7 a0 47 b7 a0 53 a0
6e 7e a0 b4 2e d b7 a6
9 a4 b1 11 68 4f 1d 17
b5 
13a
2
0 3 23 1b 1f 1a 2a 17
2f 33 37 3b 4c 4d 50 54
58 5c 5d 61 62 69 6a 6e
74 79 7e 80 8c 90 92 99
9a c6 a1 a5 a9 ac b0 b4
b9 c1 a0 e3 d1 9d d5 d6
de d0 110 ee f2 cd f6 fa
fe 103 10b ed 13d 11b 11f ea
123 127 12b 130 138 11a 16a 148
14c 117 150 154 158 15d 165 147
171 175 17a 17e 182 186 144 18a
18e 18f 193 197 198 19f 1a3 1a6
1a9 1aa 1af 1b3 1b7 1ba 1be 1c1
1c2 1 1c7 1cc 1cd 1d3 1d7 1d8
1dd 1df 1e3 1e7 1ec 1ef 1f3 1f7
1fa 1fb 200 203 208 209 20e 212
216 21a 21d 21f 220 225 1 229
22d 232 235 239 23a 23f 243 247
24b 24e 250 251 256 25a 25c 268
26a 26e 272 275 277 27b 27e 281
282 287 28b 28f 292 296 299 29a
1 29f 2a4 2aa 2ab 2b0 2b4 2b8
2bd 2bf 2c3 2c7 2ca 2cb 2d0 2d6
2d7 2dc 2e0 2e4 2e9 2eb 2ef 2f4
2f6 2fa 2fe 301 305 308 309 30e
312 316 319 31d 320 321 1 326
32b 331 332 337 339 33d 341 345
34a 34c 350 354 356 35a 35e 361
365 368 369 36e 372 376 379 37d
380 381 1 386 38b 391 392 397
39b 3a0 3a4 3a6 3a7 3ac 1 3b0
3b4 3b9 3bc 3c0 3c1 3c6 3ca 3ce
3d2 3d7 3d9 3dd 3e1 3e3 3e7 3eb
3ee 3f2 3f5 3f6 3fb 3ff 403 406
40a 40d 40e 1 413 418 41e 41f
424 428 42d 431 433 434 439 43d
43f 44b 44d 44f 453 45a 45c 1
460 464 469 46c 470 471 476 47a
47c 47d 482 486 488 494 498 49a
49b 4a4 
13a
2
0 b 1e 25 29 :2 1e 1d :3 1
8 0 :2 1 8 11 8 :10 1 f
1d f :2 29 :3 f :2 1 13 1a 19
:2 13 :2 1 f 1c f :2 28 :3 f :2 1
10 1d 10 :2 2a :3 10 :2 1 11 1e
11 :2 2c :3 11 1 2 c 2 7
c :2 3 :2 c a :4 5 13 15 :2 13
5 13 11 :2 15 :2 11 :8 5 9 5
f 1d 1f :2 21 :2 f 28 2a :2 f
:2 5 b 5 17 :2 4 :2 9 5 f
1d 1f :2 f :2 5 b 5 10 :3 4
:3 3 c 9 19 9 5 13 15
:2 13 5 13 11 :2 15 :2 11 :5 5 c
9 17 9 b 19 :3 17 :3 5 c
6 15 :2 6 12 :2 6 10 e :2 12
:2 e 6 e c :2 10 :2 c :2 6 :3 5
3 b d 4 13 :2 4 10 :2 4
e c :2 10 :2 c 4 c a :2 e
:2 a :2 4 :3 6 4 e 4 1b :2 6
:2 b 4 e 14 16 :2 e 4 b
4 13 :2 4 10 :2 4 e c :2 10
:2 c 4 c a :2 e :2 a :6 4 e
4 12 :3 6 :4 3 7 3 2 :2 7
2 c 12 14 :2 c 2 e :3 2
:7 1 
13a
4
0 :9 1 :2 4 0
:2 4 :3 6 8 7
8 7 :3 6 :5 4
:3 a :a c :7 d :a e
:a f :a 10 :3 13 :2 14
15 14 :2 18 19
1b 1a 1b :5 1d
:7 1e :2 1d 1a :4 18
17 20 :d 21 :3 22
:3 20 :2 23 :7 24 :3 25
:3 23 1f :3 16 29
:3 2a :5 2c :7 2d :2 2c
:3 29 30 :3 31 :5 32
:3 30 34 :3 36 :3 37
:7 39 :7 3b :2 39 :3 34
16 3f 40 :3 42
:3 43 :7 45 :7 47 :2 45
:3 40 :3 48 :3 3f :2 49
:7 4a 4b :3 4d :3 4e
:7 50 :7 52 :2 50 :3 4b
:3 53 :3 49 3e :4 15
55 14 12 :2 57
:7 58 :3 57 6
 :7 1
4a6
4
:3 0 1 :a 0 135
1 :7 0 5 :2 0
:2 3 :3 0 4 :3 0
2 :6 0 5 4
:3 0 7 :2 0 135
1 8 :2 0 5
:3 0 6 :a 0 2
19 :5 0 b e
0 c :3 0 7
:3 0 8 :3 0 7
9 :3 0 a 13
:2 0 15 :5 0 11
14 0 16 :6 0
17 :2 0 1a b
e 1b 0 133
c 1b 1d 1a
1c :6 0 19 :7 0
1b a :6 0 e
1f 0 133 11
:2 0 10 c :3 0
d :2 0 4 22
23 0 e :3 0
e :2 0 1 24
26 :3 0 27 :7 0
2a 28 0 133
0 b :6 0 33
34 0 14 10
:3 0 12 2c 2e
:6 0 31 2f 0
133 0 f :6 0
3d 3e 0 16
13 :3 0 14 :2 0
4 e :3 0 e
:2 0 1 35 37
:3 0 38 :7 0 3b
39 0 133 0
12 :6 0 47 48
0 18 16 :3 0
17 :2 0 4 e
:3 0 e :2 0 1
3f 41 :3 0 42
:7 0 45 43 0
133 0 15 :6 0
53 54 0 1a
16 :3 0 19 :2 0
4 e :3 0 e
:2 0 1 49 4b
:3 0 4c :7 0 4f
4d 0 133 0
18 :6 0 2 :3 0
1a :4 0 50 51
0 125 1b :3 0
6 :3 0 1c :3 0
d :3 0 1c b
:3 0 c :3 0 1e
5b 6a 0 6b
:3 0 1d :3 0 1e
:2 0 1f :2 0 22
5e 60 :3 0 20
:3 0 1b :3 0 1e
:2 0 7 :3 0 63
65 0 27 64
67 :3 0 61 69
68 :3 0 6d 6e
:5 0 58 5c 0
2a 0 6c :2 0
70 2c 96 21
:3 0 2 :3 0 22
:4 0 23 :2 0 1b
:3 0 7 :3 0 75
76 0 2e 74
78 :3 0 23 :2 0
24 :4 0 31 7a
7c :3 0 72 7d
0 82 25 :3 0
a :3 0 80 0
82 34 84 37
83 82 :2 0 94
26 :3 0 2 :3 0
27 :4 0 23 :2 0
28 :3 0 39 89
8b :3 0 87 8c
0 91 25 :3 0
a :3 0 8f 0
91 3c 93 3f
92 91 :2 0 94
41 :2 0 96 0
96 95 70 94
:6 0 d3 4 :3 0
c :3 0 29 :3 0
1f :2 0 99 9a
1d :3 0 1e :2 0
1f :2 0 46 9d
9f :3 0 20 :3 0
1b :3 0 1e :2 0
7 :3 0 a2 a4
0 4b a3 a6
:3 0 a0 a8 a7
:2 0 98 ab a9
0 ac 0 4e
0 aa :2 0 d3
2a :3 0 2b :3 0
2c :4 0 ae af
2d :3 0 b :3 0
1e :2 0 52 b3
b4 :3 0 ad b7
b5 0 b8 0
55 0 b6 :2 0
d3 9 :3 0 2e
:3 0 2f :4 0 ba
bb 30 :3 0 31
:4 0 bd be 7
:3 0 1b :3 0 1e
:2 0 7 :3 0 c1
c3 0 59 c2
c5 :3 0 8 :3 0
1b :3 0 1e :2 0
8 :3 0 c8 ca
0 5e c9 cc
:3 0 c6 ce cd
:2 0 b9 d1 cf
0 d2 0 61
0 d0 :2 0 d3
64 120 a :3 0
9 :3 0 2e :3 0
32 :4 0 d6 d7
30 :3 0 2 :3 0
d9 da 7 :3 0
1b :3 0 1e :2 0
7 :3 0 dd df
0 6b de e1
:3 0 8 :3 0 1b
:3 0 1e :2 0 8
:3 0 e4 e6 0
70 e5 e8 :3 0
e2 ea e9 :2 0
d5 ed eb 0
ee 0 73 0
ec :2 0 f2 2
:3 0 1a :4 0 ef
f0 0 f2 76
f4 79 f3 f2
:2 0 11e 26 :3 0
2 :3 0 33 :4 0
23 :2 0 28 :3 0
7b f9 fb :3 0
f7 fc 0 11b
9 :3 0 2e :3 0
32 :4 0 ff 100
30 :3 0 2 :3 0
102 103 7 :3 0
1b :3 0 1e :2 0
7 :3 0 106 108
0 80 107 10a
:3 0 8 :3 0 1b
:3 0 1e :2 0 8
:3 0 10d 10f 0
85 10e 111 :3 0
10b 113 112 :2 0
fe 116 114 0
117 0 88 0
115 :2 0 11b 2
:3 0 1a :4 0 118
119 0 11b 8b
11d 8f 11c 11b
:2 0 11e 91 :2 0
120 0 120 11f
d3 11e :6 0 122
3 :3 0 94 124
1c :3 0 56 122
:4 0 125 96 134
26 :3 0 2 :3 0
33 :4 0 23 :2 0
28 :3 0 99 12a
12c :3 0 128 12d
0 12f 9c 131
9e 130 12f :2 0
132 a0 :2 0 134
a2 134 133 125
132 :6 0 135 :2 0
1 8 134 138
:3 0 137 135 139
:8 0 
aa
4
:3 0 1 2 1
6 2 f 10
1 12 1 18
1 1e 1 21
1 2d 1 2b
1 32 1 3c
1 46 1 57
1 5a 1 5f
2 5d 5f 1
66 2 62 66
1 59 1 6f
2 73 77 2
79 7b 2 7e
81 1 71 2
88 8a 2 8d
90 1 86 2
84 93 1 9e
2 9c 9e 1
a5 2 a1 a5
1 9b 1 b2
2 b1 b2 1
b0 1 c4 2
c0 c4 1 cb
2 c7 cb 2
bc bf 4 96
ac b8 d2 1
e0 2 dc e0
1 e7 2 e3
e7 2 d8 db
2 ee f1 1
d4 2 f8 fa
1 109 2 105
109 1 110 2
10c 110 2 101
104 3 fd 117
11a 1 f6 2
f4 11d 1 120
2 52 124 2
129 12b 1 12e
1 127 1 131
7 19 20 29
30 3a 44 4e
1
4
0 
138
0
1
14
5
a
0 1 1 3 4 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 
32 1 0
21 1 0
2 1 0
1e 1 0
3c 1 0
46 1 0
1 0 1
b 1 2
2b 1 0
53 3 0
0
/


