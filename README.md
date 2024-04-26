# sample_file
## Sample text file query and processing

### sample.txt (structure)
![sample.png](https://github.com/hani86400/sample_file/blob/main/sample.png)

### sample.txt (Remarks)
```
File have 19 lines.
Lines 1 and 3 are empty lines.
LF is line feed ( ascii code 10 ) which represent end of line in linux systems.
```

### sample.txt (raw)
```

Yearly Report

  Month/Items   laptop   pc    tablet   total  
 ------------- -------- ----- -------- ------- 
  January           33    13       96     142  
  February          30    15       40      85  
  March             44    27       76     147  
  April             65    22       80     167  
  May                5    32       89     126  
  June              91    29       20     140  
  July              94    35       56     185  
  August            26    30       77     133  
  September         39    25       65     129  
  October           79     8       47     134  
  November          17    14       85     116  
  December          50    28       29     107  
 ------------- -------- ----- -------- ------- 
  Total            573   278      760    1611  
```


### statistical  information and meta data
```
# Number of lines:
wc -l sample.txt # output: 19 sample.txt

# Number of chars:
wc -c sample.txt # output: 784 sample.txt


# inode permeation  owner group size last update
ls -il sample.txt

#File type
file sample.txt # output: sample.txt: ASCII text

#File state
stat sample.txt
#output
  File: sample.txt
  Size: 784       	Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d	Inode: 3674809     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/    abc)   Gid: ( 1000/    abc)
Access: 2024-04-25 06:41:52.629682828 +0100
Modify: 2024-04-25 06:41:44.453129679 +0100
Change: 2024-04-25 06:41:44.453129679 +0100
 Birth: 2024-04-25 06:41:44.449129407 +0100

```
### Get Q2 data from the file
```
  April             65    22       80     167  
  May                5    32       89     126  
  June              91    29       20     140  
```

#### Get Q2 (by line number 9-11)
```
# using head / tail
cat sample.txt | head -n +11 | tail -n +9
#or
cat sample.txt | head -n +11 | tail -n -3

# using sed:
sed -n '9,11 p' sample.txt
#or
sed '9,11!d' sample.txt

# using awk:
awk 'NR==9, NR==11' sample.txt
#or
awk 'FNR >= 9 && FNR <= 11' sample.txt

# using perl
perl -ne 'print if 9..11' sample.txt
```

#### Get Q2 (by pattern(s) April May June )
```
# using grep
grep 'April\|May\|June' sample.txt
#or short
grep 'Ap\|May\|Jun' sample.txt 
#or -E extended-regexp
grep -E 'April|May|June' sample.txt


# using sed
sed '/Apr\|May\|June/!d' sample.txt
#or
sed -E '/Apr|May|June/!d' sample.txt

# using awk
```

#### Get Q2 (mix pattern and lines around the pattern
```
# using grep
grep 'April' -A 2 sample.txt
#or
grep 'May' -A 1 -B 1 sample.txt
#or
grep 'June' -B 2 sample.txt
```



### Process file line by line
#### By shell (sample.sh)
```
#!/bin/bash

T_FILE_NAME='sample.txt'
T_LINE_MAX=7
T_LINE_COUNTER=0
while IFS= read -r T_1LINE || [ -n "$T_LINE" ]  &&  [ "$T_LINE_COUNTER" -lt "$T_LINE_MAX" ]
do
T_LINE_COUNTER=$((  T_LINE_COUNTER +  1 )) 
echo "LINE_NO=${T_LINE_COUNTER}= LINE_CONTENT=${T_1LINE}="
done < "${T_FILE_NAME}"
```
Run:
```
chmod +x sample.sh 
./sample.sh 
```
output:
```
LINE_NO=1= LINE_CONTENT==
LINE_NO=2= LINE_CONTENT=Yearly Report=
LINE_NO=3= LINE_CONTENT==
LINE_NO=4= LINE_CONTENT=  Month/Items   laptop   pc    tablet   total  =
LINE_NO=5= LINE_CONTENT= ------------- -------- ----- -------- ------- =
LINE_NO=6= LINE_CONTENT=  January           33    13       96     142  =
LINE_NO=7= LINE_CONTENT=  February          30    15       40      85  =
```
#### By AWK (sample.awk)
```
####################################################################
# File: [sample.awk]                                    2024_04_25 # format
#                                                                  # 
# awk -f sample.awk ${INPUT_FILE}                                  # 
####################################################################

# + =========================================================== +
# | AWK (PRE) Initilization                                     |
# + =========================================================== +
#FIELDWIDTHS=
#RS=
#FS=
#OFS=
#ORS=
#
#
#ARGC=
#ARGV=
#ENVIRON["HOME"]     Array of the shell environment variables and corresponding values.
#FILENAME
#NF     
#NR    
#FNR   
#IGNORECASE
# + =========================================================== +

# + =========================================================== +
BEGIN { # AWK (PRE  PROCESSING)                                 |
# + =========================================================== +
T_LINE_MAX=7
myvar="hani"	
FS="="
print "from BEGIN"
} # =========================================================== + 


# + =========================================================== +
{       # AWK (     PROCESSING)                                 |
# + =========================================================== +
if ( NR <= T_LINE_MAX ) 
{ # if
print "LINE_NO=",NR,"= LINE_CONTENT=",$0"="
} # if
} # =========================================================== + 



# + =========================================================== +
END   { # AWK (POST PROCESSING)                                 |
# + =========================================================== +
print "from END"
} # =========================================================== + 


```

Run:
```
TEXT_FILE='sample.txt'
AWK_FILE='sample.awk'
awk -f "${AWK_FILE}" "${TEXT_FILE}"
```

output:
```
from BEGIN
LINE_NO= 1 = LINE_CONTENT= =
LINE_NO= 2 = LINE_CONTENT= Yearly Report=
LINE_NO= 3 = LINE_CONTENT= =
LINE_NO= 4 = LINE_CONTENT=   Month/Items   laptop   pc    tablet   total  =
LINE_NO= 5 = LINE_CONTENT=  ------------- -------- ----- -------- ------- =
LINE_NO= 6 = LINE_CONTENT=   January           33    13       96     142  =
LINE_NO= 7 = LINE_CONTENT=   February          30    15       40      85  =
from END

```

