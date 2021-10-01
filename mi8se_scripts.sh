#!/system/bin/sh
# Copyright (C) 2020-2021, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
## ADD: Amktiao 添加: 添加信息
# 此脚本基于MI 8 SE更改 内核版本为k4.9
## END: Amktiao 结束: 添加信息
#

## ADD: Amktiao添加: 注释 设置获取userdata分区变量 (f2fs需要)
## ADD: Amktiao添加: 设置获取userdata分区变量 (f2fs需要)
#userdata=$(getprop dev.mnt.blk.data)
## END: Amktiao结束: 设置获取userdata分区变量 (f2fs需要)
## END: Amktiao结束: 注释 设置获取userdata分区变量 (f2fs需要)
## ADD: Amktiao添加: 调整页面簇 (low-mem)
echo "0" > /proc/sys/vm/page-cluster
## END: Amktiao结束: 调整页面簇 (low-mem)
## ADD: Amktiao添加: 调整内存统计间隔 (默认为1, 也就是1秒)
# 调整内存统计间隔 (默认为1, 也就是1秒)
echo "20" > /proc/sys/vm/stat_interval
## END: Amktiao结束: 调整内存统计间隔 (默认为1, 也就是1秒)
## ADD: Amktiao添加: 禁用binder与分配工具的日志
# 禁用binder调试 (来自: kdrag0n)
## ADD: Amktiao添加: 禁用binder与分配工具的日志 (调整k4.9 4.4)
echo "0" > /sys/module/binder/parameters/debug_mask
## END: Amktiao结束: 禁用binder与分配工具的日志 (调整k4.9 4.4)
## END: Amktiao结束: 禁用binder与分配工具的日志
## ADD: Amktiao添加: 为ZRAM设备调整预读与NR参数 (zram0)
echo "128" > /sys/block/zram0/queue/read_ahead_kb
## END: Amktiao结束: 为ZRAM设备调整预读与NR参数 (zram0)
## ADD: Amktiao添加: 为主数据与系统分区调整预读与NR参数
## ADD: Amktiao添加: 为主数据与系统分区调整预读与NR参数 (调整 eMMC设备)
echo "128" > /sys/block/mmcblk0/queue/read_ahead_kb
## END: Amktiao结束: 为主数据与系统分区调整预读与NR参数 (调整 eMMC设备)
## END: Amktiao结束: 为主数据与系统分区调整预读与NR参数
## ADD: Amktiao添加: 为硬盘保护区域调整预读与NR参数
## ADD: Amktiao添加: 为硬盘保护区域调整预读与NR参数 (调整 eMMC设备)
echo "128" > /sys/block/mmcblk0rpmb/queue/read_ahead_kb
## END: Amktiao结束: 为硬盘保护区域调整预读与NR参数
## END: Amktiao结束: 为硬盘保护区域调整预读与NR参数 (调整 eMMC设备)
## ADD: Amktiao添加: 禁用MMC设备熵贡献 (固态硬盘不需要)
echo "0" > /sys/block/mmcblk0/queue/add_random
## END: Amktiao结束: 禁用MMC设备熵贡献 (固态硬盘不需要)
## ADD: Amktiao添加: 禁用MMC设备熵贡献 (固态硬盘不需要)
## ADD: Amktiao添加: 禁用MMC设备熵贡献 (固态硬盘不需要) (添加保护区域)
echo "0" > /sys/block/mmcblk0rpmb/queue/add_random
## END: Amktiao结束: 为硬盘保护区域调整预读与NR参数 (调整 eMMC设备)
## END: Amktiao结束: 为硬盘保护区域调整预读与NR参数 (调整 eMMC设备) (添加保护区域)
## ADD: Amktiao添加: 禁用动态LMK内存终止模式 (低内存需要)
echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
## END: Amktiao结束: 禁用动态LMK内存终止模式 (低内存需要)
## ADD: Amktiao添加: 仅保留内核日志 (kernel dmesg)
# 仅保留内核日志 (kernel dmesg)
echo "off" > /proc/sys/kernel/printk_devkmsg
## END: Amktiao结束: 仅保留内核日志 (kernel dmesg)
## ADD: Amktiao添加: 禁用 禁用sched_autogroup
# 禁用sched_autogroup (在移动端设备上无用)
echo "0" > /proc/sys/kernel/sched_autogroup_enabled
## END: Amktiao结束: 禁用 禁用sched_autogroup
## ADD: Amktiao添加: 禁用schedstats (sched)
# sched_schedstats:
# Enables/disables scheduler statistics. Enabling this feature
# incurs a small amount of overhead in the scheduler but is
# useful for debugging and performance tuning.
echo "0" > /proc/sys/kernel/sched_schedstats
## END: Amktiao结束: 禁用schedstats (sched)
## ADD: Amktiao添加: 清理小米杂项
# 删除不必要网络日志 (位于/data/vendor/wifi_logs)
stop cnss_diag
## ADD: Amktiao添加: 终止tcpdump进程
# 注意: 一些抓包工具可能会用到它.
stop tcpdump
## END: Amktiao结束: 终止tcpdump进程
rm -rf /data/vendor/wlan_logs
setprop sys.miui.ndcd off
## END: Amktiao结束: 清理小米杂项
