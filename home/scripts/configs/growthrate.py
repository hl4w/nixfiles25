# -----------------------------------------------------
# growth rate Config
# Author: Silas Zhang (2026)
# -----------------------------------------------------

import rich
import pyperclip

from rich.console import Console
from rich.prompt import FloatPrompt

# 初始化控制台
console = Console()

# 获取用户输入
old_val = FloatPrompt.ask("Old value")
new_val = FloatPrompt.ask("New value")

# 计算增长�?
growth_rate = ((new_val - old_val) / old_val)
percentage = "{:.2%}".format(growth_rate)

# 输出结果
console.print(f"\nResult: {percentage}", style="bold green")

# 复制到剪贴板
pyperclip.copy(percentage)
console.print("[bold blue]Result copied to clipboard![/bold blue]")