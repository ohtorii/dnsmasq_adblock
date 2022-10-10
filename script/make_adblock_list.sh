#!/bin/bash
#
# Contact.
# http://d.hatena.ne.jp/ohtorii/
# https://github.com/ohtorii/
# https://twitter.com/ohtorii
#


format(){
  #remove BOM,comment(#...),space tab and empty lines.
  #convert CRLF -> LF
  echo "$1" | sed -e '1s/^\xef\xbb\xbf//' | sed -e "s/\r//g" | sed -e "/^#/d"|sed -e "/^[<space><tab>\n\r]*$/d"|sed -e "/^$/d" > $2
}

make_work_dir(){
  #作業ディレクトリ名を返す
  while :
  do
    local dir=/tmp/adlist_work$RANDOM/
    if [ -d $dir ]; then
      #ディレクトリ名を作り直して再挑戦
      :
    else
      echo $dir
      break
    fi  
  done
}

download_adlist(){
  local result=`curl -LI "$1" -w '%{http_code}\n' -s -o /dev/null`
  if [ ! $result -eq 200 ];then
    echo "Not found URL."
    echo $1
    return 1
  fi
  local src=`curl -s "$1"`
  format "$src" "$2"
  log_title $1 
  log_body $2
  return 0
}

log_title(){
  echo ===========================================
  echo "$1"
  echo ===========================================
  
}

log_body(){
  echo [head]
  echo `head "$1"`
  echo [tail]
  echo `tail "$1"`
  echo [wc]
  echo `wc "$1"`
}

process(){
  post_fix=$(date +%Y%m)
  url="https://280blocker.net/files/280blocker_domain_"${post_fix}".txt"
  download_adlist ${url} ${work_dir}host_280domain.txt
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  download_adlist "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=showintro=0&amp;mimetype=plaintext" ${work_dir}host_yoyo.txt
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  echo ${script_dir}/static_list.txt 
  if [ -f ${script_dir}/static_list.txt ]; then
    src=`cat ${script_dir}/static_list.txt`
    format "$src" "${work_dir}host_static.txt"
    log_body "${work_dir}host_static.txt" 
  else
    echo Not found.
  fi

  #
  #(memo) host_*.txt -> merged.txt -> final.txt -> dnsmasq_adblock_list.txt
  #
  
  cat ${work_dir}host_*.txt | sort | uniq > ${work_dir}merged.txt
  
  #
  # Apply exclude.txt -> final.txt
  #
  echo ${script_dir}/exclude.txt 
  if [ -f ${script_dir}/exclude.txt ]; then
    grep -v -x -F -f ${script_dir}/exclude.txt ${work_dir}merged.txt > ${work_dir}final.txt
  else
    echo Not found.
    cp -f ${work_dir}merged.txt ${work_dir}final.txt
  fi
  
  # final.txt -> ${output_list_name}
  cat ${work_dir}final.txt | sed -e "s/^/address=\//g" | sed -e "s/\$/\/0\.0\.0\.0/g" > ${output_list_name}
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

usage(){
  echo Usage: make_adblock_list.sh outputFileName
}

main(){
  if [ ! $# -eq 1 ]; then
    usage
    return 1
  fi
  if [ $1 = "-h" ]; then
    usage
    return 0
  fi
  if [ $1 = "--help" ]; then
    usage
    return 0
  fi

  output_list_name=$1
  script_dir="$(abs_dirname "$0")"
  work_dir=`make_work_dir`
  mkdir $work_dir
  if [ ! -d $work_dir ]; then
    echo "work dir not created."
    return 1
  fi  

  process
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  rm -r -f $work_dir
}

main $*
