for entry in ./*
do
  for entry_nodot in $(printf "$entry " | awk '{ gsub(/\.\//, ""); print }')
  do
    printf "$entry_nodot "
  done
done
