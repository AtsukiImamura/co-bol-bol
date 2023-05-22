temp_file_name_1=$(mktemp)
cat testfile | \
	awk '
	BEGIN { key=""; value=""; is_open="N";cur_str=""; cnt=0; title_str=""; value_str="" }
	{
		#print $0
		#title_str=""
		#value_str=""
		for(i=0; i<=length($0); i++){
			str=substr($0,i,1)
			#print "i=" i "  str=" str "  is_open=" is_open
			if(str=="[" && is_open=="N"){
				is_open="Y"
				# 
				if(cur_str!=""){
					key=cur_str
				}else{
					key=""
				}
				cur_str=""
				continue
			}
			if(str=="]" && is_open=="Y"){
				is_open="N"
				value=cur_str
				cur_str=""
				if(key==""){
					continue
				}
				title_str = title_str key " |"
				value_str = value_str value " |"
				continue
			}
			if(str==" " && cur_str==""){
				continue
			}
			cur_str = cur_str str
		}
	}
	/---/ {
		if(cnt==0){
			print title_str
		}
		print value_str
		cnt = cnt+1
		title_str=""
		value_str=""
		key=""
		value=""
		is_open="N"
		current_str=""
	}
	END {
		if(cnt==0){
			print title_str
		}
		print value_str
	}
	' | \
awk -F "|" '
{ for (i=1; i<=NF; i++)  { a[NR,i] = $i } } NF>p { p = NF }
END {
    for(j=1; j<=p; j++) { str=a[1,j]; for(i=2; i<=NR; i++){ str=str" |"a[i,j]; }
        print str
    }
}' | column -s '|' -t
# echo $temp_file_name_1

# cat $temp_file_name_1  | awk -F "|" '{print $1}' |  while read line || [ -n "${line}" ]; do echo -n $line | wc -c; done
# cat $temp_file_name_1
# rm -f $temp_file_name_1



#echo $res | awk -F "|" '{print $1}'