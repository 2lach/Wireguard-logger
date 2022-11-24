#!/bin/bash

#================================================#
# Author: Stefan Lachmann <2lach>
#
# Description:
# This project is a tiny logger for wireguard
#
# Created:
# 24 Nov 2022
#===============================================#

#=========#
# helpers #
#=========#

# verify tcpdump is installed
function is_installed() {
	if (hash "$1" 2>/dev/null); then
		# it is installed
		echo "$1: found"
	else
		echo "$1: found"
		echo "please install $1, then proceed"
		exit 0
	fi
}
is_installed "tcpdump"

# create wg folder if it doesn't exists
function path_exists() {
	if [ -d "$1" ]; then
		echo "$1 exist."
	else
		mkdir "$1"
	fi
}
path_exists "/var/log/wireguard"

function file_exists() {
	if [ -f "$1" ]; then
		echo "$1 exist."
	else
		touch "$1"
	fi
}

#===========#
# log files #
#===========#
WG_LOG="/var/log/wireguard/wireguard-tcpdump.log"
WG_LOG_VERBOSE="/var/log/wireguard/wireguard-verbose-tcpdump.log"
WG_TUNNEL_LOG="/var/log/wireguard/wireguard-tunnel-tcpdump.log"

#===============#
# logging modes #
#===============#

# least verbose logs
function info_log() {
	# will log the remote IP addresses that are connecting to your WireGuard interface
	file_exists $WG_LOG

	# The -tttt flag adds the date to the timestamp
	# The -n flag skips hostname lookups and -i any flag includes all interface

	tcpdump -ttttni any 'udp port 51820' >>$WG_LOG
}

# most verbose logs
function verbose_log() {
	file_exists $WG_LOG_VERBOSE
	# The -v  flag adds verbose mode and -e link-level header
	tcpdump -evvvttttni any 'udp port 51820' >>$WG_LOG
}

# log the packets that are sent inside the WireGuard tunnel
function tunnel_log() {
	file_exists $WG_TUNNEL_LOG
	# this assumes your wireguard instance is named: "wg0", if not change it to your instance name
	tcpdump -ttttni wg0 >>$WG_TUNNEL_LOG
}

##################
# Start logging  #
##################

# Check if tcpdump is running and do not create multiple instances of wireguard_logger
if pgrep -x "tcpdump" >/dev/null; then
	echo "tcpdump process is currently: Running"
	exit 0
else

	# no instance found running
	echo "Starting up wireguard-logger"

	# Do not run both single + parallell mode
	# use on mode meaning you either run a single instance or serveral in parallell

	# uncomment your selection below

	# run a single logging instance:
	# info_log

	# run several parallell instances
# {
#     info_log
#     verbose_log
#     tunnel_log
#} &

fi

# escape hatch if tcpdump goes haywire
function kill_wg_logger() {
	killall tcpdump
	wait
	# verify that it's not running
	pgrep -x "tcpdump"
}

# if you want to modify this project feel free :)

# the wireguard-logger is based on the article
# Four Ways to View WireGuard Logs By Justin Ludwig
# https://www.procustodibus.com/blog/2021/03/wireguard-logs/
