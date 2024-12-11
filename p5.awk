#Usage awk -f p5.awk [fnames]
#print a histogram for number of "a" grades, "b" grades, etc
#assume record is: LName SID Mark
#only include records that have a sid in  field 2
BEGIN {print "Histogram of marks:"}
$2~/[0-9]+/ {   #~ is "contains", "+" is one-or-more of previous
                #(remember "*" is zero-or-more)
t=t+1
if ($3>=80) ++a
if ($3>=70&&$3<80) ++b
if ($3>=60&&$3<70) ++c
if ($3>=50&&$3<60) ++d
if ($3<50) ++f
}
END {
#need printf statements because print always puts a newline
#every time it is executed. So instead of AAAA would get each on
#a new line within the for loop
for (i=1;i<=a;i++) printf "%s", "A"
printf "\n"
for (i=1;i<=b;i++) printf "%s", "B"
printf "\n"
for (i=1;i<=c;i++) printf "%s", "C"
printf "\n"
for (i=1;i<=d;i++) printf "%s", "D"
printf "\n"
for (i=1;i<=f;i++) printf "%s", "F"
printf "\n"
print "Total records processed:", t
}
