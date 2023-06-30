#!/bin/sh
# This is run by the kernel after the last task is removed from a
# control group in the openrc hierarchy.

# Copyright (c) 2007-2015 The OpenRC Authors.
# See the Authors file at the top-level directory of this distribution and
# https://github.com/OpenRC/openrc/blob/master/AUTHORS
#
# This file is part of OpenRC. It is subject to the license terms in
# the LICENSE file found in the top-level directory of this
# distribution and at https://github.com/OpenRC/openrc/blob/master/LICENSE
# This file may not be copied, modified, propagated, or distributed
#    except according to the terms contained in the LICENSE file.

cgroup=/sys/fs/cgroup/openrc
PATH=/bin:/usr/bin:/sbin:/usr/sbin
if [ -d ${cgroup}/"$1" ]; then
	rmdir ${cgroup}/"$1"
fi
