set prog=main
set address=$80100000

msdos ccpsx -O3 -Xo%address% %prog%.c -o%prog%.cpe,,%prog%.map
msdos cpe2x %prog%.cpe