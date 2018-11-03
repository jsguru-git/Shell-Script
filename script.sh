#!/bin/bash
# while read line
# do
#     name=$line
#     echo "Text read from file - $name"
# done < $1

inputFolder="input"
outputFile="output/results.txt"
g=4

file_arr=()

file_process(){
	echo $1
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

for file in $inputFolder/*; do
	# echo "$(basename "$file")"
	# echo "$file"
	# while IFS= read -r line; do
	# 	echo "$line" >> $outputFile
	# done <"$file"
	file_arr+=($file)
done

for ((i=0; i < ${#file_arr[@]}; i+=g)); do
	# group of 10 files
	decade=( "${file_arr[@]:i:g}" )
	for file in ${decade[@]}; do
		file_process $file $outputFile &
	done
done

wait
echo "All done"

# echo_var(){
#     echo $1
#     echo "printed"
#     return 0
# }

# export -f echo_var
# # seq -f "n%04g" 1 100 |xargs -n 1 -P 10 -i echo_var {}
# # seq -f "n%04g" 1 100 | xargs -n 1 -P 10 -I {} bash -c 'echo_var "$@"' _ {}
# ls ./input | xargs -n4 | xargs -I {} bash -c 'echo_var "$@"' _ {}
# exit 0



# array=`ls ./input`
# # echo "${array[@]}"|xargs -n4
# decades=`"${array[@]}"|xargs -n4`

# echo $decades

# file_decade_arr=`ls ./input||xargs -n4`
# for file_decade in $file_decade_arr; do
# 	echo $file_decade
# done

# echo $file_decade_arr
# g=4
# for((i=0; i < ${#array[@]}; i+=g))
# do
# 	part=( ${array[@]:i:g} )
# 	echo "${#part[@]}"
# done

# myfunc()
# {
#   echo "I was called as : $@"
#   echo "You were called as : $1"
#   echo "he was called as : $2"
#   x=2
# }

# ### Main script starts here 

# echo "Script was called with $@"
# x=1
# echo "x is $x"
# myfunc I You He
# echo "x is $x"
