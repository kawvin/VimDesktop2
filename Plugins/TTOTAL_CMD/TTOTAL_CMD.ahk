﻿#requires AutoHotkey v2.0

/*
[PluginInfo]
PluginName=TC
Author=Kawvin
Version=0.1_2025.06.17
Comment=Total Commander
*/

global TC_Global:=object()
TC_Global.TcPath:="d:\KawvinApps\totalcmd\TOTALCMD64.EXE"
TC_Global.TcINI:="d:\KawvinApps\totalcmd\WinCMD.ini"
TC_Global.TcExe:="TOTALCMD64.EXE"
TC_Global.LastView:=""  ;最后视图

if RegExMatch(TC_Global.TcPath, "i)totalcmd64\.exe$") {
    TC_Global.TCListBox := "LCLListBox"
    TC_Global.TCEdit := "Edit2"
    TC_Global.TInEdit := "TInEdit1"
    TC_Global.TCPanel1 := "Window1"
    TC_Global.TCPanel2 := "Window11"
    TC_Global.TcPathPanel := "TPathPanel2"
} else {
    TC_Global.TCListBox := "TMyListBox"
    TC_Global.TCEdit := "Edit1"
    TC_Global.TInEdit := "TInEdit1"
    TC_Global.TCPanel1 := "Window1"
    TC_Global.TCPanel2 := "TMyPanel8"
    TC_Global.TcPathPanel := "TPathPanel1"
    TC_Global.TcPathPanelRight := "TPathPanel2"
}

TTOTAL_CMD(){
    KeyArray:=Array()
    ; 模式选择=========================================================
        KeyArray.push({Key:"<insert>", Mode: "普通模式", Group: "模式", Func: "ModeChange", Param: "VIM模式", Comment: "切换到【VIM模式】"})
        KeyArray.push({Key:"<insert>", Mode: "VIM模式", Group: "模式", Func: "ModeChange", Param: "普通模式", Comment: "切换到【普通模式】"})
        ; KeyArray.push({Key:"<esc>", Mode: "普通模式", Group: "模式", Func: "ModeChange", Param: "普通模式", Comment: "切换到【VIM模式】"})
        ; KeyArray.push({Key:"i", Mode: "VIM模式", Group: "模式", Func: "ModeChange", Param: "VIM模式", Comment: "切换到【普通模式】"})
        KeyArray.push({Key:"<capslock>", Mode: "VIM模式", Group: "模式", Func: "VIMD_清除输入键", Param: "", Comment: "清除输入键及提示"})
        
    ; 控制===========================================================
        KeyArray.push({Key:"w", Mode: "VIM模式", Group: "控制", Func: "SendKeyInput", Param: "{up}", Comment: "向上"})
        KeyArray.push({Key:"s", Mode: "VIM模式", Group: "控制", Func: "SendKeyInput", Param: "{down}", Comment: "向下"})
        KeyArray.push({Key:"*h", Mode: "VIM模式", Group: "控制", Func: "SendKeyInput", Param: "{left}", Comment: "向左"})
        KeyArray.push({Key:"*l", Mode: "VIM模式", Group: "控制", Func: "SendKeyInput", Param: "{right}", Comment: "向右"})
        KeyArray.push({Key:"z", Mode: "VIM模式", Group: "控制", Func: "SendKeyInput", Param: "{Enter}", Comment: "确认（Enter）"})
        KeyArray.push({Key:"gg", Mode: "VIM模式", Group: "控制", Func: "TC_GotoLine", Param: 1, Comment: "VIM_移动第一行"})
        KeyArray.push({Key:"G", Mode: "VIM模式", Group: "控制", Func: "TC_GotoLine", Param: 0, Comment: "VIM_移动到最后一行"})
        KeyArray.push({Key:"gd", Mode: "VIM模式", Group: "控制", Func: "TC_GotoLine", Param: "", Comment: "VIM_移动到[ 输入 ]行"})
        ;KeyArray.push({Key:"*``", Mode: "VIM模式", Group: "提示", Func: "TC_ToggleShowInfo", Param: "", Comment: "VIM_显示/隐藏按键提示"})
    ; 注释===========================================================
        KeyArray.push({Key:"m", Mode: "VIM模式", Group: "注释", Func: "TC_MarkFile", Param: "", Comment: "注释_文件添加注释"})
        KeyArray.push({Key:"M", Mode: "VIM模式", Group: "注释", Func: "TC_UnMarkFile", Param: "", Comment: "注释_文件删除注释"})
    ; 源面板=========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 300, Comment: "源面板_显示文件注释"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 301, Comment: "源面板_列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 302, Comment: "源面板_详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 303, Comment: "源面板_文件夹树"})
        KeyArray.push({Key:"Q", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 304, Comment: "源面板_快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 306, Comment: "源面板_快速查看(不使用插件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 307, Comment: "源面板_关闭快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 311, Comment: "源面板_程序文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 312, Comment: "源面板_所有文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 313, Comment: "源面板_上次选定的文件类型"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 314, Comment: "源面板_选择文件类型"})
        KeyArray.push({Key:"*sn", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 321, Comment: "源面板_按名称排序"})
        KeyArray.push({Key:"*se", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 322, Comment: "源面板_按扩展名排序"})
        KeyArray.push({Key:"*ss", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 323, Comment: "源面板_按大小排序"})
        KeyArray.push({Key:"*sd", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 324, Comment: "源面板_按日期时间排序"})
        KeyArray.push({Key:"*s0", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 325, Comment: "源面板_不排序"})
        KeyArray.push({Key:"*sr", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 330, Comment: "源面板_反向排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 331, Comment: "源面板_打开驱动器列表"})
        KeyArray.push({Key:"*,", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 269, Comment: "源面板_缩略图"})
        KeyArray.push({Key:"V", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 270, Comment: "源面板_显示自定义视图菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 332, Comment: "源面板_焦点移动到路径栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "源面板", Func: "TC_SendPos", Param: 333, Comment: "源面板_显示查看模式菜单"})
    ; 左侧面板=======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 100, Comment: "左侧面板_显示文件注释"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 101, Comment: "左侧面板_列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 102, Comment: "左侧面板_详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 103, Comment: "左侧面板_文件夹树"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 104, Comment: "左侧面板_快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 106, Comment: "左侧面板_快速查看(不使用插件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 107, Comment: "左侧面板_关闭快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 111, Comment: "左侧面板_程序文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 112, Comment: "左侧面板_所有文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 113, Comment: "左侧面板_上次选定的文件类型"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 114, Comment: "左侧面板_选择文件类型"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 121, Comment: "左侧面板_按名称排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 122, Comment: "左侧面板_按扩展名排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 123, Comment: "左侧面板_按大小排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 124, Comment: "左侧面板_按日期时间排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 125, Comment: "左侧面板_不排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 130, Comment: "左侧面板_反向排序"})
        KeyArray.push({Key:"*o", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 131, Comment: "左侧面板_打开驱动器列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 132, Comment: "左侧面板_焦点移动到路径栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 2034, Comment: "左侧面板_平面视图(所有文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 2047, Comment: "左侧面板_平面视图(仅限选定的文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 69, Comment: "左侧面板_缩略图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 70, Comment: "左侧面板_显示自定义视图菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "左侧面板", Func: "TC_SendPos", Param: 133, Comment: "左侧面板_显示查看模式菜单"})
    ; 右侧面板=======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 200, Comment: "右侧面板_显示文件注释"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 201, Comment: "右侧面板_列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 202, Comment: "右侧面板_详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 203, Comment: "右侧面板_文件夹树"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 204, Comment: "右侧面板_快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 206, Comment: "右侧面板_快速查看(不使用插件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 207, Comment: "右侧面板_关闭快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 211, Comment: "右侧面板_程序文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 212, Comment: "右侧面板_所有文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 213, Comment: "右侧面板_上次选定的文件类型"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 214, Comment: "右侧面板_选择文件类型"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 221, Comment: "右侧面板_按名称排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 222, Comment: "右侧面板_按扩展名排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 223, Comment: "右侧面板_按大小排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 224, Comment: "右侧面板_按日期时间排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 225, Comment: "右侧面板_不排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 230, Comment: "右侧面板_反向排序"})
        KeyArray.push({Key:"*O", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 231, Comment: "右侧面板_打开驱动器列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 232, Comment: "右侧面板_焦点移动到路径栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 2035, Comment: "右侧面板_平面视图(所有文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 2048, Comment: "右侧面板_平面视图(仅限选定的文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 169, Comment: "右侧面板_缩略图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 170, Comment: "右侧面板_显示自定义视图菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "右侧面板", Func: "TC_SendPos", Param: 233, Comment: "右侧面板_显示查看模式菜单"})
    ; 文件操作=======================================================
        KeyArray.push({Key:"fc", Mode: "VIM模式", Group: "文件操作", Func: "SendKeyInput", Param: ["{F5}", "{F2}", "|300"], Comment: "文件操作_(自动确认)使用队列拷贝文件至另一窗口"})
        KeyArray.push({Key:"fx", Mode: "VIM模式", Group: "文件操作", Func: "SendKeyInput", Param: ["{F6}", "{F2}", "|300"], Comment: "文件操作_(自动确认)使用队列移动文件至另一窗口"})
        KeyArray.push({Key:"fC", Mode: "VIM模式", Group: "文件操作", Func: "TC_CopyOrMoveFilesAndSubDirFilesToOtherPanel", Param: 0, Comment: "文件操作_复制所选文件及子文件到另一窗口(合并)"})
        KeyArray.push({Key:"fX", Mode: "VIM模式", Group: "文件操作", Func: "TC_CopyOrMoveFilesAndSubDirFilesToOtherPanel", Param: 1, Comment: "文件操作_移动所选文件及子文件到另一窗口(合并)"})
        KeyArray.push({Key:"fb", Mode: "VIM模式", Group: "文件操作", Func: "TC_CopyOrMoveToHotListDirectory", Param: 0, Comment: "文件操作_复制到常用文件夹"})
        KeyArray.push({Key:"fd", Mode: "VIM模式", Group: "文件操作", Func: "TC_CopyOrMoveToHotListDirectory", Param: 1, Comment: "文件操作_移动到常用文件夹"})
        KeyArray.push({Key:"XX", Mode: "VIM模式", Group: "文件操作", Func: "TC_Delete", Param: "", Comment: "文件操作_(自动确认)删除所选文件"})
        KeyArray.push({Key:"fw", Mode: "VIM模式", Group: "文件操作", Func: "TC_MoveSelectedFilesToPrevFolder", Param: "", Comment: "将选定文件移动到上层目录中"})
        KeyArray.push({Key:"Xc", Mode: "VIM模式", Group: "文件操作", Func: "TC_DeleteByExt", Param: "jpg,jpeg,gif,png", Comment: "文件操作-删除图片类文件"})
        KeyArray.push({Key:"Xd", Mode: "VIM模式", Group: "文件操作", Func: "TC_DeleteByExt", Param: "torrent;txt;html;url", Comment: "文件操作-删除指定类文件"})
        KeyArray.push({Key:"Xs", Mode: "VIM模式", Group: "文件操作", Func: "TC_DeleteByExt_GUI", Param: "", Comment: "文件操作-删除指定类文件（界面）"})
        KeyArray.push({Key:"I", Mode: "VIM模式", Group: "文件操作", Func: "TC_CreateNewFile", Param: "", Comment: "文件模板"})
        KeyArray.push({Key:"*X", Mode: "VIM模式", Group: "文件操作", Func: "SendKeyInput", Param: "+{Delete}", Comment: "强制删除"})
        KeyArray.push({Key:"ee", Mode: "VIM模式", Group: "文件操作", Func: "TC_UnpackFilesToCurrentDir", Param: 1, Comment: "解压文件到当前文件夹(包含文件夹)"})
        KeyArray.push({Key:"e", Mode: "VIM模式", Group: "文件操作", Func: "TC_UnpackFilesToCurrentDir", Param: 0, Comment: "解压文件到当前文件夹"})
        KeyArray.push({Key:"EE", Mode: "VIM模式", Group: "文件操作", Func: "TC_PackFilesToCurrentDir", Param: 0, Comment: "压缩文件到当前文件夹"})
        KeyArray.push({Key:"E", Mode: "VIM模式", Group: "文件操作", Func: "TC_PackFilesToCurrentDir", Param: 1, Comment: "压缩文件到另一面板"})
        KeyArray.push({Key:"EEE", Mode: "VIM模式", Group: "文件操作", Func: "TC_PackFilesToCurrentDirWithVersion", Param: 0, Comment: "压缩文件到当前文件夹_带版本"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_FileCopyForBak", Param: "", Comment: "将当前光标下的文件复制一份作为作为备份"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_FileMoveForBak", Param: "", Comment: "将当前光标下的文件重命名为备份"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_MultiFilePersistOpen", Param: "", Comment: "多个文件一次性连续打开"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_CopyFileContents", Param: "", Comment: "不打开文件就复制文件内容"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_OpenDirAndPaste", Param: "", Comment: "不打开目录，直接把复制的文件贴进去"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_TwoFileExchangeName", Param: "", Comment: "两个文件互换文件名"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_CreateFileShortcut", Param: 0, Comment: "创建当前光标下文件的快捷方式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_CreateFileShortcut", Param: 1, Comment: "创建当前光标下文件的快捷方式,并发送到桌面"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_CreateFileShortcut", Param: 2, Comment: "创建当前光标下文件的快捷方式,并发送到启动文件夹"})
        ;以下内置命令--------------
        KeyArray.push({Key:"*w", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 903, Comment: "文件操作_查看文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1006, Comment: "文件操作_查看单个文件(不使用插件/多媒体)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2933, Comment: "文件操作_查看所选文件(不使用插件/多媒体)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2934, Comment: "文件操作_查看单个文件(使用插件/多媒体)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2935, Comment: "文件操作_查看所选文件(使用插件/多媒体)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 3026, Comment: "文件操作_查看文件(使用外部查看程序)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 904, Comment: "文件操作_编辑文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 905, Comment: "文件操作_复制文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2931, Comment: "文件操作_新建或打开文本文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2943, Comment: "文件操作_显示“新建”上下文菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2932, Comment: "文件操作_编辑光标下的文件(忽略 Shift 键)"})
        KeyArray.push({Key:"fs", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 3100, Comment: "文件操作_复制到当前面板(Shift+F5)"})
        KeyArray.push({Key:"fqc", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 3101, Comment: "文件操作_复制到另一侧面板(F5)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 906, Comment: "文件操作_重命名/移动文件"})
        KeyArray.push({Key:"fn", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 907, Comment: "文件操作_新建文件夹(源面板)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 911, Comment: "文件操作_新建文件夹(目标面板)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 908, Comment: "文件操作_删除文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 518, Comment: "文件操作_测试压缩包"})
        KeyArray.push({Key:"*E", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 508, Comment: "文件操作_压缩文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2955, Comment: "文件操作_压缩文件(复制)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2956, Comment: "文件操作_压缩文件(移动)"})
        KeyArray.push({Key:"*e", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 509, Comment: "文件操作_解压缩文件"})
        KeyArray.push({Key:"fr", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1002, Comment: "文件操作_重命名文件(Shift+F6)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1007, Comment: "文件操作_重命名光标下的文件"})
        KeyArray.push({Key:"fqx", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1005, Comment: "文件操作_移动文件(F6)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1003, Comment: "文件操作_打开“属性”对话框"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1008, Comment: "文件操作_显示“共享”超级按钮"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1004, Comment: "文件操作_创建快捷方式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 1001, Comment: "文件操作_模拟按下 Enter 键"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 2800, Comment: "文件操作_以其他用户身份运行光标下的程序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 560, Comment: "文件操作_拆分文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 561, Comment: "文件操作_合并文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 562, Comment: "文件操作_文件编码(MIME、UUE、XXE)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 563, Comment: "文件操作_文件解码(MIME、UUE、XXE、BinHex)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 564, Comment: "文件操作_创建校验和文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 565, Comment: "文件操作_验证校验"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件操作", Func: "TC_SendPos", Param: 502, Comment: "文件操作_更改属性"})
    ; 配置==========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 490, Comment: "配置_布局(第一页)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 476, Comment: "配置_布局"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 486, Comment: "配置_显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 477, Comment: "配置_图标"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 492, Comment: "配置_字体"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 494, Comment: "配置_颜色"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 497, Comment: "配置_列宽/格式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 488, Comment: "配置_文件夹标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 483, Comment: "配置_自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 2920, Comment: "配置_更改当前自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 2939, Comment: "配置_查看模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 2940, Comment: "配置_自动切换查看模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 499, Comment: "配置_语言"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 516, Comment: "配置_操作方式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 496, Comment: "配置_查看/编辑"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 3036, Comment: "配置_查看器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 487, Comment: "配置_复制删除"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 478, Comment: "配置_刷新"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 479, Comment: "配置_快速搜索"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 489, Comment: "配置_FTP"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 484, Comment: "配置_插件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 482, Comment: "配置_缩略图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 481, Comment: "配置_日志文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 480, Comment: "配置_忽略列耒"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 475, Comment: "配置_文件夹历史记录"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 491, Comment: "配置_压缩程序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 485, Comment: "配置_ZIP压缩程序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 474, Comment: "配置_7Zip压缩程序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 495, Comment: "配置_其他"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 493, Comment: "配置_保存窗口位置"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 498, Comment: "配置_工具栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 583, Comment: "配置_垂直工具栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 580, Comment: "配置_保存设置"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 581, Comment: "配置_直接修改设置文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 582, Comment: "配置_保存文件夹历史记录"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "配置", Func: "TC_SendPos", Param: 700, Comment: "配置_更改开始菜单"})
    ; 网络==========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 512, Comment: "网络_映射网络驱动器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 513, Comment: "网络_断开网络驱动器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 514, Comment: "网络_共享当前文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 515, Comment: "网络_取消文件夹共享"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 2204, Comment: "网络_显示系统共享文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "网络", Func: "TC_SendPos", Param: 2203, Comment: "网络_显示本地文件的远程用户"})
    ; 其他==========================================================
        ;以下内置命令--------------
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 503, Comment: "其他_计算占用空间"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 505, Comment: "其他_磁盘卷标"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 510, Comment: "其他_打开“属性”对话框"})
        KeyArray.push({Key:"Vc", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 511, Comment: "其他_打开命令提示符"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 533, Comment: "其他_比较文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 536, Comment: "其他_比较文件夹(标记另一侧缺少的子文件夹)"})
        KeyArray.push({Key:"Vm", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2500, Comment: "其他_显示上下文菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 3020, Comment: "其他_显示驱动器上下文菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2927, Comment: "其他_显示内部关联的上下文菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2928, Comment: "其他_显示光标下文件的内部关联上下文菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2930, Comment: "其他_显示媒体中心遥控器调出的上下文菜单"})
        KeyArray.push({Key:"*ft", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2600, Comment: "其他_两侧面板同步切换文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2700, Comment: "其他_编辑文件注释"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4001, Comment: "其他_焦点移动到左侧面板"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4002, Comment: "其他_焦点移动到右侧面板"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4005, Comment: "其他_焦点移动到源面板"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4006, Comment: "其他_焦点移动到目标面板"})
        KeyArray.push({Key:"*:", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4003, Comment: "其他_焦点移动到命令行"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4004, Comment: "其他_焦点移动到工具栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4007, Comment: "其他_焦点移动到左侧面板导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4008, Comment: "其他_焦点移动到右侧面板导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4009, Comment: "其他_焦点移动到源面板导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4010, Comment: "其他_焦点移动到目标面板导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4011, Comment: "其他_焦点移动到主菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 4012, Comment: "其他_焦点移动到垂直工具栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2014, Comment: "其他_计算所有子文件夹占用的空间"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2913, Comment: "其他_卸载所有插件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 534, Comment: "其他_标记较新的文件，隐藏相同的文件"})
        KeyArray.push({Key:"ge", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 531, Comment: "其他_交换面板"})
        KeyArray.push({Key:"gs", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 532, Comment: "其他_目标=来源"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2918, Comment: "其他_重新加载选定的缩略图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2945, Comment: "其他_重新加载工具栏和主菜单中的图标"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "其他", Func: "TC_SendPos", Param: 2958, Comment: "其他_重新加载所有文件的图标"})
    ; 并行端口======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "并行端口", Func: "TC_SendPos", Param: 2300, Comment: "并行端口_直接电缆连接"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "并行端口", Func: "TC_SendPos", Param: 2301, Comment: "并行端口_加载并行端口驱动程序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "并行端口", Func: "TC_SendPos", Param: 2302, Comment: "并行端口_卸载并行端口驱动程序"})
    ; 打印==========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "打印", Func: "TC_SendPos", Param: 2027, Comment: "打印_打印文件列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "打印", Func: "TC_SendPos", Param: 2028, Comment: "打印_打印文件列表(含子文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "打印", Func: "TC_SendPos", Param: 504, Comment: "打印_打印文件内容"})
    ; 标记==========================================================
        KeyArray.push({Key:"W", Mode: "VIM模式", Group: "标记", Func: "SendKeyInput", Param: "+{Up}", Comment: "VIM_向上选择"})
        KeyArray.push({Key:"S", Mode: "VIM模式", Group: "标记", Func: "SendKeyInput", Param: "+{Down}", Comment: "VIM_向下选择"})
        ;以下内置命令--------------
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 521, Comment: "标记_选择一组"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 546, Comment: "标记_选择一组：预先加载光标下文件的扩展名"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3311, Comment: "标记_选择一组：文件+文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3312, Comment: "标记_选择一组：文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3313, Comment: "标记_选择一组：文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 522, Comment: "标记_不选一组"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 547, Comment: "标记_不选一组：预先加载光标下文件的扩展名"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3314, Comment: "标记_不选一组：文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3315, Comment: "标记_不选一组：文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3316, Comment: "标记_不选一组：文件或文件+文件夹(取决于配置)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 523, Comment: "标记_全部选择：文件或文件+文件夹(取决于配置)"})
        KeyArray.push({Key:"A", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3301, Comment: "标记_全部选择：文件+文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3302, Comment: "标记_全部选择：文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3303, Comment: "标记_全部选择：文件夹"})
        KeyArray.push({Key:"b", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 524, Comment: "标记_取消全选：文件+文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3304, Comment: "标记_取消全选：文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3305, Comment: "标记_取消全选：文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3306, Comment: "标记_取消全选：文件或文件+文件夹(取决于配置)"})
        KeyArray.push({Key:"BB", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 525, Comment: "标记_反向选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3321, Comment: "标记_反向选择：文件+文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3322, Comment: "标记_反向选择：文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 3323, Comment: "标记_反向选择：文件夹"})
        KeyArray.push({Key:"Be", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 527, Comment: "标记_选择所有扩展名相同的项目"})
        KeyArray.push({Key:"BE", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 528, Comment: "标记_不选所有扩展名相同的项目"})
        KeyArray.push({Key:"Bn", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 541, Comment: "标记_选择所有名称相同的项目"})
        KeyArray.push({Key:"BN", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 542, Comment: "标记_不选所有名称相同的项目"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 543, Comment: "标记_选择所有名称+扩展名相同的项目"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 544, Comment: "标记_不选所有名称+扩展名相同的项目"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 537, Comment: "标记_选择所有路径相同的文件(平面视图/搜索文件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 538, Comment: "标记_不选所有路径相同的文件(平面视图/搜索文件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 529, Comment: "标记_还原选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 530, Comment: "标记_保存选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2031, Comment: "标记_导出选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2041, Comment: "标记_导出选择(ANSI)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2042, Comment: "标记_导出选择(Unicode)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2039, Comment: "标记_导出详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2043, Comment: "标记_导出详细信息(ANSI)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2044, Comment: "标记_导出详细信息(Unicode)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2093, Comment: "标记_导出详细信息(含标题)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2094, Comment: "标记_导出详细信息(含标题)(ANSI)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2095, Comment: "标记_导出详细信息(含标题)(Unicode)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2032, Comment: "标记_从文件导入选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2033, Comment: "标记_从剪贴板导入选择"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2936, Comment: "标记_选择文件并向下移动光标"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2937, Comment: "标记_取消选择并向下移动光标"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "标记", Func: "TC_SendPos", Param: 2938, Comment: "标记_反向选择并向下移动光标"})
    ; 安全==========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "安全", Func: "TC_SendPos", Param: 2200, Comment: "安全_设置权限(NTFS)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "安全", Func: "TC_SendPos", Param: 2201, Comment: "安全_审核文件(NTFS)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "安全", Func: "TC_SendPos", Param: 2202, Comment: "安全_获取所有权(NTFS)"})
    ; 剪贴板========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_CopyNameOnly", Param: "", Comment: "仅复制文件名，不含后缀"})
        ;以下内置命令--------------
        KeyArray.push({Key:"fz", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2007, Comment: "剪贴板_将所选文件剪切到剪贴板"})
        KeyArray.push({Key:"fz", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2007, Comment: "剪贴板_将所选文件剪切到剪贴板"})
        KeyArray.push({Key:"ff", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2008, Comment: "剪贴板_将所选文件复制到剪贴板"})
        KeyArray.push({Key:"fv", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2009, Comment: "剪贴板_将文件粘贴到当前文件夹"})
        KeyArray.push({Key:"yn", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2017, Comment: "剪贴板_复制所选项目的名称"})
        KeyArray.push({Key:"yy", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2018, Comment: "剪贴板_复制所选项目的完整路径及名称"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2021, Comment: "剪贴板_复制所选项目的网络路径及名称"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 3035, Comment: "剪贴板_复制各个文件的路径名称"})
        KeyArray.push({Key:"yh", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2029, Comment: "剪贴板_复制源路径"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2030, Comment: "剪贴板_复制目标路径"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2036, Comment: "剪贴板_复制所选项目的详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2037, Comment: "剪贴板_复制所选项目的完整路径及详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2038, Comment: "剪贴板_复制所选项目的网铬路径及详细信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2090, Comment: "剪贴板_复制所选项目的详细信息含标题"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2091, Comment: "剪贴板_复制所选项目的完整路径及详细信息(含标题)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "剪贴板", Func: "TC_SendPos", Param: 2092, Comment: "剪贴板_复制所选项目的网铬路径及详细信息(含标题)"})
    ; FTP===========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 550, Comment: "FTP_连接到 FTP"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 551, Comment: "FTP_新建 FTP 连接"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 552, Comment: "FTP_断开 FTP 连接"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 553, Comment: "FTP_显示隐藏的 FTP 文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 554, Comment: "FTP_中止当前的 FTP 命令"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 555, Comment: "FTP_续传下载"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 556, Comment: "FTP_选择传输模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 557, Comment: "FTP_将所选文件添加到下载列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "FTP", Func: "TC_SendPos", Param: 558, Comment: "FTP_按下载列表下载"})
    ; 导航==========================================================
        KeyArray.push({Key:"u", Mode: "VIM模式", Group: "导航", Func: "TC_GoToParent", Param: "", Comment: "VIM_返回到上层文件夹"})
        KeyArray.push({Key:"*gl", Mode: "VIM模式", Group: "导航", Func: "TC_OtherPanel_GotoNextDir", Param: "", Comment: "VIM_【另一侧】下一个文件夹"})
        KeyArray.push({Key:"*gh", Mode: "VIM模式", Group: "导航", Func: "TC_OtherPanel_GotoPreviousDir", Param: "", Comment: "VIM_【另一侧】上一个文件夹"})
        ;以下内置命令--------------
        KeyArray.push({Key:"H", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 570, Comment: "导航_上一个文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 571, Comment: "导航_下一个文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 572, Comment: "导航_文件夹历史记录"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 575, Comment: "导航_文件夹历史记录(未精简)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 573, Comment: "导航_上一个本地文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 574, Comment: "导航_下一个本地文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 526, Comment: "导航_显示常用文件夹菜单(Ctrl+D)"})
        KeyArray.push({Key:"U", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2001, Comment: "导航_根文件夹"})
        KeyArray.push({Key:"q", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2002, Comment: "导航_上一级文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2003, Comment: "导航_打开光标下的文件夹或压缩包"})
        KeyArray.push({Key:"D", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2121, Comment: "导航_桌面文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2122, Comment: "导航_此电脑"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2123, Comment: "导航_控制面板"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2124, Comment: "导航_字体文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2125, Comment: "导航_网络"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2126, Comment: "导航_打印机文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2127, Comment: "导航_回收站"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 500, Comment: "导航_切换文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2024, Comment: "导航_在左侧面板打开光标下的文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2025, Comment: "导航_在右侧面板打开光标下的文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2912, Comment: "导航_编辑源面板的路径"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2049, Comment: "导航_光标移动到第一个文件或文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2050, Comment: "导航_光标移动到第一个文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2051, Comment: "导航_下一个驱动器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2052, Comment: "导航_上一个驱动器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2053, Comment: "导航_下一个选中的文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2054, Comment: "导航_上一个选中的文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2055, Comment: "导航_下一个文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2056, Comment: "导航_上一个文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2057, Comment: "导航_最后一个文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2061, Comment: "导航_切换到驱动器A"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2062, Comment: "导航_切换到驱动器B"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2063, Comment: "导航_切换到驱动器C"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2064, Comment: "导航_切换到驱动器D"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2065, Comment: "导航_切换到驱动器E"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2066, Comment: "导航_切换到驱动器F"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2067, Comment: "导航_切换到驱动器G"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2068, Comment: "导航_切换到驱动器H"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2069, Comment: "导航_切换到驱动器I"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2070, Comment: "导航_切换到驱动器J"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2071, Comment: "导航_切换到驱动器K"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2072, Comment: "导航_切换到驱动器L"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2073, Comment: "导航_切换到驱动器M"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2074, Comment: "导航_切换到驱动器N"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2075, Comment: "导航_切换到驱动器O"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2076, Comment: "导航_切换到驱动器P"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2077, Comment: "导航_切换到驱动器Q"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2078, Comment: "导航_切换到驱动器R"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2079, Comment: "导航_切换到驱动器S"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2080, Comment: "导航_切换到驱动器T"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2081, Comment: "导航_切换到驱动器U"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2082, Comment: "导航_切换到驱动器V"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2083, Comment: "导航_切换到驱动器W"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2084, Comment: "导航_切换到驱动器X"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2085, Comment: "导航_切换到驱动器Y"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 2086, Comment: "导航_切换到驱动器Z"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "导航", Func: "TC_SendPos", Param: 3025, Comment: "导航_按序号切换驱动器"})
    ; 帮助==========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 610, Comment: "帮助_帮助索引"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 620, Comment: "帮助_快捷鍵"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 630, Comment: "帮助_注册信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 640, Comment: "帮助_访问Total Commander网站"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 650, Comment: "帮助_检查更新"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "帮助", Func: "TC_SendPos", Param: 690, Comment: "帮助_关于Total Commander"})
    ; 窗口==========================================================
        KeyArray.push({Key:"Zz", Mode: "VIM模式", Group: "窗口", Func: "TC_Toggle_50_100Percent", Param: "", Comment: "VIM_还原当前窗口显示状态50-100"})
        KeyArray.push({Key:"*zh", Mode: "VIM模式", Group: "视图", Func: "TC_Toggle_50_100Percent_V", Param: "", Comment: "VIM_切换当前(纵向)窗口显示状态50-100"})
        KeyArray.push({Key:"ZZ", Mode: "VIM模式", Group: "窗口", Func: "TC_Toggle_AutoPercent", Param: "", Comment: "VIM_启用/关闭：自动扩大本侧窗口"})
        KeyArray.push({Key:"Za", Mode: "VIM模式", Group: "窗口", Func: "TC_WinMaxLR", Param: 1, Comment: "VIM_最大化左侧/上部窗口"})
        KeyArray.push({Key:"Zd", Mode: "VIM模式", Group: "窗口", Func: "TC_WinMaxLR", Param: 0, Comment: "VIM_最大化右侧/下部窗口"})
        KeyArray.push({Key:"Zt", Mode: "VIM模式", Group: "窗口", Func: "TC_AlwayOnTop", Param: "", Comment: "VIM_设置TC顶置"})
        ;以下内置命令--------------
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "窗口", Func: "TC_SendPos", Param: 24340, Comment: "窗口_退出Total Commander"})
        KeyArray.push({Key:"Zn", Mode: "VIM模式", Group: "窗口", Func: "TC_SendPos", Param: 2000, Comment: "窗口_最小化Total Commander"})
        KeyArray.push({Key:"Zm", Mode: "VIM模式", Group: "窗口", Func: "TC_SendPos", Param: 2015, Comment: "窗口_最大化Total Commander"})
        KeyArray.push({Key:"Zr", Mode: "VIM模式", Group: "窗口", Func: "TC_SendPos", Param: 2016, Comment: "窗口_还原到正常大小"})
    ; 命令行========================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 2004, Comment: "命令行_清除命令行"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 2005, Comment: "命令行_下一个命令"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 2006, Comment: "命令行_上一个命令"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 2019, Comment: "命令行_将路径复制到命令行"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 3021, Comment: "命令行_将文件名复制到命令行"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 3022, Comment: "命令行_将路径及文件名复制到命令行"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "命令行", Func: "TC_SendPos", Param: 3023, Comment: "命令行_开启/关闭：命令行历史记录"})
    ; 工具==========================================================
        KeyArray.push({Key:"R", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2400, Comment: "工具_批量重命名工具"})
        KeyArray.push({Key:"*~", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 506, Comment: "工具_系统信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 559, Comment: "工具_后台传输管理器"})
        KeyArray.push({Key:"F", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 501, Comment: "工具_搜索文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 517, Comment: "工具_搜索文件(光标下的文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 545, Comment: "工具_搜索文件(单独进程)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2020, Comment: "工具_同步文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 507, Comment: "工具_文件关联"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 519, Comment: "工具_内部关联"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2022, Comment: "工具_比较文件内容"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2040, Comment: "工具_使用内置的比较工具"})
        KeyArray.push({Key:"Ve", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2924, Comment: "工具_浏览内部命令"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2941, Comment: "工具_以独立窗口打开快速查看"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2942, Comment: "工具_以独立窗口打开快速查看(不使用插件)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "工具", Func: "TC_SendPos", Param: 2946, Comment: "工具_快速查看重新加载文件"})
    ; 视图==========================================================
        KeyArray.push({Key:"v", Mode: "VIM模式", Group: "视图", Func: "TC_SrcViewChange", Param: "", Comment: "VIM_切换视图布局"})
        KeyArray.push({Key:"*Vm", Mode: "VIM模式", Group: "视图", Func: "TC_ToggleMenu", Param: "", Comment: "VIM_显示/隐藏_菜单栏"})
        
        ;以下内置命令--------------
        KeyArray.push({Key:"*Vb", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2901, Comment: "视图_显示/隐藏：工具栏"})
        KeyArray.push({Key:"*Vd", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2944, Comment: "视图_显示/隐藏：垂直工具栏"})
        KeyArray.push({Key:"*Vo", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2902, Comment: "视图_显示/隐藏：驱动器按钮栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2903, Comment: "视图_显示/隐藏：两个驱动器按钮栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2904, Comment: "视图_按钮：扁平/普通模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2905, Comment: "视图_界面：扁平/普通模式"})
        KeyArray.push({Key:"*Vr", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2906, Comment: "视图_显示/隐藏：驱动器列表栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2907, Comment: "视图_显示/隐藏：路径栏"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2926, Comment: "视图_显示//隐藏：痕迹导航模式"})
        KeyArray.push({Key:"*Vt", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2908, Comment: "视图_显示/隐藏：列标题"})
        KeyArray.push({Key:"*Vs", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2909, Comment: "视图_显示/隐藏：状态栏"})
        KeyArray.push({Key:"*Vn", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2910, Comment: "视图_显示/隐藏：命令行"})
        KeyArray.push({Key:"*Vf", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2911, Comment: "视图_显示/隐藏：功能键按钮"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2914, Comment: "视图_显示文件提示信息"})
        KeyArray.push({Key:"/", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2915, Comment: "视图_显示快速搜索框"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3018, Comment: "视图_显示快速搜索框(关闭快速过滤)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3019, Comment: "视图_显示快速搜索框(开启快速过滤)"})
        KeyArray.push({Key:"Zv", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 305, Comment: "视图_水平面板模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2010, Comment: "视图_开启/关闭：长文件名显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 540, Comment: "视图_刷新源面板"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2023, Comment: "视图_隐藏未选中的文件"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2011, Comment: "视图_开启/关闭：隐藏文件/系统文件显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3013, Comment: "视图_开启/关闭：隐藏文件显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3014, Comment: "视图_开启/关闭：系统文件显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2013, Comment: "视图_开启/关闭：8.3文件名小写显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2012, Comment: "视图_开启/关闭：文件夹按名称排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2026, Comment: "视图_平面视图(所有文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2046, Comment: "视图_平面视图(仅限选定的文件和文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 909, Comment: "视图_窗口分割比例50%"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 910, Comment: "视图_窗口分割比例100%"})
        KeyArray.push({Key:"*Vw", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2916, Comment: "视图_显示/隐藏：文件夹标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2923, Comment: "视图_显示/隐藏：P主题背景"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2917, Comment: "视图_开启/关闭：覆盖图标显示"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2919, Comment: "视图_显示/隐藏：文件夹历史记录和常用文件夹按扭"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2921, Comment: "视图_开启/关闭：文件夹自动刷新"})
        KeyArray.push({Key:"*Vh", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2922, Comment: "视图_开启/关闭：忽略列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2925, Comment: "视图_开启/关闭：System32重定向到SysW0W64"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3200, Comment: "视图_关闭导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3201, Comment: "视图_一个导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3202, Comment: "视图_两个导航窗格"})
        KeyArray.push({Key:"*-", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3203, Comment: "视图_切换导航窗格状态"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3204, Comment: "视图_开启/关闭：一个导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 3205, Comment: "视图_开启/关闭：两个导航窗格"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2948, Comment: "视图_显示文件名编码菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2950, Comment: "视图_开启/关闭：深色模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2951, Comment: "视图_开启深色模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2952, Comment: "视图_关闭深色模式"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2957, Comment: "视图_开启/关闭：颜色筛选器"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2959, Comment: "视图_开启/关闭：文件提示信息"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2953, Comment: "视图_放大缩略图(最大200%)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "视图", Func: "TC_SendPos", Param: 2954, Comment: "视图_缩小缩略图(最小10%)"})
    ; 用户命令=======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 701, Comment: "用户命令_启动开始菜单第1项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 702, Comment: "用户命令_启动开始菜单第2项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 703, Comment: "用户命令_启动开始菜单第3项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 704, Comment: "用户命令_启动开始菜单第4项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 705, Comment: "用户命令_启动开始菜单第5项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 706, Comment: "用户命令_启动开始菜单第6项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 707, Comment: "用户命令_启动开始菜单第7项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 708, Comment: "用户命令_启动开始菜单第8项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 709, Comment: "用户命令_启动开始菜单第9项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 710, Comment: "用户命令_启动开始菜单第10项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: "…", Comment: "用户命令_启动开始菜单第...项"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "用户命令", Func: "TC_SendPos", Param: 899, Comment: "用户命令_启动开始菜单第899项"})
    ; 文件夹标签=====================================================
        KeyArray.push({Key:"ga", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_CloseAllTabs", Param: "", Comment: "标签_关闭所有标签"})
        KeyArray.push({Key:"gr", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_ReOpenTab", Param: "", Comment: "VIM_重新打开之前关闭的标签页"})
        KeyArray.push({Key:"g0", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_GoLastTab", Param: "", Comment: "VIM_切换到最后一个标签"})
        ;以下内置命令--------------
        KeyArray.push({Key:"t", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3001, Comment: "文件夹标签_新建标签"})
        KeyArray.push({Key:"T", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3002, Comment: "文件夹标签_新建标签(后台显示)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3027, Comment: "文件夹标签_新建标签(另一侧面板)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3028, Comment: "文件夹标签_新建标签(另一侧面板后台显示)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3003, Comment: "文件夹标签_在新标签打开光标下的文件夹(当前面板)"})
        KeyArray.push({Key:"gb", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3004, Comment: "文件夹标签_在新标签打开光标下的文件夹(另一侧面板)"})
        KeyArray.push({Key:"d", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3005, Comment: "文件夹标签_下一个标签(Cltr+Tab)"})
        KeyArray.push({Key:"a", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3006, Comment: "文件夹标签_上一个标签(Cltr+Shift+Tab)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3015, Comment: "文件夹标签_向左移动当前标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3016, Comment: "文件夹标签_向右移动当前标签"})
        KeyArray.push({Key:"x", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3007, Comment: "文件夹标签_关闭标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3008, Comment: "文件夹标签_关闭所有标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3017, Comment: "文件夹标签_关闭重复的标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3009, Comment: "文件夹标签_显示文件夹标签菜单"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3024, Comment: "文件夹标签_重命名当前标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3010, Comment: "文件夹标签_开启/关闭：标签锁定"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3012, Comment: "文件夹标签_开启/关闭：标签锁定(可切换文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3029, Comment: "文件夹标签_解锁标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3030, Comment: "文件夹标签_锁定标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3031, Comment: "文件夹标签_锁定标签(可切换文件夹)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3032, Comment: "文件夹标签_解锁所有标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3033, Comment: "文件夹标签_锁定所有标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3034, Comment: "文件夹标签_锁定所有标签(可切换文件夹)"})
        KeyArray.push({Key:"gw", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 535, Comment: "文件夹标签_交换所有标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 3011, Comment: "文件夹标签_回到锁定标签的原始文件夹"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5515, Comment: "文件夹标签_源面板：显示标签列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5516, Comment: "文件夹标签_目标面板：显示标签列耒"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5517, Comment: "文件夹标签_左侧面板：显示标签列表"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5518, Comment: "文件夹标签_右侧面板：显示标签列表"})
        KeyArray.push({Key:"g1", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5001, Comment: "文件夹标签_源面板：切换到第1个标签"})
        KeyArray.push({Key:"g2", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5002, Comment: "文件夹标签_源面板：切换到第2个标签"})
        KeyArray.push({Key:"g3", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5003, Comment: "文件夹标签_源面板：切换到第3个标签"})
        KeyArray.push({Key:"g4", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5004, Comment: "文件夹标签_源面板：切换到第4个标签"})
        KeyArray.push({Key:"g5", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5005, Comment: "文件夹标签_源面板：切换到第5个标签"})
        KeyArray.push({Key:"g6", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5006, Comment: "文件夹标签_源面板：切换到第6个标签"})
        KeyArray.push({Key:"g7", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5007, Comment: "文件夹标签_源面板：切换到第7个标签"})
        KeyArray.push({Key:"g8", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5008, Comment: "文件夹标签_源面板：切换到第8个标签"})
        KeyArray.push({Key:"g9", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5009, Comment: "文件夹标签_源面板：切换到第9个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5010, Comment: "文件夹标签_源面板：切换到第10个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: "50..", Comment: "文件夹标签_源面板：切换到第..个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5099, Comment: "文件夹标签_源面板：切换到第99个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5101, Comment: "文件夹标签_目标面板：切换到第1个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5102, Comment: "文件夹标签_目标面板：切换到第2个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5103, Comment: "文件夹标签_目标面板：切换到第3个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5104, Comment: "文件夹标签_目标面板：切换到第4个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5105, Comment: "文件夹标签_目标面板：切换到第5个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5106, Comment: "文件夹标签_目标面板：切换到第6个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5107, Comment: "文件夹标签_目标面板：切换到第7个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5108, Comment: "文件夹标签_目标面板：切换到第8个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5109, Comment: "文件夹标签_目标面板：切换到第9个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5110, Comment: "文件夹标签_目标面板：切换到第10个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: "51..", Comment: "文件夹标签_目标面板：切换到第..个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5199, Comment: "文件夹标签_目标面板：切换到第99个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5201, Comment: "文件夹标签_左侧面板：切换到第1个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5202, Comment: "文件夹标签_左侧面板：切换到第2个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5203, Comment: "文件夹标签_左侧面板：切换到第3个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5204, Comment: "文件夹标签_左侧面板：切换到第4个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5205, Comment: "文件夹标签_左侧面板：切换到第5个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5206, Comment: "文件夹标签_左侧面板：切换到第6个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5207, Comment: "文件夹标签_左侧面板：切换到第7个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5208, Comment: "文件夹标签_左侧面板：切换到第8个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5209, Comment: "文件夹标签_左侧面板：切换到第9个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5210, Comment: "文件夹标签_左侧面板：切换到第10个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: "52..", Comment: "文件夹标签_左侧面板：切换到第..个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5299, Comment: "文件夹标签_左侧面板：切换到第99个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5301, Comment: "文件夹标签_右侧面板：切换到第1个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5302, Comment: "文件夹标签_右侧面板：切换到第2个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5303, Comment: "文件夹标签_右侧面板：切换到第3个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5304, Comment: "文件夹标签_右侧面板：切换到第4个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5305, Comment: "文件夹标签_右侧面板：切换到第5个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5306, Comment: "文件夹标签_右侧面板：切换到第6个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5307, Comment: "文件夹标签_右侧面板：切换到第7个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5308, Comment: "文件夹标签_右侧面板：切换到第8个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5309, Comment: "文件夹标签_右侧面板：切换到第9个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5310, Comment: "文件夹标签_右侧面板：切换到第10个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: "53..", Comment: "文件夹标签_右侧面板：切换到第..个标签"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "文件夹标签", Func: "TC_SendPos", Param: 5399, Comment: "文件夹标签_右侧面板：切换到第99个标签"})
    ; 排序===========================================================
        KeyArray.push({Key:"*s1", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6001, Comment: "排序_源面板：按第1列排序"})
        KeyArray.push({Key:"*s2", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6002, Comment: "排序_源面板：按第2列排序"})
        KeyArray.push({Key:"*s3", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6003, Comment: "排序_源面板：按第3列排序"})
        KeyArray.push({Key:"*s4", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6004, Comment: "排序_源面板：按第4列排序"})
        KeyArray.push({Key:"*s5", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6005, Comment: "排序_源面板：按第5列排序"})
        KeyArray.push({Key:"*s6", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6006, Comment: "排序_源面板：按第6列排序"})
        KeyArray.push({Key:"*s7", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6007, Comment: "排序_源面板：按第7列排序"})
        KeyArray.push({Key:"*s8", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6008, Comment: "排序_源面板：按第8列排序"})
        KeyArray.push({Key:"*s9", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6009, Comment: "排序_源面板：按第9列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6010, Comment: "排序_源面板：按第10列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: "60..", Comment: "排序_源面板：按第..列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6099, Comment: "排序_源面板：按第99列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6101, Comment: "排序_目标面板：按第1列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6102, Comment: "排序_目标面板：按第2列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6103, Comment: "排序_目标面板：按第3列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6104, Comment: "排序_目标面板：按第4列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6105, Comment: "排序_目标面板：按第5列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6106, Comment: "排序_目标面板：按第6列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6107, Comment: "排序_目标面板：按第7列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6108, Comment: "排序_目标面板：按第8列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6109, Comment: "排序_目标面板：按第9列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6110, Comment: "排序_目标面板：按第10列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: "61..", Comment: "排序_目标面板：按第..列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6199, Comment: "排序_目标面板：按第99列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6201, Comment: "排序_左侧面板：按第1列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6202, Comment: "排序_左侧面板：按第2列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6203, Comment: "排序_左侧面板：按第3列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6204, Comment: "排序_左侧面板：按第4列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6205, Comment: "排序_左侧面板：按第5列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6206, Comment: "排序_左侧面板：按第6列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6207, Comment: "排序_左侧面板：按第7列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6208, Comment: "排序_左侧面板：按第8列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6209, Comment: "排序_左侧面板：按第9列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6210, Comment: "排序_左侧面板：按第10列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: "62..", Comment: "排序_左侧面板：按第..列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6299, Comment: "排序_左侧面板：按第99列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6301, Comment: "排序_右侧面板：按第1列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6302, Comment: "排序_右侧面板：按第2列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6303, Comment: "排序_右侧面板：按第3列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6304, Comment: "排序_右侧面板：按第4列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6305, Comment: "排序_右侧面板：按第5列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6306, Comment: "排序_右侧面板：按第6列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6307, Comment: "排序_右侧面板：按第7列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6308, Comment: "排序_右侧面板：按第8列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6309, Comment: "排序_右侧面板：按第9列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6310, Comment: "排序_右侧面板：按第10列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: "63..", Comment: "排序_右侧面板：按第..列排序"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "排序", Func: "TC_SendPos", Param: 6399, Comment: "排序_右侧面板：按第99列排序"})
    ; 自定义列=======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 271, Comment: "自定义列_源面板：切换到自定义视图1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 272, Comment: "自定义列_源面板：切换到自定义视图2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 273, Comment: "自定义列_源面板：切换到自定义视图3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 274, Comment: "自定义列_源面板：切换到自定义视图4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 275, Comment: "自定义列_源面板：切换到自定义视图5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 276, Comment: "自定义列_源面板：切换到自定义视图6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 277, Comment: "自定义列_源面板：切换到自定义视图7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 278, Comment: "自定义列_源面板：切换到自定义视图8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 279, Comment: "自定义列_源面板：切换到自定义视图9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 280, Comment: "自定义列_源面板：切换到自定义视图10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: "2..", Comment: "自定义列_源面板：切换到自定义视图.."})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 299, Comment: "自定义列_源面板：切换到自定义视图29"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 421, Comment: "自定义列_目标面板：切换到自定义视图1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 422, Comment: "自定义列_目标面板：切换到自定义视图2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 423, Comment: "自定义列_目标面板：切换到自定义视图3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 424, Comment: "自定义列_目标面板：切换到自定义视图4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 425, Comment: "自定义列_目标面板：切换到自定义视图5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 426, Comment: "自定义列_目标面板：切换到自定义视图6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 427, Comment: "自定义列_目标面板：切换到自定义视图7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 428, Comment: "自定义列_目标面板：切换到自定义视图8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 429, Comment: "自定义列_目标面板：切换到自定义视图9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 430, Comment: "自定义列_目标面板：切换到自定义视图10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: "43..", Comment: "自定义列_目标面板：切换到自定义视图.."})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 449, Comment: "自定义列_目标面板：切换到自定义视图29"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 71, Comment: "自定义列_左侧面板：切换到自定义视图1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 72, Comment: "自定义列_左侧面板：切换到自定义视图2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 73, Comment: "自定义列_左侧面板：切换到自定义视图3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 74, Comment: "自定义列_左侧面板：切换到自定义视图4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 75, Comment: "自定义列_左侧面板：切换到自定义视图5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 76, Comment: "自定义列_左侧面板：切换到自定义视图6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 77, Comment: "自定义列_左侧面板：切换到自定义视图7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 78, Comment: "自定义列_左侧面板：切换到自定义视图8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 79, Comment: "自定义列_左侧面板：切换到自定义视图9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 80, Comment: "自定义列_左侧面板：切换到自定义视图10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: "..", Comment: "自定义列_左侧面板：切换到自定义视图.."})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 99, Comment: "自定义列_左侧面板：切换到自定义视图29"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 171, Comment: "自定义列_右侧面板：切换到自定义视图1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 172, Comment: "自定义列_右侧面板：切换到自定义视图2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 173, Comment: "自定义列_右侧面板：切换到自定义视图3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 174, Comment: "自定义列_右侧面板：切换到自定义视图4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 175, Comment: "自定义列_右侧面板：切换到自定义视图5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 176, Comment: "自定义列_右侧面板：切换到自定义视图6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 177, Comment: "自定义列_右侧面板：切换到自定义视图7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 178, Comment: "自定义列_右侧面板：切换到自定义视图8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 179, Comment: "自定义列_右侧面板：切换到自定义视图9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 180, Comment: "自定义列_右侧面板：切换到自定义视图10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: "1..", Comment: "自定义列_右侧面板：切换到自定义视图.."})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 199, Comment: "自定义列_右侧面板：切换到自定义视图29"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5501, Comment: "自定义列_源面板：下一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5502, Comment: "自定义列_源面板：上一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5503, Comment: "自定义列_目标面板：下一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5504, Comment: "自定义列_目标面板：上一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5505, Comment: "自定义列_左侧面板：下一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5506, Comment: "自定义列_左侧面板：上一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5507, Comment: "自定义列_右侧面板：下一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5508, Comment: "自定义列_右侧面板：上一个自定义视图"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5512, Comment: "自定义列_所有文件都加载自定义字段"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5513, Comment: "自定义列_仅所选文件加载自定义字段"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5514, Comment: "自定义列_停止后台加载自定义字段"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5510, Comment: "自定义列_设置左侧面板自定义视图(lparam=:视图号)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "自定义列", Func: "TC_SendPos", Param: 5511, Comment: "自定义列_设置右侧面板自定义视图(lparam=:视图号)"})
    ; 查看模式=======================================================
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 2947, Comment: "查看模式_开启/关闭：查看模式自动切换"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8500, Comment: "查看模式_源面板：切换到默认查看模式(没有颜色或图标)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8501, Comment: "查看模式_源面板：切换到查看模式1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8502, Comment: "查看模式_源面板：切换到查看模式2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8503, Comment: "查看模式_源面板：切换到查看模式3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8504, Comment: "查看模式_源面板：切换到查看模式4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8505, Comment: "查看模式_源面板：切换到查看模式5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8506, Comment: "查看模式_源面板：切换到查看模式6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8507, Comment: "查看模式_源面板：切换到查看模式7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8508, Comment: "查看模式_源面板：切换到查看模式8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8509, Comment: "查看模式_源面板：切换到查看模式9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8510, Comment: "查看模式_源面板：切换到查看模式10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: "85..", Comment: "查看模式_源面板：切换到查看模式…"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8749, Comment: "查看模式_源面板：切换到查看模式249"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8750, Comment: "查看模式_目标面板：切换到默认查看模式(没有颜色或图标)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8751, Comment: "查看模式_目标面板：切换到查看模式10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: "87..", Comment: "查看模式_目标面板：切换到查看模式…"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8999, Comment: "查看模式_目标面板：切换到查看模式249"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8000, Comment: "查看模式_左侧面板：切换到默认查看模式(没有颜色或图标)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8001, Comment: "查看模式_左侧面板：切换到查看模式1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8002, Comment: "查看模式_左侧面板：切换到查看模式2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8003, Comment: "查看模式_左侧面板：切换到查看模式3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8004, Comment: "查看模式_左侧面板：切换到查看模式4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8005, Comment: "查看模式_左侧面板：切换到查看模式5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8006, Comment: "查看模式_左侧面板：切换到查看模式6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8007, Comment: "查看模式_左侧面板：切换到查看模式7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8008, Comment: "查看模式_左侧面板：切换到查看模式8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8009, Comment: "查看模式_左侧面板：切换到查看模式9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8010, Comment: "查看模式_左侧面板：切换到查看模式10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: "80..", Comment: "查看模式_左侧面板：切换到查看模式…"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8249, Comment: "查看模式_左侧面板：切换到查看模式249"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8250, Comment: "查看模式_右侧面板：切换到默认查看模式(没有颜色或图标)"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8251, Comment: "查看模式_右侧面板：切换到查看模式1"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8252, Comment: "查看模式_右侧面板：切换到查看模式2"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8253, Comment: "查看模式_右侧面板：切换到查看模式3"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8254, Comment: "查看模式_右侧面板：切换到查看模式4"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8255, Comment: "查看模式_右侧面板：切换到查看模式5"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8256, Comment: "查看模式_右侧面板：切换到查看模式6"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8257, Comment: "查看模式_右侧面板：切换到查看模式7"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8258, Comment: "查看模式_右侧面板：切换到查看模式8"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8259, Comment: "查看模式_右侧面板：切换到查看模式9"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8260, Comment: "查看模式_右侧面板：切换到查看模式10"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: "82..", Comment: "查看模式_右侧面板：切换到查看模式…"})
        KeyArray.push({Key:"", Mode: "VIM模式", Group: "查看模式", Func: "TC_SendPos", Param: 8499, Comment: "查看模式_右侧面板：切换到查看模式249"})

    vim.SetWin("TTOTAL_CMD","TTOTAL_CMD","totalcmd64.exe")
    vim.SetTimeOut(500, "TTOTAL_CMD")
	for k,v in KeyArray{
        if (v.Key!="")
            vim.map(v.Key, "TTOTAL_CMD", v.Mode, v.Func, v.Param, v.Group, v.Comment)
	}
}

TTOTAL_CMD_Before(){   ;未使用
    ; Global TC_SendPos
    ;Tooltip TC_SendPos
    ;MenuID:=WinGetID("AHK_CLASS #32768")
    ;if MenuID And (TC_SendPos != 572)
    ;    return True
    ctrl:=ControlGetClassNN(ControlGetFocus("ahk_class TTOTAL_CMD"), "ahk_class TTOTAL_CMD")
    If (InStr(ctrl, TC_Global.TCListBox) )
        return False
    return True
}

/* TC_ToggleTC【切换TC】
    函数:  TC_ToggleTC
    作用:  切换TC
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_ToggleTC(AlwaysMax:=1){
    If WinExist("Ahk_Class TTOTAL_CMD"){
        AC:= WinGetMinMax("Ahk_Class TTOTAL_CMD")
        if (Ac = -1){
            WinActivate "Ahk_Class TTOTAL_CMD"
        } else {
            If (!WinActivate("Ahk_Class TTOTAL_CMD"))
                WinActivate "Ahk_Class TTOTAL_CMD"
            else
                WinMinimize "Ahk_Class TTOTAL_CMD"
        }
        if AlwaysMax
            PostMessage 1075, 2015, 0,, "Ahk_Class TTOTAL_CMD"	;最大化
    } else  {
        if (!FileExist(TC_Global.TcPath)){
            MsgBox "请指定TC的路径及相关信息。", "错误", "4112"
            run Format('"{1}" "{2}"', VimDesktop_Global.Editor, A_ScriptDir "\Plutins\TC\TC.ahk")
        }

        Run TC_Global.TcPath
        Loop 4
        {
            If(!WinActive("Ahk_Class TTOTAL_CMD"))
                WinActivate "Ahk_Class TTOTAL_CMD"
            else
                Break
            Sleep 500
        }
        if AlwaysMax
            PostMessage 1075, 2015, 0,, "Ahk_Class TTOTAL_CMD"	;最大化
    }
}

/* TC_FocusTC【激活TC】
    函数:  TC_FocusTC
    作用:  激活TC
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_FocusTC(){
    If WinExist("Ahk_Class TTOTAL_CMD")
        WinActivate "Ahk_Class TTOTAL_CMD"
    else  {
        Run TC_Global.TcPath
        Loop 4
        {
            If(!WinActive("Ahk_Class TTOTAL_CMD"))
                WinActivate "Ahk_Class TTOTAL_CMD"
            else
                Break
            Sleep 500
        }
    }
}

/* TC_FocusTCCmd【激活TC，并定位到命令行】
    函数:  TC_FocusTCCmd
    作用:  激活TC，并定位到命令行
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_FocusTCCmd(){
    TC_FocusTC()
    TC_SendPos(4003)
}

/* TC_CopyOrMoveFilesAndSubDirFilesToOtherPanel【制或移动所选文件及文件夹内所有文件到另一个Panel】
    函数:  TC_CopyOrMoveFilesAndSubDirFilesToOtherPanel
    作用:  复制或移动所选文件及文件夹内所有文件到另一个Panel，合并文件夹用的
    参数:  isMove:=0 ;0为复制，1为移动
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.18
    AHK版本: 2.0.18
    */
TC_CopyOrMoveFilesAndSubDirFilesToOtherPanel(isMove:=0) {
    ; sleep 300
    TC_SendPos(2018) ;获取路径
    sleep 100
    FileList:=A_Clipboard
    sleep 100
    TC_SendPos(2030) ;获取路径
    sleep 100
    DesDir:=ClipboardAll()
    MsgRst:=MsgBox("确认合并文件？", "询问", "4132")
    if (MsgRst="No") {
        Return
    }
    Loop parse,FileList, "`n", "`r"
    {
        if (A_LoopField="")
            continue
        If InStr(FileExist(A_LoopField), "D") {
            if isMove{
                FileMove A_LoopField "*.*", DesDir
            } else {
                FileCopy A_LoopField "*.*", DesDir
            }
        } else {
            if isMove{
                FileMove A_LoopField, DesDir
            } else {
                FileCopy A_LoopField, DesDir
            }
        }
    }
}

/* TC_CopyOrMoveToHotListDirectory【复制或移动所选文件及文件夹内到常用文件夹】
    函数:  TC_CopyOrMoveToHotListDirectory
    作用:  复制或移动所选文件及文件夹内到常用文件夹
    参数:  isMove:=0 ;0为复制，1为移动
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.18
    AHK版本: 2.0.18
    */
TC_CopyOrMoveToHotListDirectory(isMove:=0){ ;复制到常用文件夹
    CurrentFocus:=ControlGetFocus("ahk_class TTOTAL_CMD")
    sleep 100   
    if (!InStr(TC_Global.LCLListBox2, CurrentFocus) && !InStr(TC_Global.LCLListBox1, CurrentFocus))
        return
    if (InStr(TC_Global.LCLListBox2, CurrentFocus))
        otherList := TC_Global.LCLListBox1
    else
        otherList := TC_Global.LCLListBox2
    ControlFocus otherList , "ahk_class TTOTAL_CMD"
    sleep 100
    TC_SendPos(526)
    SetTimer TC_Timer_WaitMenuPop, 300

    
    TC_Timer_WaitMenuPop(){
        menuPop:=WinGetID("ahk_class #32768")
        if (menuPop) {
            SetTimer TC_Timer_WaitMenuPop, 0
            SetTimer TC_Timer_WaitMenuOff, 300
        }
    }
    
    TC_Timer_WaitMenuOff(){ 
        menuPop:=WinGetID("ahk_class #32768")
        if (not menuPop) {
            SetTimer TC_Timer_WaitMenuOff, 0
            TC_Global.CurrentFocus:=ControlFocus("ahk_class TTOTAL_CMD")
            sleep 100
            if isMove
                TC_SendPos(1005) ;移动到常用文件夹
            else
                TC_SendPos(3101) ;复制到常用文件夹
        }
    }
}

/* TC_CopyNameOnly【仅复制文件名，不含后缀】
    函数:  TC_CopyNameOnly
    作用:  仅复制文件名，不含后缀
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_CopyNameOnly(){  ;
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    if Not RegExMatch(A_Clipboard, "^\..*"){
        A_Clipboard := RegExReplace(A_Clipboard, "m)\.[^.]*$")
        A_Clipboard := RegExReplace(A_Clipboard, "m)\\$")
    }
}

/* TC_FileCopyForBak【将当前光标下的文件复制一份作为作为备份】
    函数:  TC_FileCopyForBak
    作用:  将当前光标下的文件复制一份作为作为备份
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_FileCopyForBak(){ ;将当前光标下的文件复制一份作为作为备份
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    filecopy A_Clipboard, A_Clipboard ".bak"
}

/* TC_FileMoveForBak【将当前光标下的文件重命名为备份】
    函数:  TC_FileMoveForBak
    作用:  将当前光标下的文件重命名为备份
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_FileMoveForBak(){ ;将当前光标下的文件重命名为备份
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    SplitPath A_Clipboard, &name, &dir, &ext, &name_no_ext

    if (A_Clipboard != dir . "\")
        FileMove A_Clipboard, A_Clipboard ".bak"
    else
        DirMove dir, dir ".bak"
}

/* TC_MultiFilePersistOpen【多个文件一次性连续打开】
    函数:  TC_MultiFilePersistOpen
    作用:  多个文件一次性连续打开
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_MultiFilePersistOpen(){ ;多个文件一次性连续打开
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    TC_SendPos(524)
    sleep 200
    Loop Parse, A_Clipboard, "`n", "`r"
    {
        run A_LoopField
    }
}

/* TC_CopyFileContents【不打开文件就复制文件内容】
    函数:  TC_CopyFileContents
    作用:  不打开文件就复制文件内容
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_CopyFileContents(){ ;不打开文件就复制文件内容
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    Contents:=FileRead(A_Clipboard)
    A_Clipboard :=""
    A_Clipboard := Contents
}

/* TC_OpenDirAndPaste【不打开目录，直接把复制的文件贴进去】
    函数:  TC_OpenDirAndPaste
    作用:  不打开目录，直接把复制的文件贴进去
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_20250619
    AHK版本: 2.0.18
    */
TC_OpenDirAndPaste(){ ;不打开目录，直接把复制的文件贴进去
    TC_SendPos(1001)
    TC_SendPos(2009)
    TC_SendPos(2002)
}

/* TC_CreateFileShortcut【创建当前光标下文件的快捷方式，可发送到桌面或启动文件夹】
    函数:  TC_CreateFileShortcut
    作用:  创建当前光标下文件的快捷方式，可发送到桌面或启动文件夹
    参数:  CopyTo，0=无操作，1=发送到桌面，2=发送到启动文件夹
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_CreateFileShortcut(CopyTo:=0){ ;创建当前光标下文件的快捷方式
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    SplitPath A_Clipboard, &name, &dir, &ext, &name_no_ext
    ExtLen := StrLen(ext)
    if (ExtLen != 0){
        _linkPath:=dir "\" name_no_ext ".lnk"
        FileCreateShortcut A_Clipboard, _linkPath
    } else {
        _linkPath:=dir ".lnk"
        FileCreateShortcut dir, _linkPath
    }
    Switch CopyTo{
        case 1: ;发送到桌面
            FileMove _linkPath, A_Desktop
        case 2: ;发送到启动文件夹
            FileMove _linkPath, A_Startup
            ; 打开启动目录
            run A_Startup
    }
}

/* TC_TwoFileExchangeName【两个文件互换文件名】
    函数:  TC_TwoFileExchangeName
    作用:  两个文件互换文件名
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_20250619
    AHK版本: 2.0.18
    */
TC_TwoFileExchangeName(){ ;两个文件互换文件名
    A_Clipboard :=""
    TC_SendPos(2018)
    ClipWait
    PathArray := StrSplit(A_Clipboard, "`r`n")
    FirstName := PathArray[1]
    SecondName := PathArray[2]
    TC_SendPos(524)
    sleep 200
    FileMove FirstName, FirstName ".bak"
    FileMove SecondName, FirstName
    FileMove FirstName ".bak", SecondName
}

/* TC_OpenPath【TC打开路径】
    函数:  TC_OpenPath
    作用:  TC打开路径
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_OpenPath(Path, InNewTab := true, LeftOrRight := ""){
    if (LeftOrRight = ""){
        LeftOrRight := "/R"
        if Mod(TC_LeftRight(), 2){
            LeftOrRight := "/L"
        }
    }
    if (InNewTab){
        Run Format('"{1}%" /O /T /A "{2}"="{3}"', TC_Global.TcPath, LeftOrRight, Path)
    } else{
        Run Format('"{1}%" /O /A "{2}"="{3}"', TC_Global.TcPath, LeftOrRight, Path)
    }

    TC_LeftRight(){
        location := 0
        ControlGetPos &x1, &y1, , ,  TC_Global.TCPanel1, "AHK_CLASS TTOTAL_CMD"
        if x1 > y1
            location += 2
        TLB:=ControlGetFocus("ahk_class TTOTAL_CMD")
        ControlGetPos &x2, &y2, &wn, ,  TLB, "AHK_CLASS TTOTAL_CMD"
        if location{
            if x1 > x2
                location += 1
        }else {
            if y1 > y2
                location += 1
        }
        return location
    }
}

/* TC_Run【TC运行命令】
    函数:  TC_Run
    作用:  TC运行命令
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_Run(cmd){
    ControlSetText TC_Global.TCEdit, cmd, "ahk_class TTOTAL_CMD"
    ControlSend TC_Global.TCEdit," {Enter}", "ahk_class TTOTAL_CMD"
}

/* TC_CreateNewFile【新建文件，可根据模板】
    函数:  TC_CreateNewFile
    作用:  新建文件，可根据模板
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_CreateNewFile(){ ; 
    TLB:=ControlGetFocus("ahk_class TTOTAL_CMD")
    ;获取控件的位置和大小
    ControlGetPos &OutX, &OutY, &OutWidth, &OutHeight, TLB, "ahk_class TTOTAL_CMD"
    tMyMenu := Menu()
    try
        tMyMenu.Delete()

    tMyMenu.Add("1 文件夹", (*)=>TC_SendPos(907))
    tMyMenu.SetIcon("1 文件夹", A_WinDir "\system32\Shell32.dll", 4)
    tMyMenu.Add("2 快捷方式", (*)=>TC_SendPos(1004))
    tMyMenu.SetIcon("2 快捷方式", A_WinDir "\system32\Shell32.dll", 264)
    tMyMenu.Add("3 添加到新模板", TC_AddToTempFiles)
    tMyMenu.SetIcon("3 添加到新模板", A_WinDir "\system32\Shell32.dll", -155)
    tMyMenu.Add("4 打开模板文件夹", TC_OpenTempfilesDir)
    tMyMenu.SetIcon("4 打开模板文件夹", A_WinDir "\system32\Shell32.dll", 4)
    ;添加模板----------------------
    SplitPath TC_Global.TCPath, , &_TCDir
    shellNewDir:=_TCDir "\shellNew"
    If(!DirExist(shellNewDir))
        DirCreate shellNewDir
    Loop Files shellNewDir "\*.*", "F"
    {
        if (A_Index = 1)
            tMyMenu.Add()
        ft := chr(64 + A_Index) . " >> " . A_LoopFileName
        tMyMenu.Add(ft, TC_FileTempNew)
        Ext := "." . A_LoopFileExt
        IconFile := TC_RegGetNewFileIcon(Ext)
        if (IconFile!=""){
            IconFile := RegExReplace(IconFile, "i)%SystemRoot%", A_WinDir)
            IconFilePath := RegExReplace(IconFile, ",-?\d*", "")
            IconFilePath:=StrReplace(IconFilePath,'"',"")
            IconFileIndex := RegExReplace(IconFile, ".*,", "")
            IconFileIndex := IconFileIndex>=0 ? IconFileIndex+1 : IconFileIndex
        } else {
            IconFilePath:=A_WinDir "\system32\Shell32.dll"
            IconFileIndex:=1
        }
        tMyMenu.SetIcon(ft, IconFilePath, IconFileIndex)
    }

    tMyMenu.Show(OutX, OutY)

    TC_AddToTempFiles(Item, *) { ; 添加到文件模板中
        ClipSaved := ClipboardAll()
        A_Clipboard :=""
        TC_SendPos(2018)    ;复制文件路径
        ClipWait 2
        if A_Clipboard
            SrcPath := A_Clipboard
        else
            return
        A_Clipboard := ClipSaved
        if FileExist(SrcPath)
            SplitPath SrcPath, &FileName, , &FileExt, &fileNameNoExt
        else
            return

        tGui := Gui("+AlwaysOnTop", "添加模板")
        tGui.OnEvent("Escape", (*) => tGui.Destroy())
        tGui.OnEvent("Close",  (*) => tGui.Destroy())
        tGui.SetFont("s10", "Consolas")	;等宽字体
        tGui.Add("Text", "Hidden vSrcPath", SrcPath)
        tGui.Add("Text", "x12 y20 w50 h20 +Center", "模板源")
        tGui.Add("Edit", "x72 y20 w300 h20 Disabled", FileName)
        tGui.Add("Text", "x12 y50 w50 h20 +Center", "模板名")
        tGui.Add("Edit", "x72 y50 w300 h20 vNewFileName", FileName)
        tGui.Add("Button", "x162 y80 w90 h30 default", "确认(&S)").OnEvent("Click", TC_AddTempOK)
        tGui.Add("Button", "x282 y80 w90 h30", "取消(&C)").OnEvent("Click", (*) => tGui.Destroy())
        tGui.Show()
        if FileExt {
            nf:=ControlGetHwnd("edit2", "A")
            PostMessage  0x0B1, 0, Strlen(fileNameNoExt), "Edit2", "A"
        }
        
        TC_AddTempOK(*){
            SrcPath:=tGui["SrcPath"].text
            SplitPath SrcPath, &FileName, , &FileExt, &FileNameNoExt
            NewFileName:=tGui["NewFileName"].text
            SNDir := RegExReplace(TC_Global.TCPath, "[^\\]*$") . "ShellNew\"
            if Not FileExist(SNDir)
                DirCreate SNDir
            NewFile := SNDir . NewFileName
            FileCopy SrcPath, NewFile, 1
            tGui.Destroy()
        }
    }

    TC_OpenTempfilesDir(Item, *){ ;打开模板文件夹
        SplitPath TC_Global.TCPath, , &_TCDir
        shellNewDir:=_TCDir "\shellNew"
        Sleep 300
        CurrentFocus:=ControlGetFocus("AHK_CLASS TTOTAL_CMD")
        if (!InStr(TC_Global.LCLListBox1, CurrentFocus)) &&   (!InStr(TC_Global.LCLListBox2, CurrentFocus))
            return
        if (InStr(TC_Global.LCLListBox2, CurrentFocus))
            otherList := TC_Global.LCLListBox1
        else
            otherList := TC_Global.LCLListBox2
        ControlFocus otherList, "ahk_class TTOTAL_CMD"
        TC_SendPos(3001)  ;新建标签
        ControlSetText "cd " shellNewDir, "Edit1", , "ahk_class TTOTAL_CMD"
        Sleep 200
        ControlSend "{Enter}", "Edit1", , "ahk_class TTOTAL_CMD"
    }

    TC_FileTempNew(Item, *){ ; 新建文件模板
        SrcFile:=RegExReplace(Item, ".\s>>\s", RegExReplace(TC_Global.TCPath, "\\[^\\]*$", "\shellNew\"))
        SplitPath SrcFile, &FileName, , &FileExt, &FileNameNoExt

        tGui := Gui("+AlwaysOnTop", "新建文件")
        tGui.OnEvent("Escape", (*) => tGui.Destroy())
        tGui.OnEvent("Close",  (*) => tGui.Destroy())
        tGui.SetFont("s9", "Consolas")	;等宽字体
        tGui.Add("Text", "x12 y20 h20 +Center", "模 板 源")
        tGui.Add("Edit", "x72 y20 w300 h20 vSrcFile Disabled", SrcFile)
        tGui.Add("Text", "x12 y50 h20 +Center", "新建文件")
        tGui.Add("Edit", "x72 y50 w300 h20 vNewFileName", FileName)
        tGui.Add("Button", "x162 y80 w90 h30 default", "确认(&S)").OnEvent("Click", TC_NewFileOK)
        tGui.Add("Button", "x282 y80 w90 h30", "取消(&C)").OnEvent("Click", (*) => tGui.Destroy())
        tGui.Show()
        if FileExt {
            nf:=ControlGetHwnd("Edit2", "A")
            PostMessage  0x0B1, 0, Strlen(FileNameNoExt), "Edit2", "A"
        }
        
        TC_NewFileOK(*){ ;确认新建文件
            SrcPath:=tGui["SrcFile"].Text
            NewFileName:=tGui["NewFileName"].Text
                ClipSaved := ClipboardAll()
            A_Clipboard :=""
            TC_SendPos(2029)    ;复制源路径cm_CopySrcPathToClip
            ClipWait 2
            if A_Clipboard
                DstPath := A_Clipboard
            else
                return
            A_Clipboard := ClipSaved
            if RegExMatch(DstPath, "^\\\\计算机$")
                return
            if RegExMatch(DstPath, "^\\\\此电脑$")
                return
            if RegExMatch(DstPath, "i)\\\\所有控制面板项$")
                return
            if RegExMatch(DstPath, "i)\\\\Fonts$")
                return
            if RegExMatch(DstPath, "i)\\\\网络$")
                return
            if RegExMatch(DstPath, "i)\\\\打印机$")
                return
            if RegExMatch(DstPath, "i)\\\\回收站$")
                return
            if RegExMatch(DstPath, "^\\\\桌面$")
                DstPath := A_Desktop
            NewFile := DstPath . "\" . NewFileName
            if FileExist(NewFile) {
                MsgRst:=MsgBox("新建文件已存在，是否覆盖？", "询问", "4132")
                if (MsgRst="No") {
                    Return
                }
            }
            if !FileExist(SrcPath)
                return
            else
                FileCopy SrcPath, NewFile, 1
            tGui.Destroy()
            WinActivate "AHK_CLASS TTOTAL_CMD"
            FocusCtrl:=ControlGetFocus("AHK_Class TTOTAL_CMD")
            IF RegExMatch(FocusCtrl, TC_Global.TCListBox) {
                TC_SendPos(540) ;刷新源面板
                Items:=ControlGetItems(FocusCtrl, "AHK_CLASS TTOTAL_CMD")
                for k, v in Items
                {
                    if RegExMatch(v, NewFileName)  {
                        Index := k - 1
                        PostMessage 0x19E, Index-1, 1, FocusCtrl, "AHK_CLASS TTOTAL_CMD"
                        Break
                    }
                }
            }
        }
    }
}

TC_RegGetNewFileIcon(reg){ ; 获取文件对应的图标 ; reg 为后缀
    IconPath := TC_RegGetNewFileType(reg) . "\DefaultIcon"
    try{
        FileIcon:=RegRead("HKEY_CLASSES_ROOT" "\" IconPath)
    } catch {
        FileIcon:=""
        ; FileIcon:=A_WinDir "\system32\shell32.dll"
    }
    return FileIcon

}

TC_RegGetNewFileType(reg){ ; 获取新建文件类型名 ; reg 为后缀
    try{
        FileType:=RegRead("HKEY_CLASSES_ROOT" "\" Reg)
    } catch {
        FileType:=""
    }
    return FileType
}

/* TC_GoToParent【返回到上层文件夹】
    函数:  TC_GoToParent
    作用:  返回到上层文件夹
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_GoToParent(){
    SendInput "{Backspace}"
}

/* TC_OpeDriver【打开盘符根目录】
    函数:  TC_OpeDriver
    作用:  打开盘符根目录
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_OpeDriver(DriveLetter){
    TC_SendPos(2061+ Ord(StrUpper(DriveLetter))-65)
}

/* TC_Delete【TC删除文件，自动确认】
    函数:  TC_Delete
    作用:  TC删除文件，自动确认
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_Delete(){ ;
    TC_SendPos(908) ;删除文件

    SetTimer TC_Timer_WaitMenuPop_Delete, 100
    
    TC_Timer_WaitMenuPop_Delete(){
        TC_Delete_iHwnd:=WinExist("删除文件")
        if (TC_Delete_iHwnd!=""){
            WinActivate "ahk_pid " TC_Delete_iHwnd
            Sleep 300
            Send "{enter}"
            SetTimer TC_Timer_WaitMenuPop_Delete, 0
        } 
    }
}

/* TC_CloseAllTabs【关闭所有标签】
    函数:  TC_CloseAllTabs
    作用:  关闭所有标签
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_CloseAllTabs(){
    TC_SendPos(3008)
    SetTimer TC_Timer_WaitMenuPop_CloseAllTabs, 100
    return
    
    TC_Timer_WaitMenuPop_CloseAllTabs(){
        menuPop:=WinGetID("ahk_class #32770")
        if (menuPop){
            SetTimer TC_Timer_WaitMenuPop_CloseAllTabs, 0
            send "{enter}"
        }
    }
}

/* TC_ReOpenTab【重新打开之前关闭的标签页】
    函数:  TC_ReOpenTab
    作用:  重新打开之前关闭的标签页
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_ReOpenTab(){
    TC_SendPos(3001)
    TC_SendPos(570)
}

/* TC_GoLastTab【切换到最后一个标签】
    函数:  TC_GoLastTab
    作用:  切换到最后一个标签
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_GoLastTab(){     ;定位最后一个标签
    TC_SendPos(5001)
    TC_SendPos(3006)
}

/* TC_Toggle_50_100Percent【还原当前窗口显示状态50-100】
    函数:  TC_Toggle_50_100Percent
    作用:  还原当前窗口显示状态50-100
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_Toggle_50_100Percent(){ ;切换当前（纵向）窗口显示状态50%~100%"
    ControlGetPos &OutX, &OutY, &wp, &hp, "Window1", "ahk_class TTOTAL_CMD"
    ControlGetPos &OutX, &OutY, &w1, &h1, "LCLListBox1", "ahk_class TTOTAL_CMD"
    ControlGetPos &OutX, &OutY, &w2, &h2, "LCLListBox2", "ahk_class TTOTAL_CMD"
    if (wp < hp){
        ;纵向
        if (abs(w1 - w2) > 2)
            TC_SendPos(909)
        else
            TC_SendPos(910)
    }else{
        ;横向
        if (abs(h1 - h2)  > 2)
            TC_SendPos(909)
        else
            TC_SendPos(910)
    }
}

/* TC_Toggle_50_100Percent_V【切换当前（纵向）窗口显示状态50-100】
    函数:  TC_Toggle_50_100Percent_V
    作用:  切换当前（纵向）窗口显示状态50-100
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_Toggle_50_100Percent_V(){
    ; 切换当前（纵向）窗口显示状态50%~100%"
    ; 横向分割的窗口使用 TC_Toggle_50_100Percent 即可
    ControlGetPos &OutX, &OutY, &wp, &hp, "Window1", "ahk_class TTOTAL_CMD"
    ControlGetPos &OutX, &OutY, &w1, &h1, "LCLListBox1", "ahk_class TTOTAL_CMD"
    ControlGetPos &OutX, &OutY, &w2, &h2, "LCLListBox2", "ahk_class TTOTAL_CMD"
    if (wp < hp)  { ;纵向
        if (abs(w1 - w2) > 2){
            TC_SendPos(909)
        }else{
            TC_SendPos(910)
            TC_SendPos(305)
        }
    }else {         ;横向
        if (abs(h1 - h2)  > 2){
            TC_SendPos(305)
            TC_SendPos(909)
        }
        /*
        横向切换会错乱
        else {
            TC_SendPos(910)
        }
        */
    }
}

/* TC_WinMaxLR【最大化左侧/上部窗口 最大化右侧/下部窗口】
    函数:  TC_WinMaxLR
    作用:  最大化左侧/上部窗口 最大化右侧/下部窗口
    参数:  lr:1=最大化左侧/上部窗口 0=最大化右侧/下部窗口
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_WinMaxLR(lr){      ;最大化面板-主函数
    ControlGetPos &OutX, &OutY, &wBar, &hBar, "Window1", "ahk_class TTOTAL_CMD"
	CurrentFocus:=ControlGetFocus("ahk_class TTOTAL_CMD")
	If (wBar <= hBar){
        if lr
            TC_GoPercentX(1)
        else
            TC_GoPercentX(0)
    } else {
        if lr
            TC_GoPercentY(1)
        else
            TC_GoPercentY(0)
    }

    TC_GoPercentX(Percent:=0.5) {	;改变左右方向的比例
        WinGetPos &OutX, &OutY, &hTC, &wTC, "ahk_class TTOTAL_CMD"
        ControlMove , , Round(Percent*wTC), ,"Window1", "ahk_class TTOTAL_CMD"
        ControlClick "Window1", "ahk_class TTOTAL_CMD"
        WinActivate "ahk_class TTOTAL_CMD"
    }

    TC_GoPercentY(Percent:=0.5) {	;改变上下方向的比例
        WinGetPos &OutX, &OutY, &hTC, &wTC, "ahk_class TTOTAL_CMD"
        ControlMove , , , Round(Percent*hTC),"Window1", "ahk_class TTOTAL_CMD"
        ControlClick "Window1", "ahk_class TTOTAL_CMD"
        WinActivate "ahk_class TTOTAL_CMD"
        return
    }
}

/* TC_AlwayOnTop【设置TC顶置】
    函数:  TC_AlwayOnTop
    作用:  设置TC顶置
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_AlwayOnTop(){
    ExStyle:=WinGetExStyle("ahk_class TTOTAL_CMD")
    if (ExStyle & 0x8)
        WinSetAlwaysOnTop 0, "ahk_class TTOTAL_CMD"
    else
        WinSetAlwaysOnTop 1, "ahk_class TTOTAL_CMD"
}

/* TC_Toggle_AutoPercent【自动扩大本侧窗口】
    函数:  TC_Toggle_AutoPercent
    作用:  自动扩大本侧窗口
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_Toggle_AutoPercent(){ ;TC_VIM:启用/关闭：自动扩大本侧窗口
    if (FileExist(A_ScriptDir "\vimd.exe")){
        Run Format('{1}\vimd.exe {1}\Apps\TC自动扩大本侧窗口\TC自动扩大本侧窗口Kawvin.ahk', A_ScriptDir)
    } else {
        Run A_ScriptDir "\Apps\TC自动扩大本侧窗口\TC自动扩大本侧窗口Kawvin.ahk"
    }
}

/* TC_GotoLine【TC跳转到指定行】
    函数:  TC_GotoLine
    作用:  TC跳转到指定行
    参数:  Index - 行号, 如果为空则弹出输入框
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_GotoLine(Index){
    if (Index="") {
        IB:=InputBox("请输入要跳到的行号", "输入","w200 h100" )
        if (IB.Result = "Cancel")
            return
        Index:=IB.Value
        if (Index="")
            Index:=1
    }
    Ctrl:=ControlGetFocus("AHK_CLASS TTOTAL_CMD")
    _Arr:= ControlGetItems(Ctrl, "AHK_CLASS TTOTAL_CMD")
    if Index {
        if Index > _Arr.Length
            Index := _Arr.Length
    } else {
        Index := _Arr.Length
    }
    PostMessage 0x19E, Index-1, 1, Ctrl, "AHK_CLASS TTOTAL_CMD"
}

/* TC_SrcViewChange【切换视图布局】
    函数:  TC_SrcViewChange
    作用:  切换视图布局
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_SrcViewChange(){ ;显示模式切换，详细信息-列表-缩略图
    if (TC_Global.LastView="Long"){
        TC_Global.LastView:="Short"
        TC_SendPos(302)
    } else if (TC_Global.LastView="Short"){
        TC_Global.LastView:="Thumbs"
        TC_SendPos(269)
    } else {
        TC_Global.LastView:="Long"
        TC_SendPos(301)
    } 
}

/* TC_UnpackFilesToCurrentDir【解压文件到当前文件夹】
    函数:  TC_UnpackFilesToCurrentDir
    作用:  解压文件到当前文件夹
    参数:  aFolder：是否含文件夹解压
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_UnpackFilesToCurrentDir(aFolder:=1){
    TC_SendPos(509)
    WinWaitActive "ahk_class TDLGUNZIPALL"
    SendInput "{del}"
    sleep 100
    if(aFolder=0) {
        ; control,Uncheck,,TCheckBox1,ahk_class TDLGUNZIPALL    ;TC9
        ControlSetChecked 0, "Button1","ahk_class TDLGUNZIPALL" ; TC10.52
    } else {
        ; control,check,,TCheckBox1,ahk_class TDLGUNZIPALL  ;TC9
        ControlSetChecked 1, "Button1","ahk_class TDLGUNZIPALL" ; TC10.52
    }
    sleep 100
    SendInput "{enter}"
}

/* TC_PackFilesToCurrentDir【压缩文件到当前文件夹】
    函数:  TC_PackFilesToCurrentDir
    作用:  压缩文件到当前文件夹
    参数:  aPanel：0=当前面板，1=另一侧面板
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_PackFilesToCurrentDir(aPanel:=0){
    TC_SendPos(2018)   ;获取完整路径和文件名
    sleep 100
    MySel:=A_Clipboard
    TC_SendPos(332)   ;光标定位到焦点地址栏
    sleep 100
    TC_SendPos(2029)   ;获取来源路径
    sleep 100
    CurDir:=A_Clipboard
    If (InStr(MySel, "`n")){     ;如果多行文本，则以父文件夹为压缩文件名，否则以当前文件名
        SplitPath CurDir,,, &MyOutExt, &MyOutNameNoExt
    } else {
        FileAttrib:=FileExist(MySel)
        If (InStr(FileAttrib, "D")){         ;如果是文件夹
            if(substr(MySel,0)!="\")
                MySel.="\"
            pos:=InStr(MySel, "\", , -1, 1)
            MyOutNameNoExt:=substr(MySel, pos+1)
            MyOutNameNoExt:=StrReplace(MyOutNameNoExt,"\","")
        } else {
            SplitPath MySel,,, &MyOutExt, &MyOutNameNoExt
        }
    }   
    if (aPanel=1) {
        TC_SendPos(2030)   ;获取目标路径
        sleep 100
        CurDir:=A_Clipboard
    }

    A_Clipboard:=Format("rar:{1}\{2}.rar", CurDir, MyOutNameNoExt)
    TC_SendPos(508)
    WinWaitActive "ahk_class TDLGZIP"
    SendInput "^v" 
    ;SendInput "{enter}"
}

/* TC_PackFilesToCurrentDirWithVersion【压缩文件到当前文件夹_带版本】
    函数:  TC_PackFilesToCurrentDirWithVersion
    作用:  压缩文件到当前文件夹_带版本
    参数:  aPanel：0=当前面板，1=另一侧面板
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_PackFilesToCurrentDirWithVersion(aPanel:=0){
    TC_SendPos(2018)   ;获取完整路径和文件名
    sleep 100
    MySel:=A_Clipboard
    TC_SendPos(332)   ;光标定位到焦点地址栏
    sleep 100
    TC_SendPos(2029)   ;获取来源路径
    sleep 100
    CurDir:=A_Clipboard
    If (InStr(MySel, "`n")){      ;如果多行文本，则以父文件夹为压缩文件名，否则以当前文件名
        SplitPath CurDir,,, &MyOutExt, &MyOutNameNoExt
    } else {
        FileAttrib:=FileExist(MySel)
        If (InStr(FileAttrib, "D")){         ;如果是文件夹
            if(substr(MySel,0)!="\")
                MySel.="\"
            Pos:=InStr(MySel, "\", , -1, 1)
            MyOutNameNoExt:=substr(MySel, Pos+1)
            MyOutNameNoExt:=StrReplace(MyOutNameNoExt,"\","")
        } else {
            SplitPath MySel,,, &MyOutExt, &MyOutNameNoExt
        }
    }   
    if (aPanel=1) {
        TC_SendPos(2030)   ;获取目标路径
        sleep 100
        CurDir:=A_Clipboard
    }
    FileList :=""
    Loop Files, CurDir "\*.rar", "F"		;R：子文件夹；D：目录，F：文件
        FileList .=  A_LoopFileFullPath "`n"
    FindFile:=""
    Loop parse, FileList, "`n", "`r"
    {
        if (A_LoopField="")
            continue
        if (A_LoopField>FindFile and instr(A_LoopField,MyOutNameNoExt)>0)
            FindFile:=A_LoopField
    }
    if (FindFile!=""){
        SplitPath FindFile,,, &MyOutExt, &MyOutNameNoExt
        aPos:=RegExMatch(MyOutNameNoExt,"i)_(\d{8})V(\d+)",&m)
        if (m[1]=A_Year . A_MM . A_DD) {
            MyOutNameNoExt:=StrReplace(MyOutNameNoExt,m[0], "_" . A_Year . A_MM . A_DD . "V" . m[2]+1)
        } else {
            MyOutNameNoExt:=StrReplace(MyOutNameNoExt,m[0], "_" . A_Year . A_MM . A_DD . "V1" )
        }
    }
    A_Clipboard:=Format("rar:{1}\{2}.rar", CurDir, MyOutNameNoExt)
    TC_SendPos(508)
    WinWaitActive "ahk_class TDLGZIP"
    SendInput "^v" 
    ;SendInput "{enter}"
}

/* TC_MoveSelectedFilesToPrevFolder【TC将当前文件夹下的选定文件移动到上层目录中】
    函数:  TC_MoveSelectedFilesToPrevFolder
    作用:  TC将当前文件夹下的选定文件移动到上层目录中
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
*/
TC_MoveSelectedFilesToPrevFolder(){ ;
    Send "^x"
    TC_SendPos(2002)    ;返回上一级
    sleep 800
    Send "^v"
}

/* TC_DeleteByExt_GUI【删除文件-界面选择类型】
    函数:  TC_DeleteByExt_GUI
    作用:  删除文件-界面选择类型
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_DeleteByExt_GUI(){
    ; TC_Global:=Object()
    ; TC_Global.TcCPath:="D:\aaa.txt"
    SplitPath TC_Global.TcCPath, , &_TCDir
    batchDelete_INI:=_TCDir . "\batchDelete.ini"

	If !FileExist(batchDelete_INI){
		batchDelete_Txt:="
		(
		[批量列表]
		类型1=jpg,jpeg,gif,png
		类型2=torrent,txt,html,url
		类型3=
		[后缀名列表]
		图片=bmp,tif,jpg,png,gif,jpeg,tiff
		视频=flv,mp4,mpg,rm,mpeg,avi,rmvb,dat,mkv,wmv
		音频=mp3,cue,mid,wav,wma,ape,flac
		压缩文件=gt,rar,zip,7z,bds
		文本文件=txt,xml,bat,vbs,vba,lst,ini,bas,json,md,ahk
		Office文件=doc,docx,rtf,xls,xlsx,xlsm,ppt,pptx
		网页文件=html,htm,mht,url
		其他文件=bak,torrent
		)"
		fileAppend batchDelete_Txt, batchDelete_INI, "UTF-16"
	}	
	batchDelete_List:=IniRead(batchDelete_INI, "批量列表")
	batchDelete_Exts:=IniRead(batchDelete_INI, "后缀名列表")

    tGui := Gui("+AlwaysOnTop", "删除文件-选择类型")
    tGui.OnEvent("Escape", (*) => tGui.Destroy())
    tGui.OnEvent("Close",  (*) => tGui.Destroy())
    tGui.SetFont("s10", "Consolas")	;等宽字体
    loop Parse, batchDelete_List, "`n", "`r"
	{
		if (A_LoopField="")
			continue
		TemStr:="(&" A_index ") " substr(A_LoopField, 5)
		if (A_index=1){
            t1:=tGui.Add("Radio", "x15 y15 h23 vbatchDelete", TemStr)
            t1.OnEvent("Click", batchDelete_DeleteList_click)
            t1.OnEvent("DoubleClick", batchDelete_DeleteList_DoubleClick)
        } else {
            t2:=tGui.Add("Radio", "x15 yp+25 h23", TemStr)
            t2.OnEvent("Click", batchDelete_DeleteList_click)
            t2.OnEvent("DoubleClick", batchDelete_DeleteList_DoubleClick)
        }
	}
    loop Parse, batchDelete_Exts, "`n", "`r"
	{
		if (A_LoopField="")
			continue
		ExtsString:=A_LoopField
		MyVar_Key:=RegExReplace(ExtsString,"=.*?$") 
		MyVar_Val:=RegExReplace(ExtsString,"^.*?=") 
		if (MyVar_Key && MyVar_Val) 
		{
            tGui.Add("Text", "x15 yp+30 h23", MyVar_Key)
			loop parse, MyVar_Val, ",", "`r"
			{
				if (A_index=1){
                    tGui.Add("checkbox", "xp+80 yp-3 h23", A_LoopField).OnEvent("Click", batchDelete_AddExts)
                } else {
                    tGui.Add("checkbox", "xp+80 yp h23", A_LoopField).OnEvent("Click", batchDelete_AddExts)
                }
			}
		}
	}
    tGui.Add("Text", "x15 yp+30", "文件后缀")
    tGui.Add("Edit", "x90 yp-3 w600 vbatchDelete_Exts", "")
    tGui.Add("Button", "x90 yp+30 w100 h40 Default", "(&Z) 确认").OnEvent("Click", batchDelete_OK)
    tGui.Add("Button", "xp+150 yp w100 h40", "取消").OnEvent("Click", (*) => tGui.Destroy())
    tGui.Add("Button", "xp+130 yp w30 h40", ">>").OnEvent("Click", (*) => Run(batchDelete_INI))
    tGui.Show()

    batchDelete_DeleteList_click(CtrlObj, *){
        _tStr:=tGui["batchDelete_Exts"].text
        if (CtrlObj.value=1){
            if (!InStr(_tStr, SubStr(CtrlObj.text, 6)))
                _tStr.= "," SubStr(CtrlObj.text, 6)
        } else {
            _tStr:=StrReplace(_tStr, SubStr(CtrlObj.text, 6), "")
        }
        _tStr:=RegExReplace(_tStr, ",{2,}", ",")
        _tStr:=RegExReplace(_tStr, "^,", "")
        _tStr:=RegExReplace(_tStr, ",$", "")
        tGui["batchDelete_Exts"].text:=_tStr
    }

    batchDelete_DeleteList_DoubleClick(CtrlObj, *){
        TC_DeleteByExt(SubStr(CtrlObj.text, 6))
        tGui.Destroy()
    }

    batchDelete_AddExts(CtrlObj, *){
        _tStr:=tGui["batchDelete_Exts"].text
        if (CtrlObj.value=1){
            if (!InStr(_tStr, CtrlObj.text))
                _tStr.= "," CtrlObj.text
        } else {
            _tStr:=StrReplace(_tStr, CtrlObj.text, "")
        }
        _tStr:=RegExReplace(_tStr, ",{2,}", ",")
        _tStr:=RegExReplace(_tStr, "^,", "")
        _tStr:=RegExReplace(_tStr, ",$", "")
        tGui["batchDelete_Exts"].text:=_tStr
    }

    batchDelete_OK(*){
        TC_DeleteByExt(tGui["batchDelete_Exts"].text)
        tGui.Destroy()
    }
}

/* TC_DeleteByExt【TC删除指定类型文件】
    函数:  TC_DeleteByExt
    作用:  TC删除指定类型文件
    参数:  Exts:后缀名
            DefDir:指定目录
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_DeleteByExt(Exts:="",DefDir:=""){ ;
    if(Exts="")
        return
    if(DefDir=""){
        TC_SendPos(332)  ;光标定位到焦点地址栏
        sleep 100
        TC_SendPos(2029) ;获取路径
        sleep 100
        DefDir:=A_Clipboard
    }
    loop files, DefDir "\*.*"
    {
        if (instr(Exts,a_LoopFileExt))
            FileDelete A_LoopFileFullPath
    }
    TC_SendPos(540) ;刷新来源面板
}

/* TC_MarkFile【文件添加注释】
    函数:  TC_MarkFile
    作用:  文件添加注释
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_MarkFile(){
    IB:=InputBox("请输入备注内容", "如果原文件有备注则直接替换","w400 h130" , "")
    if (IB.Result = "Cancel")
        return
    MyTemInput:=IB.Value
    if (MyTemInput="")
        return
    TC_SendPos(2700)
    ; 将备注设置为 m，可以通过将备注为 m 的文件显示成不同颜色，实现标记功能
    ; 不要在已有备注的文件使用
    Send "^+{end}"
    Send "{Text}" MyTemInput
    Send "{f2}"
}

/* TC_UnMarkFile【文件删除注释】
    函数:  TC_UnMarkFile
    作用:  文件添加注释
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_UnMarkFile(){
    TC_SendPos(2700)
    ; 删除 TC_MarkFile 的文件标记，也可用于清空文件备注
    Send "^+{end}"
    Send "{del}"
    Send "{f2}"
}

/* TC_OtherPanel_GotoPreviousDir【[另一侧]上一个文件夹】
    函数:  TC_OtherPanel_GotoPreviousDir
    作用:  【另一侧】上一个文件夹
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_OtherPanel_GotoPreviousDir(){
    Send "{Tab}"
    TC_SendPos(570)
    Send "{Tab}"
}

/* TC_OtherPanel_GotoNextDir【[另一侧]下一个文件夹】
    函数:  TC_OtherPanel_GotoNextDir
    作用:  【另一侧】下一个文件夹
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1
    AHK版本: 2.0.18
    */
TC_OtherPanel_GotoNextDir(){
    Send "{Tab}"
    TC_SendPos(571)
    Send "{Tab}"
}

/* TC_ToggleMenu【显示/隐藏_菜单栏】
    函数:  TC_ToggleMenu
    作用:  显示/隐藏_菜单栏
    参数:  
    返回:  
    作者:  Kawvin
    版本:  0.1_2025.06.19
    AHK版本: 2.0.18
    */
TC_ToggleMenu(){
    MainMenu:=IniRead(TC_Global.TcINI, "Configuration", "MainMenu","")
    if (MainMenu = "WCMD_CHN.MNU"){
        TChwnd:=WinGetId("ahk_class TTOTAL_CMD")
        DllCall("SetMenu", "uint", TChwnd, "uint", 0)
        IniWrite "NONE.MNU", TC_Global.TcINI, "Configuration", "MainMenu"
        IniWrite 1, TC_Global.TcINI, "Configuration", "RestrictInterface"
        noneMnuPath := RegExReplace(TC_Global.TCPath, "i)totalcmd6?4?.exe$", "LANGUAGE\NONE.MNU")
        if (!FileExist(noneMnuPath))
            FileAppend "", noneMnuPath, "UTF-8"
    }else {
        IniWrite "WCMD_CHN.MNU", TC_Global.TcINI, "Configuration", "MainMenu"
        IniWrite 0, TC_Global.TcINI, "Configuration", "RestrictInterface"
        WinClose "AHK_CLASS TTOTAL_CMD"
        Sleep 50
        Run TC_Global.TCPath
        Loop 4
        {
            If(!WinActive("AHK_CLASS TTOTAL_CMD"))
                WinActivate "AHK_CLASS TTOTAL_CMD"
            else
                Break
            Sleep 100
        }
    }
}

/*
TC_AllCommand(){
    TCCmdMap:=Map()
    ;命令号前加id, 是为了将避免key与index混乱的情况
    TCCmdMap["id300"]:={ Command: "cm_SrcComments", Type: "源面板", Comment: "显示文件注释"}
    TCCmdMap["id301"]:={ Command: "cm_SrcShort", Type: "源面板", Comment: "列表"}
    TCCmdMap["id302"]:={ Command: "cm_SrcLong", Type: "源面板", Comment: "详细信息"}
    TCCmdMap["id303"]:={ Command: "cm_SrcTree", Type: "源面板", Comment: "文件夹树"}
    TCCmdMap["id304"]:={ Command: "cm_SrcQuickview", Type: "源面板", Comment: "快速查看"}
    TCCmdMap["id306"]:={ Command: "cm_SrcQuickInternalOnly", Type: "源面板", Comment: "快速查看(不使用插件)"}
    TCCmdMap["id307"]:={ Command: "cm_SrcHideQuickview", Type: "源面板", Comment: "关闭快速查看"}
    TCCmdMap["id311"]:={ Command: "cm_SrcExecs", Type: "源面板", Comment: "程序文件"}
    TCCmdMap["id312"]:={ Command: "cm_SrcAllFiles", Type: "源面板", Comment: "所有文件"}
    TCCmdMap["id313"]:={ Command: "cm_SrcUserSpec", Type: "源面板", Comment: "上次选定的文件类型"}
    TCCmdMap["id314"]:={ Command: "cm_SrcUserDef", Type: "源面板", Comment: "选择文件类型"}
    TCCmdMap["id321"]:={ Command: "cm_SrcByName", Type: "源面板", Comment: "按名称排序"}
    TCCmdMap["id322"]:={ Command: "cm_SrcByExt", Type: "源面板", Comment: "按扩展名排序"}
    TCCmdMap["id323"]:={ Command: "cm_SrcBySize", Type: "源面板", Comment: "按大小排序"}
    TCCmdMap["id324"]:={ Command: "cm_SrcByDateTime", Type: "源面板", Comment: "按日期时间排序"}
    TCCmdMap["id325"]:={ Command: "cm_SrcUnsorted", Type: "源面板", Comment: "不排序"}
    TCCmdMap["id330"]:={ Command: "cm_SrcNegOrder", Type: "源面板", Comment: "反向排序"}
    TCCmdMap["id331"]:={ Command: "cm_SrcOpenDrives", Type: "源面板", Comment: "打开驱动器列表"}
    TCCmdMap["id269"]:={ Command: "cm_SrcThumbs", Type: "源面板", Comment: "缩略图"}
    TCCmdMap["id270"]:={ Command: "cm_SrcCustomViewMenu", Type: "源面板", Comment: "显示自定义视图菜单"}
    TCCmdMap["id332"]:={ Command: "cm_SrcPathFocus", Type: "源面板", Comment: "焦点移动到路径栏"}
    TCCmdMap["id333"]:={ Command: "cm_SrcViewModeList", Type: "源面板", Comment: "显示查看模式菜单"}
    TCCmdMap["id100"]:={ Command: "cm_LeftComments", Type: "左侧面板", Comment: "显示文件注释"}
    TCCmdMap["id101"]:={ Command: "cm_LeftShort", Type: "左侧面板", Comment: "列表"}
    TCCmdMap["id102"]:={ Command: "cm_LeftLong", Type: "左侧面板", Comment: "详细信息"}
    TCCmdMap["id103"]:={ Command: "cm_LeftTree", Type: "左侧面板", Comment: "文件夹树"}
    TCCmdMap["id104"]:={ Command: "cm_LeftQuickview", Type: "左侧面板", Comment: "快速查看"}
    TCCmdMap["id106"]:={ Command: "cm_LeftQuickInternalOnly", Type: "左侧面板", Comment: "快速查看(不使用插件)"}
    TCCmdMap["id107"]:={ Command: "cm_LeftHideQuickview", Type: "左侧面板", Comment: "关闭快速查看"}
    TCCmdMap["id111"]:={ Command: "cm_LeftExecs", Type: "左侧面板", Comment: "程序文件"}
    TCCmdMap["id112"]:={ Command: "cm_LeftAllFiles", Type: "左侧面板", Comment: "所有文件"}
    TCCmdMap["id113"]:={ Command: "cm_LeftUserSpec", Type: "左侧面板", Comment: "上次选定的文件类型"}
    TCCmdMap["id114"]:={ Command: "cm_LeftUserDef", Type: "左侧面板", Comment: "选择文件类型"}
    TCCmdMap["id121"]:={ Command: "cm_LeftByName", Type: "左侧面板", Comment: "按名称排序"}
    TCCmdMap["id122"]:={ Command: "cm_LeftByExt", Type: "左侧面板", Comment: "按扩展名排序"}
    TCCmdMap["id123"]:={ Command: "cm_LeftBySize", Type: "左侧面板", Comment: "按大小排序"}
    TCCmdMap["id124"]:={ Command: "cm_LeftByDateTime", Type: "左侧面板", Comment: "按日期时间排序"}
    TCCmdMap["id125"]:={ Command: "cm_LeftUnsorted", Type: "左侧面板", Comment: "不排序"}
    TCCmdMap["id130"]:={ Command: "cm_LeftNegOrder", Type: "左侧面板", Comment: "反向排序"}
    TCCmdMap["id131"]:={ Command: "cm_LeftOpenDrives", Type: "左侧面板", Comment: "打开驱动器列表"}
    TCCmdMap["id132"]:={ Command: "cm_LeftPathFocus", Type: "左侧面板", Comment: "焦点移动到路径栏"}
    TCCmdMap["id2034"]:={ Command: "cm_LeftDirBranch", Type: "左侧面板", Comment: "平面视图(所有文件和文件夹)"}
    TCCmdMap["id2047"]:={ Command: "cm_LeftDirBranchSel", Type: "左侧面板", Comment: "平面视图(仅限选定的文件和文件夹)"}
    TCCmdMap["id69"]:={ Command: "cm_LeftThumbs", Type: "左侧面板", Comment: "缩略图"}
    TCCmdMap["id70"]:={ Command: "cm_LeftCustomViewMenu", Type: "左侧面板", Comment: "显示自定义视图菜单"}
    TCCmdMap["id133"]:={ Command: "cm_LeftViewModeList", Type: "左侧面板", Comment: "显示查看模式菜单"}
    TCCmdMap["id200"]:={ Command: "cm_RightComments", Type: "右侧面板", Comment: "显示文件注释"}
    TCCmdMap["id201"]:={ Command: "cm_RightShort", Type: "右侧面板", Comment: "列表"}
    TCCmdMap["id202"]:={ Command: "cm_RightLong", Type: "右侧面板", Comment: "详细信息"}
    TCCmdMap["id203"]:={ Command: "cm_RightTree", Type: "右侧面板", Comment: "文件夹树"}
    TCCmdMap["id204"]:={ Command: "cm_RightQuickview", Type: "右侧面板", Comment: "快速查看"}
    TCCmdMap["id206"]:={ Command: "cm_RightQuickInternalOnly", Type: "右侧面板", Comment: "快速查看(不使用插件)"}
    TCCmdMap["id207"]:={ Command: "cm_RightHideQuickview", Type: "右侧面板", Comment: "关闭快速查看"}
    TCCmdMap["id211"]:={ Command: "cm_RightExecs", Type: "右侧面板", Comment: "程序文件"}
    TCCmdMap["id212"]:={ Command: "cm_RightAllFiles", Type: "右侧面板", Comment: "所有文件"}
    TCCmdMap["id213"]:={ Command: "cm_RightUserSpec", Type: "右侧面板", Comment: "上次选定的文件类型"}
    TCCmdMap["id214"]:={ Command: "cm_RightUserDef", Type: "右侧面板", Comment: "选择文件类型"}
    TCCmdMap["id221"]:={ Command: "cm_RightByName", Type: "右侧面板", Comment: "按名称排序"}
    TCCmdMap["id222"]:={ Command: "cm_RightByExt", Type: "右侧面板", Comment: "按扩展名排序"}
    TCCmdMap["id223"]:={ Command: "cm_RightBySize", Type: "右侧面板", Comment: "按大小排序"}
    TCCmdMap["id224"]:={ Command: "cm_RightByDateTime", Type: "右侧面板", Comment: "按日期时间排序"}
    TCCmdMap["id225"]:={ Command: "cm_RightUnsorted", Type: "右侧面板", Comment: "不排序"}
    TCCmdMap["id230"]:={ Command: "cm_RightNegOrder", Type: "右侧面板", Comment: "反向排序"}
    TCCmdMap["id231"]:={ Command: "cm_RightOpenDrives", Type: "右侧面板", Comment: "打开驱动器列表"}
    TCCmdMap["id232"]:={ Command: "cm_RightPathFocus", Type: "右侧面板", Comment: "焦点移动到路径栏"}
    TCCmdMap["id2035"]:={ Command: "cm_RightDirBranch", Type: "右侧面板", Comment: "平面视图(所有文件和文件夹)"}
    TCCmdMap["id2048"]:={ Command: "cm_RightDirBranchSel", Type: "右侧面板", Comment: "平面视图(仅限选定的文件和文件夹)"}
    TCCmdMap["id169"]:={ Command: "cm_RightThumbs", Type: "右侧面板", Comment: "缩略图"}
    TCCmdMap["id170"]:={ Command: "cm_RightCustomViewMenu", Type: "右侧面板", Comment: "显示自定义视图菜单"}
    TCCmdMap["id233"]:={ Command: "cm_RightViewModeList", Type: "右侧面板", Comment: "显示查看模式菜单"}
    TCCmdMap["id903"]:={ Command: "cm_List", Type: "文件操作", Comment: "查看文件"}
    TCCmdMap["id1006"]:={ Command: "cm_ListInternalOnly", Type: "文件操作", Comment: "查看单个文件(不使用插件/多媒体）"}
    TCCmdMap["id2933"]:={ Command: "cm_ListInternalMulti", Type: "文件操作", Comment: "查看所选文件(不使用插件/多媒体）"}
    TCCmdMap["id2934"]:={ Command: "cm_ListOnly", Type: "文件操作", Comment: "查看单个文件(使用插件/多媒体）"}
    TCCmdMap["id2935"]:={ Command: "cm_ListMulti", Type: "文件操作", Comment: "查看所选文件(使用插件/多媒体）"}
    TCCmdMap["id3026"]:={ Command: "cm_ListExternal", Type: "文件操作", Comment: "查看文件(使用外部查看程序)"}
    TCCmdMap["id904"]:={ Command: "cm_Edit", Type: "文件操作", Comment: "编辑文件"}
    TCCmdMap["id2931"]:={ Command: "cm_EditNewFile", Type: "文件操作", Comment: "新建或打开文本文件"}
    TCCmdMap["id2943"]:={ Command: "cm_EditFileMenu", Type: "文件操作", Comment: "显示“新建”上下文菜单"}
    TCCmdMap["id2932"]:={ Command: "cm_EditExistingFile", Type: "文件操作", Comment: "编辑光标下的文件(忽略 Shift 键)"}
    TCCmdMap["id905"]:={ Command: "cm_Copy", Type: "文件操作", Comment: "复制文件"}
    TCCmdMap["id3100"]:={ Command: "cm_CopySamePanel", Type: "文件操作", Comment: "复制到当前面板"}
    TCCmdMap["id3101"]:={ Command: "cm_CopyOtherPanel", Type: "文件操作", Comment: "复制到另一侧面板"}
    TCCmdMap["id906"]:={ Command: "cm_RenMov", Type: "文件操作", Comment: "重命名/移动文件"}
    TCCmdMap["id907"]:={ Command: "cm_MkDir", Type: "文件操作", Comment: "新建文件夹(源面板)"}
    TCCmdMap["id911"]:={ Command: "cm_MkDirOther", Type: "文件操作", Comment: "新建文件夹(目标面板)"}
    TCCmdMap["id908"]:={ Command: "cm_Delete", Type: "文件操作", Comment: "删除文件"}
    TCCmdMap["id518"]:={ Command: "cm_TestArchive", Type: "文件操作", Comment: "测试压缩包"}
    TCCmdMap["id508"]:={ Command: "cm_Pack文件", Type: "文件操作", Comment: "压缩文件"}
    TCCmdMap["id2955"]:={ Command: "cm_CopyToArchive", Type: "文件操作", Comment: "压缩文件(复制)"}
    TCCmdMap["id2956"]:={ Command: "cm_MoveToArchive", Type: "文件操作", Comment: "压缩文件(移动)"}
    TCCmdMap["id509"]:={ Command: "cm_UnpackFiles", Type: "文件操作", Comment: "解压缩文件"}
    TCCmdMap["id1002"]:={ Command: "cm_RenameOnly", Type: "文件操作", Comment: "重命名文件(Shift+F6)"}
    TCCmdMap["id1007"]:={ Command: "cm_RenameSingleFile", Type: "文件操作", Comment: "重命名光标下的文件"}
    TCCmdMap["id1005"]:={ Command: "cm_MoveOnly", Type: "文件操作", Comment: "移动文件(F6)"}
    TCCmdMap["id1003"]:={ Command: "cm_Properties", Type: "文件操作", Comment: "打开“属性”对话框"}
    TCCmdMap["id1008"]:={ Command: "cm_ModernShare", Type: "文件操作", Comment: "显示“共享”超级按钮"}
    TCCmdMap["id1004"]:={ Command: "cm_CreateShortcut", Type: "文件操作", Comment: "创建快捷方式"}
    TCCmdMap["id1001"]:={ Command: "cm_Return", Type: "文件操作", Comment: "模拟按下 Enter 键"}
    TCCmdMap["id2800"]:={ Command: "cm_OpenAsUser", Type: "文件操作", Comment: "以其他用户身份运行光标下的程序"}
    TCCmdMap["id560"]:={ Command: "cm_Split", Type: "文件操作", Comment: "拆分文件"}
    TCCmdMap["id561"]:={ Command: "cm_Combine", Type: "文件操作", Comment: "合并文件"}
    TCCmdMap["id562"]:={ Command: "cm_Encode", Type: "文件操作", Comment: "文件编码(MIME、UUE、XXE)"}
    TCCmdMap["id563"]:={ Command: "cm_Decode", Type: "文件操作", Comment: "文件解码(MIME、UUE、XXE、BinHex)"}
    TCCmdMap["id564"]:={ Command: "cm_CRCcreate", Type: "文件操作", Comment: "创建校验和文件"}
    TCCmdMap["id565"]:={ Command: "cm_CRCcheck", Type: "文件操作", Comment: "验证校验"}
    TCCmdMap["id502"]:={ Command: "cm_SetAttrib", Type: "文件操作", Comment: "更改属性"}
    TCCmdMap["id490"]:={ Command: "cm_Config", Type: "配置", Comment: "布局(第一页)"}
    TCCmdMap["id476"]:={ Command: "cm_LayoutConfig", Type: "配置", Comment: "布局"}
    TCCmdMap["id486"]:={ Command: "cm_DisplayConfig", Type: "配置", Comment: "显示"}
    TCCmdMap["id477"]:={ Command: "cm_IconConfig", Type: "配置", Comment: "图标"}
    TCCmdMap["id492"]:={ Command: "cm_FontConfig", Type: "配置", Comment: "字体"}
    TCCmdMap["id494"]:={ Command: "cm_ColorConfig", Type: "配置", Comment: "颜色"}
    TCCmdMap["id497"]:={ Command: "cm_ConfTabChange", Type: "配置", Comment: "列宽/格式"}
    TCCmdMap["id488"]:={ Command: "cm_DirTabsConfig", Type: "配置", Comment: "文件夹标签"}
    TCCmdMap["id483"]:={ Command: "cm_CustomColumnConfig", Type: "配置", Comment: "自定义视图"}
    TCCmdMap["id2920"]:={ Command: "cm_CustomColumnDlg", Type: "配置", Comment: "更改当前自定义视图"}
    TCCmdMap["id2939"]:={ Command: "cm_ConfigViewModes", Type: "配置", Comment: "查看模式"}
    TCCmdMap["id2940"]:={ Command: "cm_ConfigViewModeSwitch", Type: "配置", Comment: "自动切换查看模式"}
    TCCmdMap["id499"]:={ Command: "cm_LanguageConfig", Type: "配置", Comment: "语言"}
    TCCmdMap["id516"]:={ Command: "cm_Config2", Type: "配置", Comment: "操作方式"}
    TCCmdMap["id496"]:={ Command: "cm_EditConfig", Type: "配置", Comment: "查看/编辑"}
    TCCmdMap["id3036"]:={ Command: "cm_ConfigLister", Type: "配置", Comment: "查看器"}
    TCCmdMap["id487"]:={ Command: "cm_CopyConfig", Type: "配置", Comment: "复制删除"}
    TCCmdMap["id478"]:={ Command: "cm_RefreshConfig", Type: "配置", Comment: "刷新"}
    TCCmdMap["id479"]:={ Command: "cm_QuickSearchConfig", Type: "配置", Comment: "快速搜索"}
    TCCmdMap["id489"]:={ Command: "cm_FtpConfig", Type: "配置", Comment: "FTP"}
    TCCmdMap["id484"]:={ Command: "cm_PluginsConfig", Type: "配置", Comment: "插件"}
    TCCmdMap["id482"]:={ Command: "cm_ThumbnailsConfig", Type: "配置", Comment: "缩略图"}
    TCCmdMap["id481"]:={ Command: "cm_LogConfig", Type: "配置", Comment: "日志文件"}
    TCCmdMap["id480"]:={ Command: "cm_IgnoreConfig", Type: "配置", Comment: "忽略列耒"}
    TCCmdMap["id475"]:={ Command: "cm_HistoryConfig", Type: "配置", Comment: "文件夹历史记录"}
    TCCmdMap["id491"]:={ Command: "cm_PackerConfig", Type: "配置", Comment: "压缩程序"}
    TCCmdMap["id485"]:={ Command: "cm_ZipPackerConfig", Type: "配置", Comment: "ZIP压缩程序"}
    TCCmdMap["id474"]:={ Command: "cm_7ZipPackerConfig", Type: "配置", Comment: "7Zip压缩程序"}
    TCCmdMap["id495"]:={ Command: "cm_Confirmation", Type: "配置", Comment: "其他"}
    TCCmdMap["id493"]:={ Command: "cm_ConfigSavePos", Type: "配置", Comment: "保存窗口位置"}
    TCCmdMap["id498"]:={ Command: "cm_ButtonConfig", Type: "配置", Comment: "工具栏"}
    TCCmdMap["id583"]:={ Command: "cm_ButtonConfig2", Type: "配置", Comment: "垂直工具栏"}
    TCCmdMap["id580"]:={ Command: "cm_ConfigSaveSettings", Type: "配置", Comment: "保存设置"}
    TCCmdMap["id581"]:={ Command: "cm_ConfigChangeIni文件", Type: "配置", Comment: "直接修改设置文件"}
    TCCmdMap["id582"]:={ Command: "cm_ConfigSaveDirHistory", Type: "配置", Comment: "保存文件夹历史记录"}
    TCCmdMap["id700"]:={ Command: "cm_ChangeStartMenu", Type: "配置", Comment: "更改开始菜单"}
    TCCmdMap["id512"]:={ Command: "cm_NetConnect", Type: "网络", Comment: "映射网络驱动器"}
    TCCmdMap["id513"]:={ Command: "cm_NetDisconnect", Type: "网络", Comment: "断开网络驱动器"}
    TCCmdMap["id514"]:={ Command: "cm_NetShareDir", Type: "网络", Comment: "共享当前文件夹"}
    TCCmdMap["id515"]:={ Command: "cm_NetUnshareDir", Type: "网络", Comment: "取消文件夹共享"}
    TCCmdMap["id2204"]:={ Command: "cm_AdministerServer", Type: "网络", Comment: "显示系统共享文件夹"}
    TCCmdMap["id2203"]:={ Command: "cm_ShowFileUser", Type: "网络", Comment: "显示本地文件的远程用户"}
    TCCmdMap["id503"]:={ Command: "cm_GetFileSpace", Type: "其他", Comment: "计算占用空间"}
    TCCmdMap["id505"]:={ Command: "cm_VolumeId", Type: "其他", Comment: "磁盘卷标"}
    TCCmdMap["id510"]:={ Command: "cm_VersionInfo", Type: "其他", Comment: "打开“属性”对话框"}
    TCCmdMap["id511"]:={ Command: "cm_ExecuteDOS", Type: "其他", Comment: "打开命令提示符"}
    TCCmdMap["id533"]:={ Command: "cm_CompareDirs", Type: "其他", Comment: "比较文件夹"}
    TCCmdMap["id536"]:={ Command: "cm_CompareDirsWithSubDirs", Type: "其他", Comment: "比较文件夹(标记另一侧缺少的子文件夹)"}
    TCCmdMap["id2500"]:={ Command: "cm_ContextMenu", Type: "其他", Comment: "显示上下文菜单"}
    TCCmdMap["id3020"]:={ Command: "cm_DriveContextMenu", Type: "其他", Comment: "显示驱动器上下文菜单"}
    TCCmdMap["id2927"]:={ Command: "cm_ContextMenuInternal", Type: "其他", Comment: "显示内部关联的上下文菜单"}
    TCCmdMap["id2928"]:={ Command: "cm_ContextMenuInternalCursor", Type: "其他", Comment: "显示光标下文件的内部关联上下文菜单"}
    TCCmdMap["id2930"]:={ Command: "cm_ShowRemoteMenu", Type: "其他", Comment: "显示媒体中心遥控器调出的上下文菜单"}
    TCCmdMap["id2600"]:={ Command: "cm_SyncChangeDir", Type: "其他", Comment: "两侧面板同步切换文件夹"}
    TCCmdMap["id2700"]:={ Command: "cm_EditComment", Type: "其他", Comment: "编辑文件注释"}
    TCCmdMap["id4001"]:={ Command: "cm_FocusLeft", Type: "其他", Comment: "焦点移动到左侧面板"}
    TCCmdMap["id4002"]:={ Command: "cm_FocusRight", Type: "其他", Comment: "焦点移动到右侧面板"}
    TCCmdMap["id4005"]:={ Command: "cm_FocusSrc", Type: "其他", Comment: "焦点移动到源面板"}
    TCCmdMap["id4006"]:={ Command: "cm_FocusTrg", Type: "其他", Comment: "焦点移动到目标面板"}
    TCCmdMap["id4003"]:={ Command: "cm_FocusCmdLine", Type: "其他", Comment: "焦点移动到命令行"}
    TCCmdMap["id4004"]:={ Command: "cm_FocusButtonBar", Type: "其他", Comment: "焦点移动到工具栏"}
    TCCmdMap["id4007"]:={ Command: "cm_FocusLeftTree", Type: "其他", Comment: "焦点移动到左侧面板导航窗格"}
    TCCmdMap["id4008"]:={ Command: "cm_FocusRightTree", Type: "其他", Comment: "焦点移动到右侧面板导航窗格"}
    TCCmdMap["id4009"]:={ Command: "cm_FocusSrcTree", Type: "其他", Comment: "焦点移动到源面板导航窗格"}
    TCCmdMap["id4010"]:={ Command: "cm_FocusTrgTree", Type: "其他", Comment: "焦点移动到目标面板导航窗格"}
    TCCmdMap["id4011"]:={ Command: "cm_FocusMainMenu", Type: "其他", Comment: "焦点移动到主菜单"}
    TCCmdMap["id4012"]:={ Command: "cm_FocusButtonBarVertical", Type: "其他", Comment: "焦点移动到垂直工具栏"}
    TCCmdMap["id2014"]:={ Command: "cm_CountDirContent", Type: "其他", Comment: "计算所有子文件夹占用的空间"}
    TCCmdMap["id2913"]:={ Command: "cm_UnloadPlugins", Type: "其他", Comment: "卸载所有插件"}
    TCCmdMap["id534"]:={ Command: "cm_DirMatch", Type: "其他", Comment: "标记较新的文件，隐藏相同的文件"}
    TCCmdMap["id531"]:={ Command: "cm_Exchange", Type: "其他", Comment: "交换面板"}
    TCCmdMap["id532"]:={ Command: "cm_MatchSrc", Type: "其他", Comment: "目标=来源"}
    TCCmdMap["id2918"]:={ Command: "cm_ReloadSelThumbs", Type: "其他", Comment: "重新加载选定的缩略图"}
    TCCmdMap["id2945"]:={ Command: "cm_ReloadBarIcons", Type: "其他", Comment: "重新加载工具栏和主菜单中的图标"}
    TCCmdMap["id2958"]:={ Command: "cm_ReloadFileIcons", Type: "其他", Comment: "重新加载所有文件的图标"}
    TCCmdMap["id2300"]:={ Command: "cm_DirectCableConnect", Type: "并行端口", Comment: "直接电缆连接"}
    TCCmdMap["id2301"]:={ Command: "cm_NTinstallDriver", Type: "并行端口", Comment: "加载并行端口驱动程序"}
    TCCmdMap["id2302"]:={ Command: "cm_NTremoveDriver", Type: "并行端口", Comment: "卸载并行端口驱动程序"}
    TCCmdMap["id2027"]:={ Command: "cm_PrintDir", Type: "打印", Comment: "打印文件列表"}
    TCCmdMap["id2028"]:={ Command: "cm_PrintDirSub", Type: "打印", Comment: "打印文件列表(含子文件夹)"}
    TCCmdMap["id504"]:={ Command: "cm_PrintFile", Type: "打印", Comment: "打印文件内容"}
    TCCmdMap["id521"]:={ Command: "cm_SpreadSelection", Type: "标记", Comment: "选择一组"}
    TCCmdMap["id546"]:={ Command: "cm_SpreadSelectionCurrentExt", Type: "标记", Comment: "选择一组：预先加载光标下文件的扩展名"}
    TCCmdMap["id3311"]:={ Command: "cm_SelectBoth", Type: "标记", Comment: "选择一组：文件+文件夹"}
    TCCmdMap["id3312"]:={ Command: "cm_SelectFiles", Type: "标记", Comment: "选择一组：文件"}
    TCCmdMap["id3313"]:={ Command: "cm_SelectFolders", Type: "标记", Comment: "选择一组：文件夹"}
    TCCmdMap["id522"]:={ Command: "cm_ShrinkSelection", Type: "标记", Comment: "不选一组"}
    TCCmdMap["id547"]:={ Command: "cm_ShrinkSelectionCurrentExt", Type: "标记", Comment: "不选一组：预先加载光标下文件的扩展名"}
    TCCmdMap["id3314"]:={ Command: "cm_ClearFiles", Type: "标记", Comment: "不选一组：文件"}
    TCCmdMap["id3315"]:={ Command: "cm_ClearFolders", Type: "标记", Comment: "不选一组：文件夹"}
    TCCmdMap["id3316"]:={ Command: "cm_ClearSelCfg", Type: "标记", Comment: "不选一组：文件或文件+文件夹(取决于配置)"}
    TCCmdMap["id523"]:={ Command: "cm_SelectAll", Type: "标记", Comment: "全部选择：文件或文件+文件夹(取决于配置)"}
    TCCmdMap["id3301"]:={ Command: "cm_SelectAllBoth", Type: "标记", Comment: "全部选择：文件+文件夹"}
    TCCmdMap["id3302"]:={ Command: "cm_SelectAllFiles", Type: "标记", Comment: "全部选择：文件"}
    TCCmdMap["id3303"]:={ Command: "cm_SelectAllFolders", Type: "标记", Comment: "全部选择：文件夹"}
    TCCmdMap["id524"]:={ Command: "cm_ClearAll", Type: "标记", Comment: "取消全选：文件+文件夹"}
    TCCmdMap["id3304"]:={ Command: "cm_ClearAllFiles", Type: "标记", Comment: "取消全选：文件"}
    TCCmdMap["id3305"]:={ Command: "cm_ClearAllFolders", Type: "标记", Comment: "取消全选：文件夹"}
    TCCmdMap["id3306"]:={ Command: "cm_ClearAllCfg", Type: "标记", Comment: "取消全选：文件或文件+文件夹(取决于配置)"}
    TCCmdMap["id525"]:={ Command: "cm_ExchangeSelection", Type: "标记", Comment: "反向选择"}
    TCCmdMap["id3321"]:={ Command: "cm_ExchangeSelBoth", Type: "标记", Comment: "反向选择：文件+文件夹"}
    TCCmdMap["id3322"]:={ Command: "cm_ExchangeSelFiles", Type: "标记", Comment: "反向选择：文件"}
    TCCmdMap["id3323"]:={ Command: "cm_ExchangeSelFolders", Type: "标记", Comment: "反向选择：文件夹"}
    TCCmdMap["id527"]:={ Command: "cm_SelectCurrentExtension", Type: "标记", Comment: "选择所有扩展名相同的项目"}
    TCCmdMap["id528"]:={ Command: "cm_UnselectCurrentExtension", Type: "标记", Comment: "不选所有扩展名相同的项目"}
    TCCmdMap["id541"]:={ Command: "cm_SelectCurrentName", Type: "标记", Comment: "选择所有名称相同的项目"}
    TCCmdMap["id542"]:={ Command: "cm_UnselectCurrentName", Type: "标记", Comment: "不选所有名称相同的项目"}
    TCCmdMap["id543"]:={ Command: "cm_SelectCurrentNameExt", Type: "标记", Comment: "选择所有名称+扩展名相同的项目"}
    TCCmdMap["id544"]:={ Command: "cm_UnselectCurrentNameExt", Type: "标记", Comment: "不选所有名称+扩展名相同的项目"}
    TCCmdMap["id537"]:={ Command: "cm_SelectCurrentPath", Type: "标记", Comment: "选择所有路径相同的文件(平面视图/搜索文件)"}
    TCCmdMap["id538"]:={ Command: "cm_UnselectCurrentPath", Type: "标记", Comment: "不选所有路径相同的文件(平面视图/搜索文件)"}
    TCCmdMap["id529"]:={ Command: "cm_RestoreSelection", Type: "标记", Comment: "还原选择"}
    TCCmdMap["id530"]:={ Command: "cm_SaveSelection", Type: "标记", Comment: "保存选择"}
    TCCmdMap["id2031"]:={ Command: "cm_SaveSelectionToFile", Type: "标记", Comment: "导出选择"}
    TCCmdMap["id2041"]:={ Command: "cm_SaveSelectionToFileA", Type: "标记", Comment: "导出选择(ANSI)"}
    TCCmdMap["id2042"]:={ Command: "cm_SaveSelectionToFile", Type: "标记", Comment: "导出选择(Unicode)"}
    TCCmdMap["id2039"]:={ Command: "cm_SaveDetailsToFile", Type: "标记", Comment: "导出详细信息"}
    TCCmdMap["id2043"]:={ Command: "cm_SaveDetailsToFileA", Type: "标记", Comment: "导出详细信息(ANSI)"}
    TCCmdMap["id2044"]:={ Command: "cm_SaveDetailsToFile", Type: "标记", Comment: "导出详细信息(Unicode)"}
    TCCmdMap["id2093"]:={ Command: "cm_SaveHdrDetailsToFile", Type: "标记", Comment: "导出详细信息(含标题)"}
    TCCmdMap["id2094"]:={ Command: "cm_SaveHdrDetailsToFileA", Type: "标记", Comment: "导出详细信息(含标题)(ANSI)"}
    TCCmdMap["id2095"]:={ Command: "cm_SaveHdrDetailsToFile", Type: "标记", Comment: "导出详细信息(含标题)(Unicode)"}
    TCCmdMap["id2032"]:={ Command: "cm_LoadSelectionFromFile", Type: "标记", Comment: "从文件导入选择"}
    TCCmdMap["id2033"]:={ Command: "cm_LoadSelectionFromClip", Type: "标记", Comment: "从剪贴板导入选择"}
    TCCmdMap["id2936"]:={ Command: "cm_Select", Type: "标记", Comment: "选择文件并向下移动光标"}
    TCCmdMap["id2937"]:={ Command: "cm_UnSelect", Type: "标记", Comment: "取消选择并向下移动光标"}
    TCCmdMap["id2938"]:={ Command: "cm_Reverse", Type: "标记", Comment: "反向选择并向下移动光标"}
    TCCmdMap["id2200"]:={ Command: "cm_EditPermissionInfo", Type: "安全", Comment: "设置权限(NTFS)"}
    TCCmdMap["id2201"]:={ Command: "cm_EditAuditInfo", Type: "安全", Comment: "审核文件(NTFS)"}
    TCCmdMap["id2202"]:={ Command: "cm_EditOwnerInfo", Type: "安全", Comment: "获取所有权(NTFS)"}
    TCCmdMap["id2007"]:={ Command: "cm_CutToClipboard", Type: "剪贴板", Comment: "将所选文件剪切到剪贴板"}
    TCCmdMap["id2008"]:={ Command: "cm_CopyToClipboard", Type: "剪贴板", Comment: "将所选文件复制到剪贴板"}
    TCCmdMap["id2009"]:={ Command: "cm_PasteFromClipboard", Type: "剪贴板", Comment: "将文件粘贴到当前文件夹"}
    TCCmdMap["id2017"]:={ Command: "cm_CopyNamesToClip", Type: "剪贴板", Comment: "复制所选项目的名称"}
    TCCmdMap["id2018"]:={ Command: "cm_CopyFullNamesToClip", Type: "剪贴板", Comment: "复制所选项目的完整路径及名称"}
    TCCmdMap["id2021"]:={ Command: "cm_CopyNetNamesToClip", Type: "剪贴板", Comment: "复制所选项目的网络路径及名称"}
    TCCmdMap["id3035"]:={ Command: "cm_CopyPathOfFilesToClip", Type: "剪贴板", Comment: "复制恪个文件的路径名称"}
    TCCmdMap["id2029"]:={ Command: "cm_CopySrcPathToClip", Type: "剪贴板", Comment: "复制源路径"}
    TCCmdMap["id2030"]:={ Command: "cm_CopyTrgPathToClip", Type: "剪贴板", Comment: "复制目标路径"}
    TCCmdMap["id2036"]:={ Command: "cm_CopyFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的详细信息"}
    TCCmdMap["id2037"]:={ Command: "cm_CopyFpFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的完整路径及详细信息"}
    TCCmdMap["id2038"]:={ Command: "cm_CopyNetFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的网铬路径及详细信息"}
    TCCmdMap["id2090"]:={ Command: "cm_CopyHdrFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的详细信息含标题"}
    TCCmdMap["id2091"]:={ Command: "cm_CopyHdrFpFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的完整路径及详细信息(含标题)"}
    TCCmdMap["id2092"]:={ Command: "cm_CopyHdrNetFileDetailsToClip", Type: "剪贴板", Comment: "复制所选项目的网铬路径及详细信息(含标题)"}
    TCCmdMap["id550"]:={ Command: "cm_FtpConnect", Type: "FTP", Comment: "连接到 FTP"}
    TCCmdMap["id551"]:={ Command: "cm_FtpNew", Type: "FTP", Comment: "新建 FTP 连接"}
    TCCmdMap["id552"]:={ Command: "cm_FtpDisconnect", Type: "FTP", Comment: "断开 FTP 连接"}
    TCCmdMap["id553"]:={ Command: "cm_FtpHiddenFiles", Type: "FTP", Comment: "显示隐藏的 FTP 文件"}
    TCCmdMap["id554"]:={ Command: "cm_FtpAbort", Type: "FTP", Comment: "中止当前的 FTP 命令"}
    TCCmdMap["id555"]:={ Command: "cm_FtpResumeDownload", Type: "FTP", Comment: "续传下载"}
    TCCmdMap["id556"]:={ Command: "cm_FtpSelectTransferMode", Type: "FTP", Comment: "选择传输模式"}
    TCCmdMap["id557"]:={ Command: "cm_FtpAddToList", Type: "FTP", Comment: "将所选文件添加到下载列表"}
    TCCmdMap["id558"]:={ Command: "cm_FtpDownloadList", Type: "FTP", Comment: "按下载列表下载"}
    TCCmdMap["id570"]:={ Command: "cm_GotoPreviousDir", Type: "导航", Comment: "上一个文件夹"}
    TCCmdMap["id571"]:={ Command: "cm_GotoNextDir", Type: "导航", Comment: "下一个文件夹"}
    TCCmdMap["id572"]:={ Command: "cm_DirectoryHistory", Type: "导航", Comment: "文件夹历史记录"}
    TCCmdMap["id575"]:={ Command: "cm_DirectoryHistoryNoThinning", Type: "导航", Comment: "文件夹历史记录(未精简)"}
    TCCmdMap["id573"]:={ Command: "cm_GotoPreviousLocalDir", Type: "导航", Comment: "上一个本地文件夹"}
    TCCmdMap["id574"]:={ Command: "cm_GotoNextLocalDir", Type: "导航", Comment: "下一个本地文件夹"}
    TCCmdMap["id526"]:={ Command: "cm_DirectoryHotList", Type: "导航", Comment: "显示常用文件夹菜单"}
    TCCmdMap["id2001"]:={ Command: "cm_GoToRoot", Type: "导航", Comment: "根文件夹"}
    TCCmdMap["id2002"]:={ Command: "cm_GoToParent", Type: "导航", Comment: "上一级文件夹"}
    TCCmdMap["id2003"]:={ Command: "cm_GoToDir", Type: "导航", Comment: "打开光标下的文件夹或压缩包"}
    TCCmdMap["id2121"]:={ Command: "cm_OpenDesktop", Type: "导航", Comment: "桌面文件夹"}
    TCCmdMap["id2122"]:={ Command: "cm_OpenDrives", Type: "导航", Comment: "此电脑"}
    TCCmdMap["id2123"]:={ Command: "cm_OpenControls", Type: "导航", Comment: "控制面板"}
    TCCmdMap["id2124"]:={ Command: "cm_OpenFonts", Type: "导航", Comment: "字体文件夹"}
    TCCmdMap["id2125"]:={ Command: "cm_OpenNetwork", Type: "导航", Comment: "网络"}
    TCCmdMap["id2126"]:={ Command: "cm_OpenPrinters", Type: "导航", Comment: "打印机文件夹"}
    TCCmdMap["id2127"]:={ Command: "cm_OpenRecycled", Type: "导航", Comment: "回收站"}
    TCCmdMap["id500"]:={ Command: "cm_CdTree", Type: "导航", Comment: "切换文件夹"}
    TCCmdMap["id2024"]:={ Command: "cm_TransferLeft", Type: "导航", Comment: "在左侧面板打开光标下的文件夹"}
    TCCmdMap["id2025"]:={ Command: "cm_TransferRight", Type: "导航", Comment: "在右侧面板打开光标下的文件夹"}
    TCCmdMap["id2912"]:={ Command: "cm_EditPath", Type: "导航", Comment: "编辑源面板的路径"}
    TCCmdMap["id2049"]:={ Command: "cm_GoToFirstEntry", Type: "导航", Comment: "光标移动到第一个文件或文件夹"}
    TCCmdMap["id2050"]:={ Command: "cm_GoToFirstFile", Type: "导航", Comment: "光标移动到第一个文件"}
    TCCmdMap["id2051"]:={ Command: "cm_GotoNextDrive", Type: "导航", Comment: "下一个驱动器"}
    TCCmdMap["id2052"]:={ Command: "cm_GotoPreviousDrive", Type: "导航", Comment: "上一个驱动器"}
    TCCmdMap["id2053"]:={ Command: "cm_GotoNextSelected", Type: "导航", Comment: "下一个选中的文件"}
    TCCmdMap["id2054"]:={ Command: "cm_GotoPrevSelected", Type: "导航", Comment: "上一个选中的文件"}
    TCCmdMap["id2055"]:={ Command: "cm_GotoNext", Type: "导航", Comment: "下一个文件"}
    TCCmdMap["id2056"]:={ Command: "cm_GotoPrev", Type: "导航", Comment: "上一个文件"}
    TCCmdMap["id2057"]:={ Command: "cm_GoToLast", Type: "导航", Comment: "最后一个文件"}
    TCCmdMap["id2061"]:={ Command: "cm_GotoDriveB", Type: "导航", Comment: "切换到驱动器B"}
    TCCmdMap["id2062"]:={ Command: "cm_GotoDriveC", Type: "导航", Comment: "切换到驱动器C"}
    TCCmdMap["id2063"]:={ Command: "cm_GotoDriveD", Type: "导航", Comment: "切换到驱动器D"}
    TCCmdMap["id2064"]:={ Command: "cm_GotoDriveE", Type: "导航", Comment: "切换到驱动器E"}
    TCCmdMap["id2065"]:={ Command: "cm_GotoDriveF", Type: "导航", Comment: "切换到驱动器F"}
    TCCmdMap["id2066"]:={ Command: "cm_GotoDriveG", Type: "导航", Comment: "切换到驱动器G"}
    TCCmdMap["id2067"]:={ Command: "cm_GotoDriveH", Type: "导航", Comment: "切换到驱动器H"}
    TCCmdMap["id2068"]:={ Command: "cm_GotoDriveI", Type: "导航", Comment: "切换到驱动器I"}
    TCCmdMap["id2069"]:={ Command: "cm_GotoDriveJ", Type: "导航", Comment: "切换到驱动器J"}
    TCCmdMap["id2070"]:={ Command: "cm_GotoDriveK", Type: "导航", Comment: "切换到驱动器K"}
    TCCmdMap["id2071"]:={ Command: "cm_GotoDriveL", Type: "导航", Comment: "切换到驱动器L"}
    TCCmdMap["id2072"]:={ Command: "cm_GotoDriveM", Type: "导航", Comment: "切换到驱动器M"}
    TCCmdMap["id2073"]:={ Command: "cm_GotoDriveN", Type: "导航", Comment: "切换到驱动器N"}
    TCCmdMap["id2074"]:={ Command: "cm_GotoDriveO", Type: "导航", Comment: "切换到驱动器O"}
    TCCmdMap["id2075"]:={ Command: "cm_GotoDriveP", Type: "导航", Comment: "切换到驱动器P"}
    TCCmdMap["id2076"]:={ Command: "cm_GotoDriveQ", Type: "导航", Comment: "切换到驱动器Q"}
    TCCmdMap["id2077"]:={ Command: "cm_GotoDriveR", Type: "导航", Comment: "切换到驱动器R"}
    TCCmdMap["id2078"]:={ Command: "cm_GotoDriveS", Type: "导航", Comment: "切换到驱动器S"}
    TCCmdMap["id2079"]:={ Command: "cm_GotoDriveT", Type: "导航", Comment: "切换到驱动器T"}
    TCCmdMap["id2080"]:={ Command: "cm_GotoDriveU", Type: "导航", Comment: "切换到驱动器U"}
    TCCmdMap["id2081"]:={ Command: "cm_GotoDriveV", Type: "导航", Comment: "切换到驱动器V"}
    TCCmdMap["id2082"]:={ Command: "cm_GotoDriveW", Type: "导航", Comment: "切换到驱动器W"}
    TCCmdMap["id2083"]:={ Command: "cm_GotoDriveX", Type: "导航", Comment: "切换到驱动器X"}
    TCCmdMap["id2084"]:={ Command: "cm_GotoDriveY", Type: "导航", Comment: "切换到驱动器Y"}
    TCCmdMap["id2085"]:={ Command: "cm_GotoDriveZ", Type: "导航", Comment: "切换到驱动器Z"}
    TCCmdMap["id2086"]:={ Command: "cm_GotoDrive[", Type: "导航", Comment: "切换到驱动器["}
    TCCmdMap["id3025"]:={ Command: "cm_OpenDriveByIndex", Type: "导航", Comment: "按序号切换驱动器"}
    TCCmdMap["id610"]:={ Command: "cm_HelpIndex", Type: "帮助", Comment: "帮助索引"}
    TCCmdMap["id620"]:={ Command: "cm_Keyboard", Type: "帮助", Comment: "快捷鍵"}
    TCCmdMap["id630"]:={ Command: "cm_Register", Type: "帮助", Comment: "注册信息"}
    TCCmdMap["id640"]:={ Command: "cm_VisitHomepage", Type: "帮助", Comment: "访问Total Commander网站"}
    TCCmdMap["id650"]:={ Command: "cm_CheckForUpdates", Type: "帮助", Comment: "检查更新"}
    TCCmdMap["id690"]:={ Command: "cm_About", Type: "帮助", Comment: "关于Total Commander"}
    TCCmdMap["id24340"]:={ Command: "cm_Exit", Type: "窗口", Comment: "退出Total Commander"}
    TCCmdMap["id2000"]:={ Command: "cm_Minimize", Type: "窗口", Comment: "最小化Total Commander"}
    TCCmdMap["id2015"]:={ Command: "cm_Maximize", Type: "窗口", Comment: "最大化Total Commander"}
    TCCmdMap["id2016"]:={ Command: "cm_Restore", Type: "窗口", Comment: "还原到正常大小"}
    TCCmdMap["id2004"]:={ Command: "cm_ClearCmdLine", Type: "命令行", Comment: "清除命令行"}
    TCCmdMap["id2005"]:={ Command: "cm_NextCommand", Type: "命令行", Comment: "下一个命令"}
    TCCmdMap["id2006"]:={ Command: "cm_PrevCommand", Type: "命令行", Comment: "上一个命令"}
    TCCmdMap["id2019"]:={ Command: "cm_AddPathToCmdline", Type: "命令行", Comment: "将路径复制到命令行"}
    TCCmdMap["id3021"]:={ Command: "cm_AddFileNameToCmdline", Type: "命令行", Comment: "将文件名复制到命令行"}
    TCCmdMap["id3022"]:={ Command: "cm_AddPathAndFileNameToCmdline", Type: "命令行", Comment: "将路径及文件名复制到命令行"}
    TCCmdMap["id3023"]:={ Command: "cm_ShowCmdLineHistory", Type: "命令行", Comment: "开启/关闭：命令行历史记录"}
    TCCmdMap["id2400"]:={ Command: "cm_MultiRenameFiles", Type: "工具", Comment: "批量重命名工具"}
    TCCmdMap["id506"]:={ Command: "cm_SysInfo", Type: "工具", Comment: "系统信息"}
    TCCmdMap["id559"]:={ Command: "cm_OpenTransferManager", Type: "工具", Comment: "后台传输管理器"}
    TCCmdMap["id501"]:={ Command: "cm_SearchFor", Type: "工具", Comment: "搜索文件"}
    TCCmdMap["id517"]:={ Command: "cm_SearchForInCurDir", Type: "工具", Comment: "搜索文件(光标下的文件夹)"}
    TCCmdMap["id545"]:={ Command: "cm_SearchStandalone", Type: "工具", Comment: "搜索文件(单独进程)"}
    TCCmdMap["id2020"]:={ Command: "cm_FileSync", Type: "工具", Comment: "同步文件夹"}
    TCCmdMap["id507"]:={ Command: "cm_Associate", Type: "工具", Comment: "文件关联"}
    TCCmdMap["id519"]:={ Command: "cm_InternalAssociate", Type: "工具", Comment: "内部关联"}
    TCCmdMap["id2022"]:={ Command: "cm_CompareFilesByContent", Type: "工具", Comment: "比较文件内容"}
    TCCmdMap["id2040"]:={ Command: "cm_IntCompareFilesByContent", Type: "工具", Comment: "使用内置的比较工具"}
    TCCmdMap["id2924"]:={ Command: "cm_CommandBrowser", Type: "工具", Comment: "浏览内部命令"}
    TCCmdMap["id2941"]:={ Command: "cm_SeparateQuickView", Type: "工具", Comment: "以独立窗口打开快速查看"}
    TCCmdMap["id2942"]:={ Command: "cm_SeparateQuickInternalOnly", Type: "工具", Comment: "以独立窗口打开快速查看(不使用插件)"}
    TCCmdMap["id2946"]:={ Command: "cm_UpdateQuickView", Type: "工具", Comment: "快速查看重新加载文件"}
    TCCmdMap["id2901"]:={ Command: "cm_VisButtonBar", Type: "查看", Comment: "显示/隐藏：工具栏"}
    TCCmdMap["id2944"]:={ Command: "cm_VisButtonBar2", Type: "查看", Comment: "显示/隐藏：垂直工具栏"}
    TCCmdMap["id2902"]:={ Command: "cm_VisDriveButtons", Type: "查看", Comment: "显示/隐藏：驱动器按钮栏"}
    TCCmdMap["id2903"]:={ Command: "cm_VisTwoDriveButtons", Type: "查看", Comment: "显示/隐藏：两个驱动器按钮栏"}
    TCCmdMap["id2904"]:={ Command: "cm_VisFlatDriveButtons", Type: "查看", Comment: "按钮：扁平/普通模式"}
    TCCmdMap["id2905"]:={ Command: "cm_VisFlatInterface", Type: "查看", Comment: "界面：扁平/普通模式"}
    TCCmdMap["id2906"]:={ Command: "cm_VisDriveCombo", Type: "查看", Comment: "显示/隐藏：驱动器列表栏"}
    TCCmdMap["id2907"]:={ Command: "cm_VisCurDir", Type: "查看", Comment: "显示/隐藏：路径栏"}
    TCCmdMap["id2926"]:={ Command: "cm_VisBreadCrumbs", Type: "查看", Comment: "显示//隐藏：痕迹导航模式"}
    TCCmdMap["id2908"]:={ Command: "cm_VisTabHeader", Type: "查看", Comment: "显示/隐藏：列标题"}
    TCCmdMap["id2909"]:={ Command: "cm_VisStatusbar", Type: "查看", Comment: "显示/隐藏：状态栏"}
    TCCmdMap["id2910"]:={ Command: "cm_VisCmdLine", Type: "查看", Comment: "显示/隐藏：命令行"}
    TCCmdMap["id2911"]:={ Command: "cm_VisKeyButtons", Type: "查看", Comment: "显示/隐藏：功能键按钮"}
    TCCmdMap["id2914"]:={ Command: "cm_ShowHint", Type: "查看", Comment: "显示文件提示信息"}
    TCCmdMap["id2915"]:={ Command: "cm_ShowQuickSearch", Type: "查看", Comment: "显示快速搜索框"}
    TCCmdMap["id3018"]:={ Command: "cm_QuickSearch", Type: "查看", Comment: "显示快速搜索框(关闭快速过滤)"}
    TCCmdMap["id3019"]:={ Command: "cm_QuickFilter", Type: "查看", Comment: "显示快速搜索框(开启快速过滤)"}
    TCCmdMap["id305"]:={ Command: "cm_VerticalPanels", Type: "查看", Comment: "水平面板模式"}
    TCCmdMap["id2010"]:={ Command: "cm_SwitchLongNames", Type: "查看", Comment: "开启/关闭：长文件名显示"}
    TCCmdMap["id540"]:={ Command: "cm_RereadSource", Type: "查看", Comment: "刷新源面板"}
    TCCmdMap["id2023"]:={ Command: "cm_ShowOnlySelected", Type: "查看", Comment: "隐藏未选中的文件"}
    TCCmdMap["id2011"]:={ Command: "cm_SwitchHidSys", Type: "查看", Comment: "开启/关闭：隐藏文件/系统文件显示"}
    TCCmdMap["id3013"]:={ Command: "cm_SwitchHid", Type: "查看", Comment: "开启/关闭：隐藏文件显示"}
    TCCmdMap["id3014"]:={ Command: "cm_SwitchSys", Type: "查看", Comment: "开启/关闭：系统文件显示"}
    TCCmdMap["id2013"]:={ Command: "cm_Switch83Names", Type: "查看", Comment: "开启/关闭：8.3文件名小写显示"}
    TCCmdMap["id2012"]:={ Command: "cm_SwitchDirSort", Type: "查看", Comment: "开启/关闭：文件夹按名称排序"}
    TCCmdMap["id2026"]:={ Command: "cm_DirBranch", Type: "查看", Comment: "平面视图(所有文件和文件夹)"}
    TCCmdMap["id2046"]:={ Command: "cm_DirBranchSel", Type: "查看", Comment: "平面视图(仅限选定的文件和文件夹)"}
    TCCmdMap["id909"]:={ Command: "cm_50Percent", Type: "查看", Comment: "窗口分割比例50%"}
    TCCmdMap["id910"]:={ Command: "cm_100Percent", Type: "查看", Comment: "窗口分割比例100%"}
    TCCmdMap["id2916"]:={ Command: "cm_VisDirTabs", Type: "查看", Comment: "显示/隐藏：文件夹标签"}
    TCCmdMap["id2923"]:={ Command: "cm_VisXPthemeBackground", Type: "查看", Comment: "显示/隐藏：P主题背景"}
    TCCmdMap["id2917"]:={ Command: "cm_SwitchOverlayIcons", Type: "查看", Comment: "开启/关闭：覆盖图标显示"}
    TCCmdMap["id2919"]:={ Command: "cm_VisHistHotButtons", Type: "查看", Comment: "显示/隐藏：文件夹历史记录和常用文件夹按扭"}
    TCCmdMap["id2921"]:={ Command: "cm_SwitchWatchDirs", Type: "查看", Comment: "开启/关闭：文件夹自动刷新"}
    TCCmdMap["id2922"]:={ Command: "cm_SwitchIgnoreList", Type: "查看", Comment: "开启/关闭：忽略列表"}
    TCCmdMap["id2925"]:={ Command: "cm_SwitchX64Redirection", Type: "查看", Comment: "开启/关闭：System32重定向到SysW0W64"}
    TCCmdMap["id3200"]:={ Command: "cm_SeparateTreeOff", Type: "查看", Comment: "关闭导航窗格"}
    TCCmdMap["id3201"]:={ Command: "cm_SeparateTree1", Type: "查看", Comment: "一个导航窗格"}
    TCCmdMap["id3202"]:={ Command: "cm_SeparateTree2", Type: "查看", Comment: "两个导航窗格"}
    TCCmdMap["id3203"]:={ Command: "cm_SwitchSeparateTree", Type: "查看", Comment: "切换导航窗格状态"}
    TCCmdMap["id3204"]:={ Command: "cm_ToggleSeparateTree1", Type: "查看", Comment: "开启/关闭：一个导航窗格"}
    TCCmdMap["id3205"]:={ Command: "cm_ToggleSeparateTree2", Type: "查看", Comment: "开启/关闭：两个导航窗格"}
    TCCmdMap["id2948"]:={ Command: "cm_ChangeArchiveEncoding", Type: "查看", Comment: "显示文件名编码菜单"}
    TCCmdMap["id2950"]:={ Command: "cm_SwitchDarkMode", Type: "查看", Comment: "开启/关闭：深色模式"}
    TCCmdMap["id2951"]:={ Command: "cm_EnableDarkMode", Type: "查看", Comment: "开启深色模式"}
    TCCmdMap["id2952"]:={ Command: "cm_DisableDarkMode", Type: "查看", Comment: "关闭深色模式"}
    TCCmdMap["id2957"]:={ Command: "cm_SwitchColorsByFileType", Type: "查看", Comment: "开启/关闭：颜色筛选器"}
    TCCmdMap["id2959"]:={ Command: "cm_SwitchFileTipWindows", Type: "查看", Comment: "开启/关闭：文件提示信息"}
    TCCmdMap["id2953"]:={ Command: "cm_ZoomIn", Type: "查看", Comment: "放大缩略图(最大200%)"}
    TCCmdMap["id2954"]:={ Command: "cm_ZoomOut", Type: "查看", Comment: "缩小缩略图(最小10%)"}
    TCCmdMap["id701"]:={ Command: "cm_UserMenu1", Type: "用户命令", Comment: "启动开始菜单第1项"}
    TCCmdMap["id702"]:={ Command: "cm_UserMenu2", Type: "用户命令", Comment: "启动开始菜单第2项"}
    TCCmdMap["id703"]:={ Command: "cm_UserMenu3", Type: "用户命令", Comment: "启动开始菜单第3项"}
    TCCmdMap["id704"]:={ Command: "cm_UserMenu4", Type: "用户命令", Comment: "启动开始菜单第4项"}
    TCCmdMap["id705"]:={ Command: "cm_UserMenu5", Type: "用户命令", Comment: "启动开始菜单第5项"}
    TCCmdMap["id706"]:={ Command: "cm_UserMenu6", Type: "用户命令", Comment: "启动开始菜单第6项"}
    TCCmdMap["id707"]:={ Command: "cm_UserMenu7", Type: "用户命令", Comment: "启动开始菜单第7项"}
    TCCmdMap["id708"]:={ Command: "cm_UserMenu8", Type: "用户命令", Comment: "启动开始菜单第8项"}
    TCCmdMap["id709"]:={ Command: "cm_UserMenu9", Type: "用户命令", Comment: "启动开始菜单第9项"}
    TCCmdMap["id710"]:={ Command: "cm_UserMenu10", Type: "用户命令", Comment: "启动开始菜单第10项"}
    TCCmdMap["id…"]:={ Command: "cm_UserMenu…", Type: "用户命令", Comment: "启动开始菜单第...项"}
    TCCmdMap["id899"]:={ Command: "cm_UserMenu199", Type: "用户命令", Comment: "启动开始菜单第899项"}
    TCCmdMap["id3001"]:={ Command: "cm_OpenNewTab", Type: "文件夹标签", Comment: "新建标签"}
    TCCmdMap["id3002"]:={ Command: "cm_OpenNewTabBg", Type: "文件夹标签", Comment: "新建标签(后台显示)"}
    TCCmdMap["id3027"]:={ Command: "cm_OpenNewTabOther", Type: "文件夹标签", Comment: "新建标签(另一侧面板)"}
    TCCmdMap["id3028"]:={ Command: "cm_OpenNewTabBgOther", Type: "文件夹标签", Comment: "新建标签(另一侧面板后台显示)"}
    TCCmdMap["id3003"]:={ Command: "cm_OpenDirInNewTab", Type: "文件夹标签", Comment: "在新标签打开光标下的文件夹(当前面板)"}
    TCCmdMap["id3004"]:={ Command: "cm_OpenDirInNewTabOther", Type: "文件夹标签", Comment: "在新标签打开光标下的文件夹(另一侧面板)"}
    TCCmdMap["id3005"]:={ Command: "cm_SwitchToNextTab", Type: "文件夹标签", Comment: "下一个标签(Cltr+Tab)"}
    TCCmdMap["id3006"]:={ Command: "cm_SwitchToPreviousTab", Type: "文件夹标签", Comment: "上一个标签(Cltr+Shift+Tab)"}
    TCCmdMap["id3015"]:={ Command: "cm_MoveTabLeft", Type: "文件夹标签", Comment: "向左移动当前标签"}
    TCCmdMap["id3016"]:={ Command: "cm_MoveTabRight", Type: "文件夹标签", Comment: "向右移动当前标签"}
    TCCmdMap["id3007"]:={ Command: "cm_CloseCurrentTab", Type: "文件夹标签", Comment: "关闭标签"}
    TCCmdMap["id3008"]:={ Command: "cm_CloseAllTabs", Type: "文件夹标签", Comment: "关闭所有标签"}
    TCCmdMap["id3017"]:={ Command: "cm_CloseDuplicateTabs", Type: "文件夹标签", Comment: "关闭重复的标签"}
    TCCmdMap["id3009"]:={ Command: "cm_DirTabsShowMenu", Type: "文件夹标签", Comment: "显示文件夹标签菜单"}
    TCCmdMap["id3024"]:={ Command: "cm_RenameTab", Type: "文件夹标签", Comment: "重命名当前标签"}
    TCCmdMap["id3010"]:={ Command: "cm_ToggleLockCurrentTab", Type: "文件夹标签", Comment: "开启/关闭：标签锁定"}
    TCCmdMap["id3012"]:={ Command: "cm_ToggleLockDcaCurrentTab", Type: "文件夹标签", Comment: "开启/关闭：标签锁定(可切换文件夹)"}
    TCCmdMap["id3029"]:={ Command: "cm_SetTabOptionNormal", Type: "文件夹标签", Comment: "解锁标签"}
    TCCmdMap["id3030"]:={ Command: "cm_SetTabOptionPathLocked", Type: "文件夹标签", Comment: "锁定标签"}
    TCCmdMap["id3031"]:={ Command: "cm_SetTabOptionPathResets", Type: "文件夹标签", Comment: "锁定标签(可切换文件夹)"}
    TCCmdMap["id3032"]:={ Command: "cm_SetAllTabsOptionNormal", Type: "文件夹标签", Comment: "解锁所有标签"}
    TCCmdMap["id3033"]:={ Command: "cm_SetAllTabsOptionPathLocked", Type: "文件夹标签", Comment: "锁定所有标签"}
    TCCmdMap["id3034"]:={ Command: "cm_SetAllTabsOptionPathResets", Type: "文件夹标签", Comment: "锁定所有标签(可切换文件夹)"}
    TCCmdMap["id535"]:={ Command: "cm_ExchangeWithTabs", Type: "文件夹标签", Comment: "交换所有标签"}
    TCCmdMap["id3011"]:={ Command: "cm_GoToLockedDir", Type: "文件夹标签", Comment: "回到锁定标签的原始文件夹"}
    TCCmdMap["id5515"]:={ Command: "cm_SrcTabsList", Type: "文件夹标签", Comment: "源面板：显示标签列表"}
    TCCmdMap["id5516"]:={ Command: "cm_TrgTabsList", Type: "文件夹标签", Comment: "目标面板：显示标签列耒"}
    TCCmdMap["id5517"]:={ Command: "cm_LeftTabsList", Type: "文件夹标签", Comment: "左侧面板：显示标签列表"}
    TCCmdMap["id5518"]:={ Command: "cm_RightTabsList", Type: "文件夹标签", Comment: "右侧面板：显示标签列表"}
    TCCmdMap["id5001"]:={ Command: "cm_SrcActivateTab1", Type: "文件夹标签", Comment: "源面板：切换到第1个标签"}
    TCCmdMap["id5002"]:={ Command: "cm_SrcActivateTab2", Type: "文件夹标签", Comment: "源面板：切换到第2个标签"}
    TCCmdMap["id5003"]:={ Command: "cm_SrcActivateTab3", Type: "文件夹标签", Comment: "源面板：切换到第3个标签"}
    TCCmdMap["id5004"]:={ Command: "cm_SrcActivateTab4", Type: "文件夹标签", Comment: "源面板：切换到第4个标签"}
    TCCmdMap["id5005"]:={ Command: "cm_SrcActivateTab5", Type: "文件夹标签", Comment: "源面板：切换到第5个标签"}
    TCCmdMap["id5006"]:={ Command: "cm_SrcActivateTab6", Type: "文件夹标签", Comment: "源面板：切换到第6个标签"}
    TCCmdMap["id5007"]:={ Command: "cm_SrcActivateTab7", Type: "文件夹标签", Comment: "源面板：切换到第7个标签"}
    TCCmdMap["id5008"]:={ Command: "cm_SrcActivateTab8", Type: "文件夹标签", Comment: "源面板：切换到第8个标签"}
    TCCmdMap["id5009"]:={ Command: "cm_SrcActivateTab9", Type: "文件夹标签", Comment: "源面板：切换到第9个标签"}
    TCCmdMap["id5010"]:={ Command: "cm_SrcActivateTab10", Type: "文件夹标签", Comment: "源面板：切换到第10个标签"}
    TCCmdMap["id50.."]:={ Command: "cm_SrcActivateTab..", Type: "文件夹标签", Comment: "源面板：切换到第..个标签"}
    TCCmdMap["id5099"]:={ Command: "cm_SrcActivateTab99", Type: "文件夹标签", Comment: "源面板：切换到第99个标签"}
    TCCmdMap["id5101"]:={ Command: "cm_TrgActivateTab1", Type: "文件夹标签", Comment: "目标面板：切换到第1个标签"}
    TCCmdMap["id5102"]:={ Command: "cm_TrgActivateTab2", Type: "文件夹标签", Comment: "目标面板：切换到第2个标签"}
    TCCmdMap["id5103"]:={ Command: "cm_TrgActivateTab3", Type: "文件夹标签", Comment: "目标面板：切换到第3个标签"}
    TCCmdMap["id5104"]:={ Command: "cm_TrgActivateTab4", Type: "文件夹标签", Comment: "目标面板：切换到第4个标签"}
    TCCmdMap["id5105"]:={ Command: "cm_TrgActivateTab5", Type: "文件夹标签", Comment: "目标面板：切换到第5个标签"}
    TCCmdMap["id5106"]:={ Command: "cm_TrgActivateTab6", Type: "文件夹标签", Comment: "目标面板：切换到第6个标签"}
    TCCmdMap["id5107"]:={ Command: "cm_TrgActivateTab7", Type: "文件夹标签", Comment: "目标面板：切换到第7个标签"}
    TCCmdMap["id5108"]:={ Command: "cm_TrgActivateTab8", Type: "文件夹标签", Comment: "目标面板：切换到第8个标签"}
    TCCmdMap["id5109"]:={ Command: "cm_TrgActivateTab9", Type: "文件夹标签", Comment: "目标面板：切换到第9个标签"}
    TCCmdMap["id5110"]:={ Command: "cm_TrgActivateTab10", Type: "文件夹标签", Comment: "目标面板：切换到第10个标签"}
    TCCmdMap["id51.."]:={ Command: "cm_TrgActivateTab..", Type: "文件夹标签", Comment: "目标面板：切换到第..个标签"}
    TCCmdMap["id5199"]:={ Command: "cm_TrgActivateTab99", Type: "文件夹标签", Comment: "目标面板：切换到第99个标签"}
    TCCmdMap["id5201"]:={ Command: "cm_LeftActivateTab1", Type: "文件夹标签", Comment: "左侧面板：切换到第1个标签"}
    TCCmdMap["id5202"]:={ Command: "cm_LeftActivateTab2", Type: "文件夹标签", Comment: "左侧面板：切换到第2个标签"}
    TCCmdMap["id5203"]:={ Command: "cm_LeftActivateTab3", Type: "文件夹标签", Comment: "左侧面板：切换到第3个标签"}
    TCCmdMap["id5204"]:={ Command: "cm_LeftActivateTab4", Type: "文件夹标签", Comment: "左侧面板：切换到第4个标签"}
    TCCmdMap["id5205"]:={ Command: "cm_LeftActivateTab5", Type: "文件夹标签", Comment: "左侧面板：切换到第5个标签"}
    TCCmdMap["id5206"]:={ Command: "cm_LeftActivateTab6", Type: "文件夹标签", Comment: "左侧面板：切换到第6个标签"}
    TCCmdMap["id5207"]:={ Command: "cm_LeftActivateTab7", Type: "文件夹标签", Comment: "左侧面板：切换到第7个标签"}
    TCCmdMap["id5208"]:={ Command: "cm_LeftActivateTab8", Type: "文件夹标签", Comment: "左侧面板：切换到第8个标签"}
    TCCmdMap["id5209"]:={ Command: "cm_LeftActivateTab9", Type: "文件夹标签", Comment: "左侧面板：切换到第9个标签"}
    TCCmdMap["id5210"]:={ Command: "cm_LeftActivateTab10", Type: "文件夹标签", Comment: "左侧面板：切换到第10个标签"}
    TCCmdMap["id52.."]:={ Command: "cm_LeftActivateTab..", Type: "文件夹标签", Comment: "左侧面板：切换到第..个标签"}
    TCCmdMap["id5299"]:={ Command: "cm_LeftActivateTab99", Type: "文件夹标签", Comment: "左侧面板：切换到第99个标签"}
    TCCmdMap["id5301"]:={ Command: "cm_RightActivateTab1", Type: "文件夹标签", Comment: "右侧面板：切换到第1个标签"}
    TCCmdMap["id5302"]:={ Command: "cm_RightActivateTab2", Type: "文件夹标签", Comment: "右侧面板：切换到第2个标签"}
    TCCmdMap["id5303"]:={ Command: "cm_RightActivateTab3", Type: "文件夹标签", Comment: "右侧面板：切换到第3个标签"}
    TCCmdMap["id5304"]:={ Command: "cm_RightActivateTab4", Type: "文件夹标签", Comment: "右侧面板：切换到第4个标签"}
    TCCmdMap["id5305"]:={ Command: "cm_RightActivateTab5", Type: "文件夹标签", Comment: "右侧面板：切换到第5个标签"}
    TCCmdMap["id5306"]:={ Command: "cm_RightActivateTab6", Type: "文件夹标签", Comment: "右侧面板：切换到第6个标签"}
    TCCmdMap["id5307"]:={ Command: "cm_RightActivateTab7", Type: "文件夹标签", Comment: "右侧面板：切换到第7个标签"}
    TCCmdMap["id5308"]:={ Command: "cm_RightActivateTab8", Type: "文件夹标签", Comment: "右侧面板：切换到第8个标签"}
    TCCmdMap["id5309"]:={ Command: "cm_RightActivateTab9", Type: "文件夹标签", Comment: "右侧面板：切换到第9个标签"}
    TCCmdMap["id5310"]:={ Command: "cm_RightActivateTab10", Type: "文件夹标签", Comment: "右侧面板：切换到第10个标签"}
    TCCmdMap["id53.."]:={ Command: "cm_RightActivateTab..", Type: "文件夹标签", Comment: "右侧面板：切换到第..个标签"}
    TCCmdMap["id5399"]:={ Command: "cm_RightActivateTab99", Type: "文件夹标签", Comment: "右侧面板：切换到第99个标签"}
    TCCmdMap["id6001"]:={ Command: "cm_SrcSortByCol1", Type: "排序", Comment: "源面板：按第1列排序"}
    TCCmdMap["id6002"]:={ Command: "cm_SrcSortByCol2", Type: "排序", Comment: "源面板：按第2列排序"}
    TCCmdMap["id6003"]:={ Command: "cm_SrcSortByCol3", Type: "排序", Comment: "源面板：按第3列排序"}
    TCCmdMap["id6004"]:={ Command: "cm_SrcSortByCol4", Type: "排序", Comment: "源面板：按第4列排序"}
    TCCmdMap["id6005"]:={ Command: "cm_SrcSortByCol5", Type: "排序", Comment: "源面板：按第5列排序"}
    TCCmdMap["id6006"]:={ Command: "cm_SrcSortByCol6", Type: "排序", Comment: "源面板：按第6列排序"}
    TCCmdMap["id6007"]:={ Command: "cm_SrcSortByCol7", Type: "排序", Comment: "源面板：按第7列排序"}
    TCCmdMap["id6008"]:={ Command: "cm_SrcSortByCol8", Type: "排序", Comment: "源面板：按第8列排序"}
    TCCmdMap["id6009"]:={ Command: "cm_SrcSortByCol9", Type: "排序", Comment: "源面板：按第9列排序"}
    TCCmdMap["id6010"]:={ Command: "cm_SrcSortByCol10", Type: "排序", Comment: "源面板：按第10列排序"}
    TCCmdMap["id60.."]:={ Command: "cm_SrcSortByCol..", Type: "排序", Comment: "源面板：按第..列排序"}
    TCCmdMap["id6099"]:={ Command: "cm_SrcSortByCol99", Type: "排序", Comment: "源面板：按第99列排序"}
    TCCmdMap["id6101"]:={ Command: "cm_TrgSortByCol1", Type: "排序", Comment: "目标面板：按第1列排序"}
    TCCmdMap["id6102"]:={ Command: "cm_TrgSortByCol2", Type: "排序", Comment: "目标面板：按第2列排序"}
    TCCmdMap["id6103"]:={ Command: "cm_TrgSortByCol3", Type: "排序", Comment: "目标面板：按第3列排序"}
    TCCmdMap["id6104"]:={ Command: "cm_TrgSortByCol4", Type: "排序", Comment: "目标面板：按第4列排序"}
    TCCmdMap["id6105"]:={ Command: "cm_TrgSortByCol5", Type: "排序", Comment: "目标面板：按第5列排序"}
    TCCmdMap["id6106"]:={ Command: "cm_TrgSortByCol6", Type: "排序", Comment: "目标面板：按第6列排序"}
    TCCmdMap["id6107"]:={ Command: "cm_TrgSortByCol7", Type: "排序", Comment: "目标面板：按第7列排序"}
    TCCmdMap["id6108"]:={ Command: "cm_TrgSortByCol8", Type: "排序", Comment: "目标面板：按第8列排序"}
    TCCmdMap["id6109"]:={ Command: "cm_TrgSortByCol9", Type: "排序", Comment: "目标面板：按第9列排序"}
    TCCmdMap["id6110"]:={ Command: "cm_TrgSortByCol10", Type: "排序", Comment: "目标面板：按第10列排序"}
    TCCmdMap["id61.."]:={ Command: "cm_TrgSortByCol..", Type: "排序", Comment: "目标面板：按第..列排序"}
    TCCmdMap["id6199"]:={ Command: "cm_TrgSortByCol99", Type: "排序", Comment: "目标面板：按第99列排序"}
    TCCmdMap["id6201"]:={ Command: "cm_LeftSortByCol1", Type: "排序", Comment: "左侧面板：按第1列排序"}
    TCCmdMap["id6202"]:={ Command: "cm_LeftSortByCol2", Type: "排序", Comment: "左侧面板：按第2列排序"}
    TCCmdMap["id6203"]:={ Command: "cm_LeftSortByCol3", Type: "排序", Comment: "左侧面板：按第3列排序"}
    TCCmdMap["id6204"]:={ Command: "cm_LeftSortByCol4", Type: "排序", Comment: "左侧面板：按第4列排序"}
    TCCmdMap["id6205"]:={ Command: "cm_LeftSortByCol5", Type: "排序", Comment: "左侧面板：按第5列排序"}
    TCCmdMap["id6206"]:={ Command: "cm_LeftSortByCol6", Type: "排序", Comment: "左侧面板：按第6列排序"}
    TCCmdMap["id6207"]:={ Command: "cm_LeftSortByCol7", Type: "排序", Comment: "左侧面板：按第7列排序"}
    TCCmdMap["id6208"]:={ Command: "cm_LeftSortByCol8", Type: "排序", Comment: "左侧面板：按第8列排序"}
    TCCmdMap["id6209"]:={ Command: "cm_LeftSortByCol9", Type: "排序", Comment: "左侧面板：按第9列排序"}
    TCCmdMap["id6210"]:={ Command: "cm_LeftSortByCol10", Type: "排序", Comment: "左侧面板：按第10列排序"}
    TCCmdMap["id62.."]:={ Command: "cm_LeftSortByCol..", Type: "排序", Comment: "左侧面板：按第..列排序"}
    TCCmdMap["id6299"]:={ Command: "cm_LeftSortByCol99", Type: "排序", Comment: "左侧面板：按第99列排序"}
    TCCmdMap["id6301"]:={ Command: "cm_RightSortByCol1", Type: "排序", Comment: "右侧面板：按第1列排序"}
    TCCmdMap["id6302"]:={ Command: "cm_RightSortByCol2", Type: "排序", Comment: "右侧面板：按第2列排序"}
    TCCmdMap["id6303"]:={ Command: "cm_RightSortByCol3", Type: "排序", Comment: "右侧面板：按第3列排序"}
    TCCmdMap["id6304"]:={ Command: "cm_RightSortByCol4", Type: "排序", Comment: "右侧面板：按第4列排序"}
    TCCmdMap["id6305"]:={ Command: "cm_RightSortByCol5", Type: "排序", Comment: "右侧面板：按第5列排序"}
    TCCmdMap["id6306"]:={ Command: "cm_RightSortByCol6", Type: "排序", Comment: "右侧面板：按第6列排序"}
    TCCmdMap["id6307"]:={ Command: "cm_RightSortByCol7", Type: "排序", Comment: "右侧面板：按第7列排序"}
    TCCmdMap["id6308"]:={ Command: "cm_RightSortByCol8", Type: "排序", Comment: "右侧面板：按第8列排序"}
    TCCmdMap["id6309"]:={ Command: "cm_RightSortByCol9", Type: "排序", Comment: "右侧面板：按第9列排序"}
    TCCmdMap["id6310"]:={ Command: "cm_RightSortByCol10", Type: "排序", Comment: "右侧面板：按第10列排序"}
    TCCmdMap["id63.."]:={ Command: "cm_RightSortByCol..", Type: "排序", Comment: "右侧面板：按第..列排序"}
    TCCmdMap["id6399"]:={ Command: "cm_RightSortByCol99", Type: "排序", Comment: "右侧面板：按第99列排序"}
    TCCmdMap["id271"]:={ Command: "cm_SrcCustomView1", Type: "自定义列", Comment: "源面板：切换到自定义视图1"}
    TCCmdMap["id272"]:={ Command: "cm_SrcCustomView2", Type: "自定义列", Comment: "源面板：切换到自定义视图2"}
    TCCmdMap["id273"]:={ Command: "cm_SrcCustomView3", Type: "自定义列", Comment: "源面板：切换到自定义视图3"}
    TCCmdMap["id274"]:={ Command: "cm_SrcCustomView4", Type: "自定义列", Comment: "源面板：切换到自定义视图4"}
    TCCmdMap["id275"]:={ Command: "cm_SrcCustomView5", Type: "自定义列", Comment: "源面板：切换到自定义视图5"}
    TCCmdMap["id276"]:={ Command: "cm_SrcCustomView6", Type: "自定义列", Comment: "源面板：切换到自定义视图6"}
    TCCmdMap["id277"]:={ Command: "cm_SrcCustomView7", Type: "自定义列", Comment: "源面板：切换到自定义视图7"}
    TCCmdMap["id278"]:={ Command: "cm_SrcCustomView8", Type: "自定义列", Comment: "源面板：切换到自定义视图8"}
    TCCmdMap["id279"]:={ Command: "cm_SrcCustomView9", Type: "自定义列", Comment: "源面板：切换到自定义视图9"}
    TCCmdMap["id280"]:={ Command: "cm_SrcCustomView10", Type: "自定义列", Comment: "源面板：切换到自定义视图10"}
    TCCmdMap["id2.."]:={ Command: "cm_SrcCustomView..", Type: "自定义列", Comment: "源面板：切换到自定义视图.."}
    TCCmdMap["id299"]:={ Command: "cm_SrcCustomView29", Type: "自定义列", Comment: "源面板：切换到自定义视图29"}
    TCCmdMap["id421"]:={ Command: "cm_TrgCustomView1", Type: "自定义列", Comment: "目标面板：切换到自定义视图1"}
    TCCmdMap["id422"]:={ Command: "cm_TrgCustomView2", Type: "自定义列", Comment: "目标面板：切换到自定义视图2"}
    TCCmdMap["id423"]:={ Command: "cm_TrgCustomView3", Type: "自定义列", Comment: "目标面板：切换到自定义视图3"}
    TCCmdMap["id424"]:={ Command: "cm_TrgCustomView4", Type: "自定义列", Comment: "目标面板：切换到自定义视图4"}
    TCCmdMap["id425"]:={ Command: "cm_TrgCustomView5", Type: "自定义列", Comment: "目标面板：切换到自定义视图5"}
    TCCmdMap["id426"]:={ Command: "cm_TrgCustomView6", Type: "自定义列", Comment: "目标面板：切换到自定义视图6"}
    TCCmdMap["id427"]:={ Command: "cm_TrgCustomView7", Type: "自定义列", Comment: "目标面板：切换到自定义视图7"}
    TCCmdMap["id428"]:={ Command: "cm_TrgCustomView8", Type: "自定义列", Comment: "目标面板：切换到自定义视图8"}
    TCCmdMap["id429"]:={ Command: "cm_TrgCustomView9", Type: "自定义列", Comment: "目标面板：切换到自定义视图9"}
    TCCmdMap["id430"]:={ Command: "cm_TrgCustomView10", Type: "自定义列", Comment: "目标面板：切换到自定义视图10"}
    TCCmdMap["id43.."]:={ Command: "cm_TrgCustomView..", Type: "自定义列", Comment: "目标面板：切换到自定义视图.."}
    TCCmdMap["id449"]:={ Command: "cm_TrgCustomView29", Type: "自定义列", Comment: "目标面板：切换到自定义视图29"}
    TCCmdMap["id71"]:={ Command: "cm_LeftCustomView1", Type: "自定义列", Comment: "左侧面板：切换到自定义视图1"}
    TCCmdMap["id72"]:={ Command: "cm_LeftCustomView2", Type: "自定义列", Comment: "左侧面板：切换到自定义视图2"}
    TCCmdMap["id73"]:={ Command: "cm_LeftCustomView3", Type: "自定义列", Comment: "左侧面板：切换到自定义视图3"}
    TCCmdMap["id74"]:={ Command: "cm_LeftCustomView4", Type: "自定义列", Comment: "左侧面板：切换到自定义视图4"}
    TCCmdMap["id75"]:={ Command: "cm_LeftCustomView5", Type: "自定义列", Comment: "左侧面板：切换到自定义视图5"}
    TCCmdMap["id76"]:={ Command: "cm_LeftCustomView6", Type: "自定义列", Comment: "左侧面板：切换到自定义视图6"}
    TCCmdMap["id77"]:={ Command: "cm_LeftCustomView7", Type: "自定义列", Comment: "左侧面板：切换到自定义视图7"}
    TCCmdMap["id78"]:={ Command: "cm_LeftCustomView8", Type: "自定义列", Comment: "左侧面板：切换到自定义视图8"}
    TCCmdMap["id79"]:={ Command: "cm_LeftCustomView9", Type: "自定义列", Comment: "左侧面板：切换到自定义视图9"}
    TCCmdMap["id80"]:={ Command: "cm_LeftCustomView10", Type: "自定义列", Comment: "左侧面板：切换到自定义视图10"}
    TCCmdMap["id.."]:={ Command: "cm_LeftCustomView..", Type: "自定义列", Comment: "左侧面板：切换到自定义视图.."}
    TCCmdMap["id99"]:={ Command: "cm_LeftCustomView29", Type: "自定义列", Comment: "左侧面板：切换到自定义视图29"}
    TCCmdMap["id171"]:={ Command: "cm_RightCustomView1", Type: "自定义列", Comment: "右侧面板：切换到自定义视图1"}
    TCCmdMap["id172"]:={ Command: "cm_RightCustomView2", Type: "自定义列", Comment: "右侧面板：切换到自定义视图2"}
    TCCmdMap["id173"]:={ Command: "cm_RightCustomView3", Type: "自定义列", Comment: "右侧面板：切换到自定义视图3"}
    TCCmdMap["id174"]:={ Command: "cm_RightCustomView4", Type: "自定义列", Comment: "右侧面板：切换到自定义视图4"}
    TCCmdMap["id175"]:={ Command: "cm_RightCustomView5", Type: "自定义列", Comment: "右侧面板：切换到自定义视图5"}
    TCCmdMap["id176"]:={ Command: "cm_RightCustomView6", Type: "自定义列", Comment: "右侧面板：切换到自定义视图6"}
    TCCmdMap["id177"]:={ Command: "cm_RightCustomView7", Type: "自定义列", Comment: "右侧面板：切换到自定义视图7"}
    TCCmdMap["id178"]:={ Command: "cm_RightCustomView8", Type: "自定义列", Comment: "右侧面板：切换到自定义视图8"}
    TCCmdMap["id179"]:={ Command: "cm_RightCustomView9", Type: "自定义列", Comment: "右侧面板：切换到自定义视图9"}
    TCCmdMap["id180"]:={ Command: "cm_RightCustomView10", Type: "自定义列", Comment: "右侧面板：切换到自定义视图10"}
    TCCmdMap["id1.."]:={ Command: "cm_RightCustomView..", Type: "自定义列", Comment: "右侧面板：切换到自定义视图.."}
    TCCmdMap["id199"]:={ Command: "cm_RightCustomView29", Type: "自定义列", Comment: "右侧面板：切换到自定义视图29"}
    TCCmdMap["id5501"]:={ Command: "cm_SrcNextCustomView", Type: "自定义列", Comment: "源面板：下一个自定义视图"}
    TCCmdMap["id5502"]:={ Command: "cm_SrcPrevCustomView", Type: "自定义列", Comment: "源面板：上一个自定义视图"}
    TCCmdMap["id5503"]:={ Command: "cm_TrgNextCustomView", Type: "自定义列", Comment: "目标面板：下一个自定义视图"}
    TCCmdMap["id5504"]:={ Command: "cm_TrgPrevCustomView", Type: "自定义列", Comment: "目标面板：上一个自定义视图"}
    TCCmdMap["id5505"]:={ Command: "cm_LeftNextCustomView", Type: "自定义列", Comment: "左侧面板：下一个自定义视图"}
    TCCmdMap["id5506"]:={ Command: "cm_LeftPrevCustomView", Type: "自定义列", Comment: "左侧面板：上一个自定义视图"}
    TCCmdMap["id5507"]:={ Command: "cm_RightNextCustomView", Type: "自定义列", Comment: "右侧面板：下一个自定义视图"}
    TCCmdMap["id5508"]:={ Command: "cm_RightPrevCustomView", Type: "自定义列", Comment: "右侧面板：上一个自定义视图"}
    TCCmdMap["id5512"]:={ Command: "cm_LoadAllOnDemandFields", Type: "自定义列", Comment: "所有文件都加载自定义字段"}
    TCCmdMap["id5513"]:={ Command: "cm_LoadSelOnDemandFields", Type: "自定义列", Comment: "仅所选文件加载自定义字段"}
    TCCmdMap["id5514"]:={ Command: "cm_ContentStopLoadFields", Type: "自定义列", Comment: "停止后台加载自定义字段"}
    TCCmdMap["id5510"]:={ Command: "cm_LeftSwitchToThisCustomView", Type: "自定义列", Comment: "设置左侧面板自定义视图(lparam=:视图号)"}
    TCCmdMap["id5511"]:={ Command: "cm_RightSwitchToThisCustomView", Type: "自定义列", Comment: "设置右侧面板自定义视图(lparam=:视图号)"}
    TCCmdMap["id2947"]:={ Command: "cm_ToggleAutoViewModeSwitch", Type: "查看模式", Comment: "开启/关闭：查看模式自动切换"}
    TCCmdMap["id8500"]:={ Command: "cm_SrcViewMode0", Type: "查看模式", Comment: "源面板：切换到默认查看模式(没有颜色或图标)"}
    TCCmdMap["id8501"]:={ Command: "cm_SrcViewMode1", Type: "查看模式", Comment: "源面板：切换到查看模式1"}
    TCCmdMap["id8502"]:={ Command: "cm_SrcViewMode2", Type: "查看模式", Comment: "源面板：切换到查看模式2"}
    TCCmdMap["id8503"]:={ Command: "cm_SrcViewMode3", Type: "查看模式", Comment: "源面板：切换到查看模式3"}
    TCCmdMap["id8504"]:={ Command: "cm_SrcViewMode4", Type: "查看模式", Comment: "源面板：切换到查看模式4"}
    TCCmdMap["id8505"]:={ Command: "cm_SrcViewMode5", Type: "查看模式", Comment: "源面板：切换到查看模式5"}
    TCCmdMap["id8506"]:={ Command: "cm_SrcViewMode6", Type: "查看模式", Comment: "源面板：切换到查看模式6"}
    TCCmdMap["id8507"]:={ Command: "cm_SrcViewMode7", Type: "查看模式", Comment: "源面板：切换到查看模式7"}
    TCCmdMap["id8508"]:={ Command: "cm_SrcViewMode8", Type: "查看模式", Comment: "源面板：切换到查看模式8"}
    TCCmdMap["id8509"]:={ Command: "cm_SrcViewMode9", Type: "查看模式", Comment: "源面板：切换到查看模式9"}
    TCCmdMap["id8510"]:={ Command: "cm_SrcViewMode10", Type: "查看模式", Comment: "源面板：切换到查看模式10"}
    TCCmdMap["id85.."]:={ Command: "cm_SrcViewMode…", Type: "查看模式", Comment: "源面板：切换到查看模式…"}
    TCCmdMap["id8749"]:={ Command: "cm_SrcViewMode249", Type: "查看模式", Comment: "源面板：切换到查看模式249"}
    TCCmdMap["id8750"]:={ Command: "cm_TrgViewMode0", Type: "查看模式", Comment: "目标面板：切换到默认查看模式(没有颜色或图标)"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode1", Type: "查看模式", Comment: "目标面板：切换到查看模式1"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode2", Type: "查看模式", Comment: "目标面板：切换到查看模式2"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode3", Type: "查看模式", Comment: "目标面板：切换到查看模式3"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode4", Type: "查看模式", Comment: "目标面板：切换到查看模式4"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode5", Type: "查看模式", Comment: "目标面板：切换到查看模式5"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode6", Type: "查看模式", Comment: "目标面板：切换到查看模式6"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode7", Type: "查看模式", Comment: "目标面板：切换到查看模式7"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode8", Type: "查看模式", Comment: "目标面板：切换到查看模式8"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode9", Type: "查看模式", Comment: "目标面板：切换到查看模式9"}
    TCCmdMap["id8751"]:={ Command: "cm_TrgViewMode10", Type: "查看模式", Comment: "目标面板：切换到查看模式10"}
    TCCmdMap["id87.."]:={ Command: "cm_TrgViewMode…", Type: "查看模式", Comment: "目标面板：切换到查看模式…"}
    TCCmdMap["id8999"]:={ Command: "cm_TrgViewMode249", Type: "查看模式", Comment: "目标面板：切换到查看模式249"}
    TCCmdMap["id8000"]:={ Command: "cm_LeftViewMode0", Type: "查看模式", Comment: "左侧面板：切换到默认查看模式(没有颜色或图标)"}
    TCCmdMap["id8001"]:={ Command: "cm_LeftViewMode1", Type: "查看模式", Comment: "左侧面板：切换到查看模式1"}
    TCCmdMap["id8002"]:={ Command: "cm_LeftViewMode2", Type: "查看模式", Comment: "左侧面板：切换到查看模式2"}
    TCCmdMap["id8003"]:={ Command: "cm_LeftViewMode3", Type: "查看模式", Comment: "左侧面板：切换到查看模式3"}
    TCCmdMap["id8004"]:={ Command: "cm_LeftViewMode4", Type: "查看模式", Comment: "左侧面板：切换到查看模式4"}
    TCCmdMap["id8005"]:={ Command: "cm_LeftViewMode5", Type: "查看模式", Comment: "左侧面板：切换到查看模式5"}
    TCCmdMap["id8006"]:={ Command: "cm_LeftViewMode6", Type: "查看模式", Comment: "左侧面板：切换到查看模式6"}
    TCCmdMap["id8007"]:={ Command: "cm_LeftViewMode7", Type: "查看模式", Comment: "左侧面板：切换到查看模式7"}
    TCCmdMap["id8008"]:={ Command: "cm_LeftViewMode8", Type: "查看模式", Comment: "左侧面板：切换到查看模式8"}
    TCCmdMap["id8009"]:={ Command: "cm_LeftViewMode9", Type: "查看模式", Comment: "左侧面板：切换到查看模式9"}
    TCCmdMap["id8010"]:={ Command: "cm_LeftViewMode10", Type: "查看模式", Comment: "左侧面板：切换到查看模式10"}
    TCCmdMap["id80.."]:={ Command: "cm_LeftViewMode…", Type: "查看模式", Comment: "左侧面板：切换到查看模式…"}
    TCCmdMap["id8249"]:={ Command: "cm_LeftViewMode249", Type: "查看模式", Comment: "左侧面板：切换到查看模式249"}
    TCCmdMap["id8250"]:={ Command: "cm_RightViewMode0", Type: "查看模式", Comment: "右侧面板：切换到默认查看模式(没有颜色或图标)"}
    TCCmdMap["id8251"]:={ Command: "cm_RightViewMode1", Type: "查看模式", Comment: "右侧面板：切换到查看模式1"}
    TCCmdMap["id8252"]:={ Command: "cm_RightViewMode2", Type: "查看模式", Comment: "右侧面板：切换到查看模式2"}
    TCCmdMap["id8253"]:={ Command: "cm_RightViewMode3", Type: "查看模式", Comment: "右侧面板：切换到查看模式3"}
    TCCmdMap["id8254"]:={ Command: "cm_RightViewMode4", Type: "查看模式", Comment: "右侧面板：切换到查看模式4"}
    TCCmdMap["id8255"]:={ Command: "cm_RightViewMode5", Type: "查看模式", Comment: "右侧面板：切换到查看模式5"}
    TCCmdMap["id8256"]:={ Command: "cm_RightViewMode6", Type: "查看模式", Comment: "右侧面板：切换到查看模式6"}
    TCCmdMap["id8257"]:={ Command: "cm_RightViewMode7", Type: "查看模式", Comment: "右侧面板：切换到查看模式7"}
    TCCmdMap["id8258"]:={ Command: "cm_RightViewMode8", Type: "查看模式", Comment: "右侧面板：切换到查看模式8"}
    TCCmdMap["id8259"]:={ Command: "cm_RightViewMode9", Type: "查看模式", Comment: "右侧面板：切换到查看模式9"}
    TCCmdMap["id8260"]:={ Command: "cm_RightViewMode10", Type: "查看模式", Comment: "右侧面板：切换到查看模式10"}
    TCCmdMap["id82.."]:={ Command: "cm_RightViewMode…", Type: "查看模式", Comment: "右侧面板：切换到查看模式…"}
    TCCmdMap["id8499"]:={ Command: "cm_RightViewMode249", Type: "查看模式", Comment: "右侧面板：切换到查看模式249"}
}
*/

#Include *i A_ScriptDir "\Lib\vimd_API.ahk"