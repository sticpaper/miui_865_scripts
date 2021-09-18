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
