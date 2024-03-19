#!/bin/sh

DIR="$(git rev-parse --show-toplevel)"

cd "${DIR}/network-diagram"

ls | grep -v -e ".md" -e ".png"| while read FILE
do
  FILENAME=${FILE%.*}
  echo "${FILENAME}"
  case ${FILE##*.} in
    "dot" )
      echo "Build graphviz image"
      dot ${FILE} -Kfdp -Tpng > aws-accounts.png
      ;;
    "nwdiag" )
      echo "Build network diagram image"
      nwdiag ${FILE}
      ;;
    "seqdiag" )
      echo "Build sequence diagram image"
      seqdiag ${FILE}
      ;;
    default )
      echo "not a file we need to process"
      ;;
  esac
  echo "## ${FILENAME}" > "${FILENAME}.md"
  echo "![${FILENAME}](https://github.com/may-den/devsysops-docs/blob/master/network-diagram/${FILENAME}.png)" >> "${FILENAME}.md"
done
