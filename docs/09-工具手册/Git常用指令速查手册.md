# Git 常用指令速查手册

> 本文档面向有一定基础但想系统掌握 Git 的开发者，侧重常用场景和实战技巧。

---

## 一、基础概念

### 工作区、暂存区、版本库

```
工作区 (Working Directory)  →  git add  →  暂存区 (Staging Area)
暂存区 (Staging Area)       →  git commit  →  本地版本库 (Local Repository)
本地版本库 (Local Repository) →  git push  →  远程版本库 (Remote Repository)
```

- **工作区**：你正在编辑的文件夹
- **暂存区**：准备提交的文件快照（Index）
- **版本库**：已提交的历史记录
- **远程**：GitHub / GitLab 等托管平台

---

## 二、最简工作流

```bash
# 1. 查看当前修改
git status

# 2. 把所有修改暂存起来
git add -A

# 3. 提交，附上说明
git commit -m "修复了登录页面样式问题"

# 4. 推送到远程仓库
git push
```

> 只需要记住这 4 步，就能应对 80% 的日常开发场景。

---

## 三、查看状态和历史

### 查看当前状态
```bash
git status                        # 简洁模式
git status -s                     # 超简洁（一行）
git status --short                 # 同上
```

### 查看具体修改
```bash
git diff                          # 工作区 vs 暂存区（未 add 的修改）
git diff --staged                 # 暂存区 vs 上次提交（已 add 但未 commit）
git diff HEAD                     # 工作区 vs 最新提交
git diff main..feature            # 两个分支的差异
```

### 查看提交历史
```bash
git log                           # 详细日志（按 q 退出）
git log --oneline                 # 每条一行，显示 commit hash 前 7 位
git log --oneline -5              # 最近 5 条
git log --graph --oneline         # 带分支图的简洁视图
git log -p filename               # 查看某个文件的历史修改
git log --author="张三"           # 只看某人的提交
git log --since="2025-01-01"      # 指定时间之后的提交
```

### 查看远程信息
```bash
git remote -v                     # 查看远程仓库地址
git remote show origin             # 查看 origin 的详细信息
```

---

## 四、暂存文件（git add）

```bash
git add filename.txt             # 暂存单个文件
git add src/                      # 暂存整个目录
git add *.vue                     # 按通配符暂存
git add .                          # 暂存当前目录所有修改（不包括删除）
git add -A                         # 暂存所有修改（新增+修改+删除），推荐
git add -u                         # 只暂存已跟踪文件的修改和删除，不含新文件
```

> **建议**：平时用 `git add -A` 最省心，不会漏掉新文件。

### 撤销暂存
```bash
git restore --staged .            # 取消全部暂存（保留文件修改）
git restore --staged filename.txt  # 取消某个文件暂存
git reset HEAD .                   # 同上（老写法）
git reset HEAD filename.txt        # 同上
```

---

## 五、提交（git commit）

```bash
git commit -m "修复了用户头像上传失败的问题"
git commit -m "feat: 添加了用户登录功能"              # 推荐格式
git commit -m "fix: 修正了购物车价格计算错误"
git commit -m "docs: 更新了接口文档"

# 常见提交类型前缀：
# feat (新功能)
# fix (修复 bug)
# docs (文档)
# style (格式，不影响代码)
# refactor (重构)
# test (测试)
# chore (杂项，工具/构建变更)
```

### 提交时自动暂存
```bash
git commit -am "描述"               # -am = add + commit（仅限已跟踪文件）
```

### 修改上一个提交
```bash
git commit --amend                  # 追加修改到上一个 commit（未 push 时）
git commit --amend -m "新的描述"     # 修改上一个 commit 的消息
```

> 注意：`--amend` 会改写 commit 历史，**仅限未 push 的情况使用**。

### 空提交（触发 CI 等）
```bash
git commit --allow-empty -m "trigger CI"
```

---

## 六、分支操作

### 查看分支
```bash
git branch                         # 查看本地分支（当前分支前有 *）
git branch -a                      # 查看所有分支（含远程）
git branch -r                      # 只看远程分支
```

### 创建和切换
```bash
git branch feature-login            # 创建新分支
git checkout feature-login           # 切换到该分支
git switch feature-login            # 同上（推荐，命令更直观）

# 快捷创建+切换
git checkout -b feature-login       # 创建并切换（新分支）
git switch -c feature-login          # 同上（推荐）
```

### 重命名分支
```bash
git branch -m old-name new-name     # 重命名当前分支
git branch -m new-name              # 当前分支改名为 new-name
```

### 删除分支
```bash
git branch -d feature-login          # 删除已合并的分支
git branch -D feature-login          # 强制删除（未合并也删）
```

### 合并分支
```bash
git checkout main
git merge feature-login              # 把 feature-login 合并到 main
```

### 变基（Rebase）
```bash
git checkout feature-login
git rebase main                      # 把 feature-login 变基到 main 之上
```

> **何时用 rebase？** 当 feature 分支需要同步 main 最新代码时用 rebase，可以保持线性历史。
> **何时用 merge？** 在 main 上合并 feature 时用 merge，保留分支轨迹。

---

## 七、撤销和回退

### 撤销工作区修改（未 add）
```bash
git restore .                        # 撤销所有未暂存的修改
git restore filename.txt             # 撤销某个文件
git checkout -- filename.txt         # 老写法，效果相同
```

### 撤销暂存（已 add，未 commit）
```bash
git restore --staged .               # 取消暂存，保留修改
git reset HEAD .                      # 老写法
```

### 回退到某个提交

**场景一**：已 commit 但未 push，想撤销
```bash
git reset --soft HEAD~1              # 保留改动，在暂存区
git reset --mixed HEAD~1             # 保留改动，在工作区（默认）
git reset --hard HEAD~1              # 彻底撤销，丢失改动（危险！）
```

**场景二**：想回到某个历史版本
```bash
git reset --hard 9f123ab             # 回到指定 commit（丢失之后所有提交）
git reset --hard HEAD~3             # 回退 3 个 commit
```

**场景三**：只想看旧版本，不破坏历史
```bash
git checkout 9f123ab                # 进入 detached HEAD 状态（只读）
git checkout HEAD~3                # 看倒数第 3 个版本
git checkout main                   # 回到 main
```

### 恢复被删除的 commit
```bash
git reflog                          # 找到被删 commit 的 hash
git reset --hard 9f123ab            # 用那个 hash 恢复
```

---

## 八、推送和拉取

### 推送到远程
```bash
git push                            # 推送当前分支到 origin
git push -u origin feature-login    # 首次推送，设置上游分支
git push origin main                # 推送指定分支
git push --force                    # 强制推送（慎用！会覆盖远程）
```

### 拉取远程更新
```bash
git pull                            # 拉取 + 合并，等于 fetch + merge
git pull --rebase                   # 拉取 + 变基（避免多余 merge commit）
git fetch origin                    # 仅获取，不合并
```

### 处理多人协作冲突
```bash
# 1. 先拉取最新代码
git fetch origin

# 2. 变基到最新版本（可能产生冲突）
git rebase origin/main

# 3. 手动解决冲突后
git add filename.txt
git rebase --continue

# 4. 如果想放弃变基
git rebase --abort
```

---

## 九、暂存（Stash）

当你需要临时切换分支但不想提交当前修改时：

```bash
git stash                           # 暂存当前所有修改
git stash push -m "未完成的功能，待会儿继续"

git stash list                      # 查看所有 stash

git stash pop                       # 弹出（恢复 + 删除 stash）
git stash apply                    # 应用 stash（不删除，类似备份）

git stash drop stash@{0}            # 删除某个 stash
git stash clear                    # 清空所有 stash
```

---

## 十、标签（Tag）

```bash
git tag v1.0.0                      # 给当前 commit 打轻量标签
git tag -a v1.0.0 -m "版本1.0.0"    # 给当前 commit 打附注标签
git tag -a v0.9.0 9f123ab           # 给历史 commit 打标签
git tag                            # 查看所有标签
git show v1.0.0                    # 查看标签详情
git push origin v1.0.0             # 推送标签到远程
git push origin --tags             # 推送所有标签
git tag -d v1.0.0                  # 删除本地标签
git push origin --delete v1.0.0   # 删除远程标签
```

---

## 十一、忽略文件（.gitignore）

```gitignore
# 注释
node_modules/
dist/
.env
*.log
.DS_Store
.idea/
*.iml
```

> 已跟踪的文件无法通过 .gitignore 忽略，需要先移除：`git rm --cached filename`

### 检查忽略规则是否生效
```bash
git check-ignore -v filename.txt    # 检查某个文件是否会被忽略
git status --ignored               # 显示被忽略的文件
```

---

## 十二、搜索和查找

```bash
git grep "关键字"                    # 在代码中搜索关键字
git grep -n "关键字"                 # 显示行号
git log --all --grep="关键字"       # 在提交记录中搜索

# 查找某个 commit 改动了哪些文件
git show 9f123ab --name-only

# 查找谁最后修改了某行代码
git blame filename.txt
```

---

## 十三、其他实用技巧

### 查看有哪些远程分支已删除（远程已删除但本地还有）
```bash
git fetch --prune                   # 清理已删除的远程分支引用
git remote prune origin             # 同上
```

### 查看 commit 统计
```bash
git shortlog                        # 按提交者统计
git shortlog -sn                    # 只看提交数量排序
git diff --stat                     # 显示每个文件改动行数统计
```

### 打补丁
```bash
git diff > changes.patch            # 导出改动为补丁文件
git apply changes.patch             # 应用补丁
```

### 设置别名（简化命令）
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph"
```

> 设置后 `git st` 等于 `git status`，`git lg` 等于 `git log --oneline --graph`

---

## 十四、常见问题处理

### Q: 提交信息写错了怎么办？
```bash
git commit --amend                  # 改最后一个提交的信息或追加文件
```

### Q: 不小心在 main 上开发了怎么办？
```bash
git stash                          # 暂存改动
git checkout -b feature-temp       # 创建新分支
git stash pop                      # 恢复改动
git checkout main                  # 回到 main
git branch -d old-feature          # 删除错误分支
```

### Q: push 之后发现有个文件不该提交怎么办？
```bash
# 从历史记录中移除（适合敏感信息）
git filter-branch --force --tree-filter 'rm -f password.txt' HEAD
# 或使用 BFG Repo-Cleaner 工具（更安全更快）
```

### Q: 合并冲突了怎么办？
```bash
# 1. 打开冲突文件，搜索 <<< === >>> 标记，手动合并
# 2. 修改后
git add filename.txt
git commit -m "解决冲突"

# 或者放弃合并
git merge --abort
```

### Q: 如何查看当前 HEAD 是谁？
```bash
git rev-parse HEAD                 # 显示当前 commit 的完整 hash
git rev-parse --abbrev-ref HEAD    # 显示分支名（如果是分支的话）
```

---

## 十五、推荐的工作流程

### 小团队（2-5 人）
```
1. 每个人从 main 新建自己的功能分支
2. 在功能分支开发，定期 rebase main 同步最新代码
3. 完成后发起 Pull Request / Merge Request
4. 同事 code review，通过后合并到 main
```

### 大团队
```
1. main 作为稳定分支，所有人不得直接 commit
2. 从 main 新建 develop 分支作为开发主干
3. 功能分支从 develop 创建
4. 合并到 develop 后打预发布标签
5. 测试通过后合并到 main 并打正式标签
```

---

## 十六、一图总结常用命令

```
git init                    → 创建仓库
git clone url              → 克隆仓库
git add -A                  → 暂存所有修改
git commit -m "描述"        → 提交
git push                    → 推送到远程
git pull                    → 拉取远程更新

git status                  → 查看状态
git diff                    → 查看改动
git log --oneline           → 查看历史

git branch                  → 查看分支
git checkout -b xxx          → 新建并切换
git merge xxx               → 合并分支

git stash                   → 暂存工作区
git stash pop               → 恢复暂存

git reset --hard xxx        → 回退版本（危险）
git revert xxx              → 反做某个提交（安全）
```

---

> 本文档会持续更新。如有疑问，欢迎通过 issue 反馈。