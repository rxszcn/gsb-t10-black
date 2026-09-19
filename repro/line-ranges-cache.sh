# 复现：先只格式化前几行，再做整体检查，第二步会说「这个文件没改动过」直接跳过
set -e
repo=$(cd "$(dirname "$0")/.." && pwd)
py=$repo/.venv/bin/python
d=$(mktemp -d)
cd "$d"
printf 'x=1
y  =2
' > f.py
for i in 3 4 5; do printf 'z%s   =%s
' "$i" "$i" >> f.py; done
"$py" -m black --line-ranges=1-3 f.py >/dev/null
set +e
"$py" -m black --check f.py
echo "check 退出码 = $?  （第 4、5 行还没格式化，本该是非零）"
