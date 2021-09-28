#! /vendor/bin/sh
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
#
# 该脚本只是为了 "尽可能" 的让官方内核也拥有些三方的内核更改优化
# 受限于内核与脚本的区别, 只能实现些微小的更改, 如果想获得大幅度提升,
# 还是建议您刷入第三方内核.
#
#   针对设备的注意事项:
#  因为用户大部分喜欢刷官改包, 官改包基本都是解密data状态,
#  所以您需要手动将脚本中的 "dm-5" 的字样替换为 "sda34" .
#

## ADD: Amktiao添加: 设置获取userdata分区变量 (f2fs需要)
userdata=$(getprop dev.mnt.blk.data)
## END: Amktiao结束: 设置获取userdata分区变量 (f2fs需要)
## ADD: Amktiao添加: 禁用sd<x>分区的I/O读写统计
# 禁用磁盘I/O统计 (来自: kdrag0n)
echo "0" > /sys/block/sda/queue/iostats
echo "0" > /sys/block/sdb/queue/iostats
echo "0" > /sys/block/sdc/queue/iostats
echo "0" > /sys/block/sdd/queue/iostats
echo "0" > /sys/block/sde/queue/iostats
echo "0" > /sys/block/sdf/queue/iostats
## END: Amktiao结束: 禁用sd<x>分区的I/O读写统计
## ADD: Amktiao添加: 禁用binder与分配工具的日志
# 禁用binder调试 (来自: kdrag0n)
echo "0" > /sys/module/binder/parameters/debug_mask
echo "0" > /sys/module/binder_alloc/parameters/debug_mask
## END: Amktiao结束: 禁用binder与分配工具的日志
## ADD: Amktiao添加: 禁用irq唤醒线程记录
# 注意: 此功能用于调试耗电记录
echo "0" > /sys/module/msm_show_resume_irq/parameters/debug_mask
## END: Amktiao结束: 禁用irq唤醒线程记录
## ADD: Amktiao添加: 禁用内核调试监视器 (self-hosted debug)
# 由于我们使用库存内核, 使用标志"nodebugmon" 是最好的
echo "N" > /sys/kernel/debug/debug_enabled
## END: Amktiao结束: 禁用内核调试监视器 (self-hosted debug)
## ADD: Amktiao添加: 为主数据与系统分区调整预读与NR参数 (sda-sde)
echo "128" > /sys/block/sda/queue/read_ahead_kb
echo "36" > /sys/block/sda/queue/nr_requests
echo "128" > /sys/block/sde/queue/read_ahead_kb
echo "36" > /sys/block/sde/queue/nr_requests
## END: Amktiao结束: 为主数据与系统分区调整预读与NR参数 (sda-sde)
## ADD: Amktiao添加: 为dm加密设备调整预读与NR参数 (userdata)
echo "128" > /sys/block/${userdata}/queue/read_ahead_kb
echo "36" > /sys/block/${userdata}/queue/nr_requests
## END: Amktiao结束: 为dm加密设备调整预读与NR参数 (userdata)

## ADD: Amktiao添加: 为ZRAM设备调整预读与NR参数 (zram0)
echo "128" > /sys/block/zram0/queue/read_ahead_kb
echo "36" > /sys/block/zram0/queue/nr_requests
## END: Amktiao结束: 为ZRAM设备调整预读与NR参数 (zram0)
## ADD: Amktiao添加: 调整页面簇 (low-mem)
echo "0" > /proc/sys/vm/page-cluster
## END: Amktiao结束: 调整页面簇 (low-mem)
## ADD: Amktiao添加: 禁用subsystem_ramdumps
# 禁用subsystem_ramdumps
echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps
## END: Amktiao结束: 禁用subsystem_ramdumps
## ADD: Amktiao添加: 仅保留内核日志 (kernel dmesg)
# 仅保留内核日志 (kernel dmesg)
echo "off" > /proc/sys/kernel/printk_devkmsg
## END: Amktiao结束: 仅保留内核日志 (kernel dmesg)
## ADD: Amktiao添加: 更改脏页回写时间 (30s 秒)
echo "3000" > /proc/sys/vm/dirty_expire_centisecs
## END: Amktiao结束: 更改脏页回写时间 (30s 秒)
## ADD: Amktiao添加: 禁用f2fs I/O数据收集统计 (用于调试)
# 禁用f2fs I/O数据收集统计 (用于调试, Android R 加入)
echo "0" > /sys/fs/f2fs/${userdata}/iostat_enable
## END: Amktiao结束: 禁用f2fs I/O数据收集统计 (用于调试)
