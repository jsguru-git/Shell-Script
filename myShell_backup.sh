file_process(){
	echo $1    # file name
	remain_entries=""
	while IFS= read -r entry; do
		# echo "$entry"
		while IFS= read -r line; do
			if [ "$entry" == "$line" ]; then
				remain_entries=${remain_entries}$entry$'\r'
				continue 2
			fi
		done <"$2"
		echo "$entry" >> $2
	done <"$1"
	echo "$remain_entries" > $1
}

# echo_var(){
#     echo $1
#     echo $2
#     echo "happy"
#     return 0
# }

process_decade(){
    echo $1		# 10 file names
    timestamp=`date "+%Y-%m-%d:%H-%M-%S"`
    outputFile="output/results-$timestamp-$RANDOM.txt"

    printf "%s\n" $1 | xargs -n 1 -I {} bash -c 'file_process "$@"' _ input/{} $outputFile
    # wait
    # echo "decade done"
    return 0
}

export -f process_decade
export -f file_process
# export -f echo_var
ls ./input | xargs -n4 | xargs -I {} bash -c 'process_decade "$@"' _ {}
exit 0
# timestamp=`date "+%Y-%m-%d:%H-%M-%S"`
# outputFile="output/results-$timestamp-$RANDOM.txt"
# echo $timestamp
# echo $outputFile