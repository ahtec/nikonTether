#!/bin/sh
case "$ACTION" in 
            start) 
                echo "$self: READY.." 
                ;; 
            download) 
		# Read the session settings
		. $PWD/session.conf
###        echo ${ARGUMENT##*.}
        echo ${ACTION}

        if [ "${ARGUMENT##*.}" = "NEF" ]; then
            
    		this_file_number=$((last_file_number+1))
    		file_string=`printf "%04d" $this_file_number`
		    this_filename="$file_prefix-$file_string.NEF"
		    # Copy latest file to latest.NEF so screen updates
##		    touch latest.NEF
##		    cp $ARGUMENT latest.NEF
		    # Rename file from camera to our preferred
		    echo ":: RENAME to ./nefs/$this_filename"
		    mv -n $ARGUMENT "./nefs/$this_filename"
		    # Update the session.conf with the new counter level
		    echo "file_prefix=$file_prefix" > $PWD/session.conf
		    echo "last_file_number=$this_file_number" >> $PWD/session.conf
        else
            echo "move new jpg naar de laatste preview"
###            touch preview.jpg
            this_file_number=$((last_file_number+1))
    		file_string=`printf "%04d" $this_file_number`
            this_filename="$file_prefix-$file_string.jpg"
            cp  $ARGUMENT "./jpgs/$this_filename"
            mv   $ARGUMENT ./jpgs/preview.jpg      
		    # Update the session.conf with the new counter level
		    echo "file_prefix=$file_prefix" > $PWD/session.conf
		    echo "last_file_number=$this_file_number" >> $PWD/session.conf
  
        fi

                ;; 
        esac 
        exit 0 

