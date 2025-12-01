#!/usr/bin/env sh

echo "Finding Flutter Apps (may take awhile)"
list=$(adb shell "pm list packages -f")
counter=0
for item in $list; do
  entry=$(echo $item | cut -d':' -f2 | sed -E 's/(.*)=/\1 /')
  pkg=$(echo $entry | cut -d" " -f2)
  baseapk=$(echo $entry | cut -d" " -f1)
  datadir=$(echo $baseapk | rev | cut -d"/" -f2- | rev)
  isflutter=$(adb shell "find $datadir -name '*.apk' 2>/dev/null | xargs -r -n 1 unzip -l | grep libflutter.so | wc -l")
  if [[ "$isflutter" -ge 1 ]]; then
    ((++counter))
    echo "Flutter FOUND! $pkg"
  fi
done
echo "\nFound: $counter"

