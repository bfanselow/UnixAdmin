# UnixAdmin
Miscellaneous Unix/Linux system-admin tips, tricks, etc.

---
### Good way to get the same predictable "ps" output on all flavors of new/old Solaris, HP-UX, AIX, Linux, etc.
#### Simply doing "ps -eaf" can give different results on each of these flavors (other fields can be passed in -o arglist)
```
ps -A -o 'user pid ppid pcpu rss etime args'
```
---
### Find file-systems nodes and perform an operation
#### Find files ending in .log and remove them if older than 30 days (using -exec arg with find)
```
find /var/log -name "\*.log" -type f -mtime +30 -exec rm -f {} \;
```
#### Recursive grep (piping find results via "xargs")
```
find / -type f | xargs grep password
```
