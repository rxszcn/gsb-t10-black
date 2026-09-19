# 复现：先只格式化前几行，再做整体检查，第二步会说「这个文件没改动过」直接跳过
set -e
d=$(mktemp -d)
cd "$d"
printf 'x=1\ny  =2\n' > f.py
for i in 3 4 5; do printf 'z%s   =%s\n' "$i" "$i" >> f.py; done
B=${PWD}/../../../../../home
PYBIN=${PYBIN:-$HOME/gsb/repos/t10-black/.venv/bin/python}
"$PYBIN" -m black --line-ranges=1-3 f.py >/dev/null
set +e
"$PYBIN" -m black --check f.py
echo "check 退出码 = $?  （应该是非零，因为第 4、5 行还没格式化）"
