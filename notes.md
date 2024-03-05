## due friday at 5:00pm!

### cmos.l

* tokenizes only one file at a time, doesn't have to compare anything or read in multiple files
* puts all tokens on one line in scanner.txt

### cmos.cpp

* reads in the tokenized versions of all submissions where tokens.txt is all tokens of all files (which the bash script does)

### winnowing algorithm

* read in all tokens from all submissions (2d vector?)
* for each file:
    * remove spaces from tokens
    * build k-mers of our length k ( smaller than 50 works, kevin used 10, with 3 digit long tokens, w size 21(?) or maybe he said 21 windows i do not remember)
        * adjust for our token length of 2 or change token length to 3?
* for each pair of submissions:
    * count the # of shared fingerprints
    * score is shared fingerprints / # of fingerprints
    * order pairs by scores

* don't need to worry about location of fingerprint in the file
* when hashing k-mers, might overflow max int, perhaps use long longs or smaller hash nos.
* kevin is using multimaps using fingerprint and name of file (could also use a map and count one per submission)
* can change the bash script if we need to 
