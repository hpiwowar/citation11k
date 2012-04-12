# Based on initial Nosy by Jeff Winkler, http://jeffwinkler.net

import glob
import os
import stat
import time 
import sys

command1 = """R -e "library(knitr); knit('statsmall_knit_.md')" """
command2 = """pandoc -r markdown -w html --include-in-header header.html statsmall.md > statsmall.html"""

'''
Watch for changes in all relevant files, in all subdirectories. 
If changes, run stuff.
Based on nosy
'''

def checkSumRecurse():
    ''' Return a long which can be used to know if any relevant files have changed.
    Looks in subdirectories.
    Contributed to nosy by Kevin Dahlhausen'''
    val = 0
    for dirpath, dirs, files in os.walk("."):
        for file in [file for file in files if "_knit_.md" in file[-9:]]:
            absoluteFileName = os.path.join( dirpath, file)
            stats = os.stat(absoluteFileName)
            val += stats[stat.ST_SIZE] + stats[stat.ST_MTIME]
        for file in [file for file in files if ".R" in file[-2:]]:
            absoluteFileName = os.path.join( dirpath, file)
            stats = os.stat(absoluteFileName)
            val += stats[stat.ST_SIZE] + stats[stat.ST_MTIME]
    return val

def main(argv=None):
    val=0
    check = checkSumRecurse
    while (True):
        if check() != val:
            val = check()
            print "*************************"
            print time.ctime()
            os.system(command1) 
            os.system(command2)             
        time.sleep(1)

if __name__ == "__main__":
    main(sys.argv[1:])
