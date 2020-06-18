## HANDY ONE-LINERS FOR SED (Unix stream editor)
More recent college graduates typically don't learn about the old-school unix tools like **sed** and **awk**, but should as they are extremely  useful!
My personal favorite which I use all the time to comment out all lines begigning with "foo"
```
 sed -e '/^foo/s/^\(.*\)/#\1/' __filename__  > __newfile__
```

Many examples pulled from http://sed.sourceforge.net/sed1line.txt

### FILE SPACING:
To keep changes in a new file, obviously we need to add **> __newfile__** to everything below

##### double space a file
```
sed G __filename__
```

#### If file already has some blank lines in it and we only want to add blank line when it doesn't exist
```
 sed '/^$/d;G' __filename__
```

#### triple space a file?  Do you ever need to do that?
```
 sed 'G;G' __filename__
```

#### Undo double-spacing
```
 sed 'n;d' __filename__
```

#### Insert new blank line above every line which matches "regex"
```
 sed '/regex/{x;p;x;}' __filename__
```

#### Insert new blank line below every line which matches "regex"
```
 sed '/regex/G' __filename__
```

#### Insert new blank lines above and below every line which matches "regex"
```
 sed '/regex/{x;p;x;G;}' __filename__
```

### NUMBERING:

#### Number each line of a file. Using a tab instead of space will preserve margins.
```
 sed = __filename__ | sed 'N;s/\n/\t/'
```

#### Number each line of file for non-blank lines
```
 sed '/./=' __filename__ | sed '/./N; s/\n/ /'
```

### TEXT CONVERSION AND SUBSTITUTION:

(leaving out \_\_filename\_\_ arg for the remainder of these)

#### convert DOS newlines (CR/LF) to Unix format
```
 sed 's/.$//'               # assumes that all lines end with CR/LF
 sed 's/^M$//'              # in bash/tcsh, press Ctrl-V then Ctrl-M
 sed 's/\x0D$//'            # gsed 3.02.80, but top script is easier
```

### convert Unix newlines (LF) to DOS format
```
 sed "s/$/`echo -e \\\r`/"            # command line under ksh
 sed 's/$'"/`echo \\\r`/"             # command line under bash
 sed "s/$/`echo \\\r`/"               # command line under zsh
 sed 's/$/\r/'                        # gsed 3.02.80
```

### Delete leading whitespace (spaces, tabs) from start of lines
```
 sed 's/^[ \t]*//'
```

### Delete trailing whitespace (spaces, tabs) from end of each line
```
 sed 's/[ \t]*$//'
```

### Delete leading and trailing whitespace from each line
```
 sed 's/^[ \t]*//;s/[ \t]*$//'
```

#### insert 5 blank spaces at beginning of each line
```
 sed 's/^/     /'
```

#### substitute (find and replace) "foo" with "bar" on each line
```
 sed 's/foo/bar/'             # replaces only 1st instance in a line
 sed 's/foo/bar/4'            # replaces only 4th instance in a line
 sed 's/foo/bar/g'            # replaces ALL instances in a line
 sed 's/\(.*\)foo\(.*foo\)/\1bar\2/' # replace the next-to-last case
 sed 's/\(.*\)foo/\1bar/'            # replace only the last case
```

#### substitute "foo" with "bar" ONLY for lines which contain "baz"
```
 sed '/baz/s/foo/bar/g'
```

#### substitute "foo" with "bar" EXCEPT for lines which contain "baz"
```
 sed '/baz/!s/foo/bar/g'
```

#### Comment out all lines beggining with "foo"
```
 sed -e '/^foo/s/^\(.*\)/#\1/' __filename__
```

#### change "green", "blue" or "purple" to "red"
```
 sed 's/green/red/g;s/blue/red/g;s/purple/red/g'
```

#### add a blank line every 5 lines
```
 gsed '0~5G'                  # GNU sed only
 sed 'n;n;n;n;G;'             # other seds
````

### SELECTIVE OF CERTAIN LINES:

#### print the line immediately before a regexp, but not the line containing the regexp
```
 sed -n '/regexp/{g;1!p;};h'
```

#### print the line immediately after a regexp, but not the line containing the regexp
```
 sed -n '/regexp/{n;p;}'
```

#### print 1 line of context before and after regexp, with line number of the regexp
```
 sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h
```

#### print only lines of 65 characters or longer
```
 sed -n '/^.\{65\}/p'
```

#### print only lines of less than 65 characters
```
 sed '/^.\{65\}/d'
```

#### print section of file from regular expression to end of file
```
 sed -n '/regexp/,$p'
```

#### print section of file based on line numbers (lines 8-12, inclusive)
```
 sed -n '8,12p'
```

#### print line number 52
```
 sed '52q;d'
```

#### print section of file between two regular expressions (inclusive, case sensitive)
```
 sed -n '/Iowa/,/Montana/p'
```

#### print all of file EXCEPT section between 2 regular expressions
```
 sed '/Iowa/,/Montana/d'
```

#### delete all leading blank lines at top of file
```
 sed '/./,$!d'
```

#### delete all trailing blank lines at end of file
```
 sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'
```
