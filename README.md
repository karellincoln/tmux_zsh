# tmux_zsh

在这里集成shell的配置。形成稳定的工作环境。

## zsh

使用[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)的配置.

-----

[**教程**](https://xiaozhou.net/learn-the-command-line-iterm-and-zsh-2017-06-23.html)

-----

### 了解oh-my-zsh

1. plugins： 各种插件，如git，docker， go， extract等。
2. themes： 各种主题。
3. templates：一个默认配置的模板。配置了使用哪个主题，添加哪些插件。
4. oh-my-zsh.sh：如何运行oh-my-zsh。

#### 切换目录

在Zsh中，可以通过输入 . 号来跳转，比如：

* 直接输入.. 和 … 可以快速切换到上层和上上层目录
* 直接输入n+1个点，可以往上层跳转 n 层

#### 进程id补全

Zsh的补全功能非常不错，除了一般的目录和文件名补全，还可以自动补全进程ID。比如，我们通常要kill掉一个进程，得先用 `ps -aux|grep process_name` 先拿到进程id，然后再 `kill pid` 来终止掉一个进程。在Zsh中可以直接kill + process_name + tab 联想pid

#### 快速跳转

Zsh支持目录的快速跳转，我们可以使用 `d` 这个命令，列出最近访问过的各个目录，然后选择目录前面的数字进行快速跳转：


#### 常用命令参数补全

Zsh在行的，不光是目录名的补全，嗯，常用的命令参数，它也能给你提供参考

**这个真的很实用**

#### Zsh 常用插件推荐

1. autojump ：     
    autojump也是一个目录直接快速跳转的效率工具，它会自动记录之前访问过的目录，并计算权重。用法也很简单 `j directory_name `即可。比如我要访问 `~/workspace/src` ，只需要输入 `j src `就行了……
2. sublime:      
    可以方便的在Zsh终端中调用Sublime Text打开文件，比如输入 `st README.md `就可以调用机器上安装的Sublime Text打开当前目录的README.md文件进行编辑操作。
3. web-search:    
    一个方便的终端搜索工具，支持大多常用的搜索引擎，比如：     
    * 输入 baidu hhkb pro2 直接在浏览器打开百度搜索关键字”hhkb pro2”
    * 输入 google minila air 直接在浏览器打开Google搜索关键字”minila air”      
    通过查看这个插件的[代码](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/web-search/web-search.plugin.zsh#L9-L18)，可以看到支持的搜索引擎，包括baidu, google, bing, yahoo 等等…… 当然，还有广大程序化最爱的GitHub哦！
4. zsh-autosuggestions:    
    命令自动提示插件，这个是个很有意思也很高效的插件。能记录平时你输入过的命令，下次再输入的时候，它会提前提示你，方便懒人。如果是你需要的命令，直接 `Ctrl+F` 搞定
    需要安装两个插件zsh-syntax-highlighting，zsh-autosuggestions。 已经放在oh-my-zsh/custom/plugins里面了。
5. extract：   
    一个功能强大的解压插件，所有类型的文件解压通过一个命令x全搞定，再也不需要去记tar后面到底是哪几个参数了。   
    比如： `x backup.tar.gz` 或者 `x temp.zip`

## tmux

-----

[**优雅地使用命令行：Tmux 终端复用**](http://harttle.land/2015/11/06/tmux-startup.html)
[tmux 指南](http://wdxtub.com/2016/03/30/tmux-guide/)

-----

你是否曾经开过一大堆的 Terminal？有没有把它们都保存下来的冲动？Tmux 的Session就是做这件事情的！ 你可以随时退出或者进入任何一个 Session。每个 Session 有若干个 Window，每个 Window 又可以分成多个窗格（Pane）。 极大地满足 Terminal 用户的需求。

![](http://harttle.land/assets/img/blog/tmux-concept.png)

在终端中输入 tmux 就可以打开一个新的 tmux session，tmux 的所有操作必须先使用一个前缀键（默认是 `ctrl + b`）进入命令模式，或者说进入控制台，就像 vim 中的 esc。

### 基本操作

> 信息查询

    * tmux list-keys 列出所有可以的快捷键和其运行的 tmux 命令
    * tmux list-commands 列出所有的 tmux 命令及其参数
    * tmux info 流出所有的 session, window, pane, 运行的进程号，等。

> 窗口控制

先来看看在 tmux 之外如何进行控制

1. session 会话：session是一个特定的终端组合。输入tmux就可以打开一个新的session    
    1. tmux new -s session_name 创建一个叫做 session_name 的 tmux session
    2. tmux attach -t session_name 重新开启叫做 session_name 的 tmux session
    3. tmux switch -t session_name 转换到叫做 session_name 的 tmux session
    4. tmux list-sessions / tmux ls 列出现有的所有 session
    5. tmux detach 离开当前开启的 session
    6. tmux kill-server 关闭所有 session
2. window 窗口：session 中可以有不同的 window（但是同时只能看到一个 window）     
    1. tmux new-window 创建一个新的 window
    2. tmux list-windows
    3. tmux select-window -t :0-9 根据索引转到该 window
    4. tmux rename-window 重命名当前 window
3. pane 面板：window 中可以有不同的 pane（可以把 window 分成不同的部分）    
    * tmux split-window 将 window 垂直划分为两个 pane
    * tmux split-window -h 将 window 水平划分为两个 pane
    * tmux swap-pane -\[UDLR\] 在指定的方向交换 pane
    * tmux select-pane -\[UDLR\] 在指定的方向选择下一个 pane

更常用的是在 tmux 中直接通过默认前缀 ctrl + b 之后输入对应命令来操作，（自己定义为ctrl + x）具体如下（这里只列出输入默认前缀之后需要输入的操作）：

> 基本操作

* ? 列出所有快捷键；按q返回
* d 脱离当前会话,可暂时返回Shell界面
* s 选择并切换会话；在同时开启了多个会话时使用
* D 选择要脱离的会话；在同时开启了多个会话时使用
* : 进入命令行模式；此时可输入支持的命令，例如 kill-server 关闭所有tmux会话
* \[ 复制模式，光标移动到复制内容位置，空格键开始，方向键选择复制，回车确认，q/Esc退出
* \] 进入粘贴模式，粘贴之前复制的内容，按q/Esc退出
* ~ 列出提示信息缓存；其中包含了之前tmux返回的各种提示信息
* t 显示当前的时间
* ctrl + z 挂起当前会话

> 窗口操作

* c 创建新窗口
* & 关闭当前窗口
* \[0-9\] 数字键切换到指定窗口
* p 切换至上一窗口
* n 切换至下一窗口
* l 前后窗口间互相切换
* w 通过窗口列表切换窗口
* , 重命名当前窗口，便于识别
* . 修改当前窗口编号，相当于重新排序
* f 在所有窗口中查找关键词，便于窗口多了切换

> 面板操作

* " 将当前面板上下分屏（我自己改成了 -）
* % 将当前面板左右分屏（我自己改成了 |）
* x 关闭当前分屏
* ! 将当前面板置于新窗口,即新建一个窗口,其中仅包含当前面板
* ctrl+方向键 以1个单元格为单位移动边缘以调整当前面板大小
* alt+方向键 以5个单元格为单位移动边缘以调整当前面板大小
* q 显示面板编号
* o 选择当前窗口中下一个面板
* 方向键 移动光标选择对应面板
* \{ 向前置换当前面板
* \} 向后置换当前面板
* z 最大化当前所在面板
* page up 向上滚动屏幕，q 退出
* page down 向下滚动屏幕，q 退出

### 配置

我们可以先进行一些简单的配置，修改 ~/.tmux.conf 即可，让整个使用更方便。

```
#-- base --#
set -g default-terminal "screen-256color"
set -g display-time 3000
set -g history-limit 10000
set -g base-index 1
set -g pane-base-index 1
set -s escape-time 0
set -g mouse on
#-- bindkeys --#
# split windows like vim.  - Note: vim's definition of a horizontal/vertical split is reversed from tmux's
unbind s
bind s split-window -v
bind S split-window -v -l 40
bind v split-window -h
bind V split-window -h -l 120
# navigate panes with hjkl
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
# key bindings for horizontal and vertical panes
unbind %
bind | split-window -h      # 使用|竖屏，方便分屏
unbind '"'
bind - split-window -v      # 使用-横屏，方便分屏
# swap panes
bind ^u swapp -U
bind ^d swapp -D
bind q killp
bind ^e last
unbind r
bind r source-file ~/.tmux.conf \; display "Configuration Reloaded!"
#-- statusbar --#
set -g status-justify centre
set -g status-left "#[fg=red]s#S:w#I.p#P#[default]"
set -g status-right '[#(whoami)#(date +" %m-%d %H:%M ")]'
set -g status-left-attr bright
set -g status-left-length 120
set -g status-right-length 120
set -g status-utf8 on
set -g status-interval 1
set -g visual-activity on
setw -g monitor-activity on
setw -g automatic-rename off
# default statusbar colors
set -g status-bg colour235 #base02
set -g status-fg colour136 #yellow
set -g status-attr default
# default window title colors
setw -g window-status-fg colour244
setw -g window-status-bg default
#setw -g window-status-attr dim
# active window title colors
setw -g window-status-current-fg colour166 #orange
setw -g window-status-current-bg default
#setw -g window-status-current-attr bright
# window title string (uses statusbar variables)
set -g set-titles-string '#T'
set -g status-justify "centre"
set -g window-status-format '#I #W'
set -g window-status-current-format ' #I #W '
# pane border
set -g pane-active-border-fg '#55ff55'
set -g pane-border-fg '#555555'
# message text
set -g message-bg colour235 #base02
set -g message-fg colour166 #orange
# pane number display
set -g display-panes-active-colour colour33 #blue
set -g display-panes-colour colour166 #orange
# clock
setw -g clock-mode-colour colour64 #green
# 修改进入命令模式按键
# remap prefix to Control + a
# set -g prefix C-a
# unbind C-b
# bind C-a send-prefix

```

### oh-my-zsh 中tmux aliases

| Alias | Command    |
|:------|:-----------|
|ta | tmux attach -t|
|tad | tmux attach -d -t|
|ts | tmux new-session -s|
|tl | tmux list-sessions|
|tksv | tmux kill-server|
|tkss | tmux kill-session -t|
