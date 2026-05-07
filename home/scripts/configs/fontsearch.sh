#!/run/current-system/sw/bin/bash
# -----------------------------------------------------
# font search
# Author: Silas Zhang (2026)
# -----------------------------------------------------

# 列出字体名称（模糊搜索）
fc-list \
    | grep -ioE ": [^:]*$1[^:]+" \
    | sed -E 's/(^: | :)//g' \
    | tr ',' '\n' \
    | sort \
    | uniq