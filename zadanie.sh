#! bin/bash

cat << THE_END
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
</head>
<body>
THE_END

while read LINE
do
    if echo "$LINE" | grep '^## ' >> /dev/null
    then
        LINE=$(echo "$LINE" | sed "s@## @<h2>@")
        LINE="$LINE</h2>"
        echo "$LINE"
        continue
    elif echo "$LINE" | grep '^# ' >> /dev/null
    then
        LINE=$(echo "$LINE" | sed "s@# @<h1>@")
        LINE="$LINE</h1>"
        echo "$LINE"
        continue
    fi
    if echo "$LINE" | grep '^$'
    then
        LINE="<p>"
    fi
    if echo "$LINE" | grep '__[^_| ]\+__' >> /dev/null
    then
        LINE=$(echo "$LINE" | sed "s@__\([^_| ]\+\)__@<strong>\1\</strong>@g")
    fi
    if echo "$LINE" | grep '_[^_| ]\+_' >> /dev/null
    then
        LINE=$(echo "$LINE" | sed "s@_\([^_]\+\)_@<em>\1\</em>@g")
    fi
    echo "$LINE"

done

cat << THE_END
</body>
</html>
THE_END
