file_process(){
	echo $1    # file name
	remain_entries=""
	while IFS= read -r entry; do
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

process_decade(){
    echo $1		# 10 file names
    timestamp=`date "+%Y-%m-%d:%H-%M-%S"`
    outputFile="output/results-$timestamp-$RANDOM.txt"
    echo -n > $outputFile

    # printf "%s\n" $1 | xargs -n 1 -I {} bash -c 'file_process "$@"' _ input/{} $outputFile
    printf "%s\n" $1 | xargs -n 1 -I {} bash -c 'file_process "$@"' _ {} $outputFile
    return 0
}

export -f process_decade
export -f file_process
# ls ./input | xargs -n10 | xargs -I {} bash -c 'process_decade "$@"' _ {}
find ./input -type f \( -name "*.xlsx" -o -name "*.avro" \) | xargs -n10 | xargs -I {} bash -c 'process_decade "$@"' _ {}
exit 0