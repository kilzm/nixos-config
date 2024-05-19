# see https://github.com/ThatOneCalculator/NerdFetch
# MIT License
#
# Copyright (c) 2021-2024 Kainoa Kanter
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

{ pkgs, ... }:
let
  nerdfetch = pkgs.writeShellScriptBin "nerdfetch" ''
          ostype="$(uname)"

          version=8.1.1
          font=nerd
          distrotype=none
          osi=""
          ki=""
          ri="󰍛"
          pi="󰏔"
          ui="󰅶"
          ci=""

          case $1 in
          "-p")
          	font=phosphor
          	osi=""
          	ki=""
          	ri=""
          	pi=""
          	ui=""
          	ci=""
          	;;
          "-c")
          	font=cozette
          	ki="♥"
          	ri=""
          	pi=""
          	ui=""
          	ci=""
          	;;
          "-e")
            font=emoji
            osi="❄️"
            ki="🫀"
            ri="🧠"
            pi="📦"
            ui="⌛"
            ci="🎨";;
          "-v")
          	echo "NerdFetch $version"
          	exit
          	;;
          "-h")
          	echo "Flags:
          -c: Cozette font
          -p: Phosphor font
          -e: Emoji font
          -v: Version"
          	exit
          	;;
          esac

          if command -v getprop 1>/dev/null; then
          	distrotype=android
          fi
          kernel="$(uname -r)"
          case $ostype in
          *"Linux"*)
          	if [ $distrotype = android ]; then
          		host="$(hostname)"
          		USER="$(whoami)"
          		os="Android $(getprop ro.build.version.release)"
          		case $font in
          		phosphor) osi="" ;;
          		emoji) osi="🤖" ;;
          		*) osi="󰀲" ;;
          		esac
          	else
          		host="$(cat /proc/sys/kernel/hostname)"
          		. /etc/os-release
          		if [ -f /bedrock/etc/bedrock-release ]; then
          			os="$(brl version)"
          		else
          			os="''${PRETTY_NAME}"
          			if [ $font = nerd ]; then
          				case $(echo $ID | sed 's/ .*//') in
          				debian) osi="" ;;
          				arch) osi="󰣇" ;;
          				endeavouros) osi="" ;;
          				fedora) osi="" ;;
          				gentoo) osi="" ;;
          				rhel) osi="" ;;
          				slackware) osi="" ;;
          				void) osi="" ;;
          				alpine) osi="" ;;
          				nixos) osi="󱄅" ;;
          				artix) osi="" ;;
          				exherbo) osi="󰆚" ;;
          				mageia) osi="" ;;
          				manjaro) osi="" ;;
          				opensuse) osi="" ;;
          				solus) osi="" ;;
          				ubuntu) osi="" ;;
          				mint) osi="󰣭" ;;
          				trisquel) osi="" ;;
          				puppy) osi="" ;;
          				coreos) osi="" ;;
          				mx) osi="" ;;
          				vanilla) osi="" ;;
          				pop_os) osi="" ;;
          				raspbian) osi="" ;;
          				deepin) osi="" ;;
          				almalinux) osi="" ;;
          				garuda) osi="" ;;
          				centos) osi="" ;;
          				rocky) osi="" ;;
          				esac
          			elif [ $font = cozette ]; then
          				case $(echo $ID | sed 's/ .*//') in
          				debian) osi="" ;;
          				arch) osi="" ;;
          				fedora) osi="" ;;
          				gentoo) osi="" ;;
          				slackware) osi="" ;;
          				void) osi="" ;;
          				alpine) osi="" ;;
          				nixos) osi="" ;;
          				mageia) osi="" ;;
          				manjaro) osi="" ;;
          				opensuse) osi="" ;;
          				ubuntu) osi="" ;;
          				mint) osi="" ;;
          				coreos) osi="" ;;
          				centos) osi="" ;;
          				esac
          			fi
          		fi
          	fi
          	shell=$(basename "$SHELL")
          	;;
          *"Darwin"*)
          	host="$(hostname -f | sed -e 's/^[^.]*\.//')"
          	mac_product="$(/usr/libexec/PlistBuddy -c "Print:ProductName" /System/Library/CoreServices/SystemVersion.plist)"
          	mac_version="$(/usr/libexec/PlistBuddy -c "Print:ProductVersion" /System/Library/CoreServices/SystemVersion.plist)"
          	os="''${mac_product} ''${mac_version}"
          	case $font in
          	nerd) osi="" ;;
          	phosphor) osi="" ;;
          	cozette) osi="" ;;
          	emoji) osi="🍎" ;;
          	esac
          	;;
          *"FreeBSD"*)
          	host="$(hostname)"
          	distrotype=bsd
          	os="FreeBSD $(freebsd-version | sed 's/-.*//')"
          	case $font in
          	nerd) osi="" ;;
          	phosphor) osi="" ;;
          	cozette) osi="" ;;
          	emoji) osi="😈" ;;
          	esac
          	;;
          *"OpenBSD"*)
          	host="$(hostname)"
          	distrotype=bsd
          	os="OpenBSD $(uname -r)"
          	case $font in
          	nerd) osi="" ;;
          	phosphor) osi="" ;;
          	cozette) osi="⌘" ;;
          	emoji) osi="🐡" ;;
          	esac
          	;;
          *"NetBSD"*)
          	host="$(hostname)"
          	distrotype=netbsd
          	os="NetBSD $(uname -r)"
          	case $font in
          	nerd) osi="󰉀" ;;
          	phosphor) osi="" ;;
          	cozette) osi="" ;;
          	emoji) osi="🚩" ;;
          	esac
          	;;
          *)
          	os="Unix-like"
          	host="host"
          	;;
          esac

          ## PACKAGE MANAGER AND PACKAGES DETECTION

          MANAGER=$(which nix-env pkg flatpak yum zypper dnf rpm dpkg-query brew port pacman xbps-query emerge cave apk kiss pmm /usr/sbin/slackpkg bulge birb yay paru pacstall cpm pmm eopkg getprop 2>/dev/null)
          manager=$(basename "$MANAGER")
          if [ $distrotype = netbsd ]; then
          	manager="pkg_info-netbsd"
          fi
          case $manager in
          cpm) packages="$(cpm C)" ;;
          flatpak) packages="$(flatpak list --app | wc -l)" ;;
          brew) packages="$(printf '%s\n' "$(brew --cellar)/"* | wc -l)" ;;
          port) packages="$(port installed | wc -l)" ;;
          dpkg-query) packages="$(dpkg-query -f '${
            "binary:Package"
          }\n' -W | wc -l)" ;;
          rpm) packages="$(rpm -qa --last | wc -l)" ;;
          yum) packages="$(yum list installed | wc -l)" ;;
          dnf) packages="$(dnf list installed | wc -l)" ;;
          zypper) packages="$(zypper se | wc -l)" ;;
          pacman) packages="$(pacman -Q | wc -l)" ;;
          yay) packages="$(yay -Q | wc -l)" ;;
          paru) packages="$(paru -Q | wc -l)" ;;
          pacstall) packages="$(pacstall -L | wc -l)" ;;
          kiss) packages="$(kiss list | wc -l)" ;;
          emerge) packages="$(qlist -I | wc -l)" ;;
          pkg) packages="$(pkg info | wc -l | tr -d ' ')" ;;
          cave) packages="$(cave show installed-slots | wc -l)" ;;
          xbps-query) packages="$(xbps-query -l | wc -l)" ;;
          nix-env) packages="$(nix-store -q --requisites /run/current-system/sw | wc -l)" ;;
          apk) packages="$(apk list --installed | wc -l)" ;;
          pmm) packages="$(/bedrock/libexec/pmm pacman pmm -Q 2>/dev/null | wc -l)" ;;
          eopkg) packages="$(eopkg li | wc -l)" ;;
          /usr/sbin/slackpkg) packages="$(ls /var/log/packages | wc -l)" ;;
          bulge) packages="$(bulge list | wc -l)" ;;
          birb) packages="$(birb --list-installed | wc -l)" ;;
          pkg_info)
          	packages="$(pkg_info -A | wc -l)"
          	manager="pkg"
          	;;
          pkg_info-netbsd)
          	packages="$(pkg_info -a | wc -l)"
          	manager="pkg"
          	;;
          *)
          	if [ $distrotype = android ]; then
          		packages="$(dpkg-query -f '${"binary:Package"}\n' -W | wc -l)"
          		manager="dpkg"
          	else
          		packages="$(ls /usr/bin | wc -l)"
          		manager="bin"
          	fi
          	;;
          esac

          packages="''${packages#"''${packages%%[![:space:]]*}"}"
          manager=$(echo $manager | sed "s/-query//; s/\/usr\/.*\///")

          ## UPTIME DETECTION

          if [ $distrotype = android ]; then
          	uptime="$(echo $(uptime -p) | cut -c 4-)"
          elif [ $distrotype = bsd ] || [ $distrotype = netbsd ]; then
          	uptime="$(uptime | sed -e 's/.* up //; s/, [0-9]* user.*//')"
          else
          	case $ostype in
          	*"Linux"*)
          		IFS=. read -r s _ </proc/uptime
          		;;
          	*)
          		s=$(sysctl -n kern.boottime)
          		s=''${s#*=}
          		s=''${s%,*}
          		s=$(($(date +%s) - s))
          		;;
          	esac
          	d="$((s / 60 / 60 / 24))"
          	h="$((s / 60 / 60 % 24))"
          	m="$((s / 60 % 60))"
          	# Plurals
          	[ "$d" -gt 1 ] && dp=s
          	[ "$h" -gt 1 ] && hp=s
          	[ "$m" -gt 1 ] && mp=s
          	[ "$s" -gt 1 ] && sp=s
          	# Hide empty fields.
          	[ "$d" = 0 ] && d=
          	[ "$h" = 0 ] && h=
          	[ "$m" = 0 ] && m=
          	[ "$m" != "" ] && s=
          	# Make the output of uptime smaller.
          	[ "$d" ] && uptime="$d day$dp, "
          	[ "$h" ] && uptime="$uptime$h hour$hp, "
          	[ "$m" ] && uptime="$uptime$m min$mp"
          	[ "$s" ] && uptime="$uptime$s sec$sp"
          	uptime=''${uptime%, }
          fi

          ## RAM DETECTION

          case $ostype in
          *"Linux"*)
          	while IFS=':k ' read -r key val _; do
          		case $key in
          		MemTotal)
          			mem_used=$((mem_used + val))
          			mem_full=$val
          			;;
          		Shmem) mem_used=$((mem_used + val)) ;;
          		MemFree | Buffers | Cached | SReclaimable) mem_used=$((mem_used - val)) ;;
          		esac
          	done </proc/meminfo
          	mem_used=$((mem_used / 1024))
          	mem_full=$((mem_full / 1024))
          	;;
          *"Darwin"*)
          	mem_full=$(($(sysctl -n hw.memsize) / 1024 / 1024))
          	while IFS=:. read -r key val; do
          		case $key in
          		*' wired'* | *' active'* | *' occupied'*)
          			mem_used=$((mem_used + ${"val:-0"}))
          			;;
          		esac
          	done <-EOF
          		$(vm_stat)
          	EOF

          	mem_used=$((mem_used * 4 / 1024))
          	;;
          *"BSD"*)
          	mem_full=$(($(sysctl -n hw.physmem) / 1024 / 1024))
          	if [ $distrotype = netbsd ]; then
          		mem_free=$(($(vmstat | awk 'NR==3 {print $4}') / 1024))
          	else
          		mem_free=$(($(sysctl -n vm.stats.vm.v_free_count) * $(sysctl -n vm.stats.vm.v_page_size) / 1024 / 1024))
          	fi
          	mem_used=$((mem_full - mem_free))
          	;;
          *)
          	mem_full=1
          	mem_used=0
          	;;
          esac
          memstat="''${mem_used}/''${mem_full} MiB"
          if which expr >/dev/null 2>&1; then
          	mempercent="($(expr $(expr ''${mem_used} \* 100 / ''${mem_full}))%)"
          fi

          ## DEFINE COLORS

          bold='[1m'
          black='[30m'
          red='[31m'
          green='[32m'
          yellow='[33m'
          blue='[34m'
          magenta='[35m'
          cyan='[36m'
          white='[37m'
          grey='[90m'
          reset='[0m'

          ## USER VARIABLES -- YOU CAN CHANGE THESE

          lc="$reset$bold$white"    # labels
          nc="$reset$bold$yellow"   # user
          hn="$reset$bold$blue"     # hostname
          ic="$reset$white"         # info
          c0="$reset$grey"          # first color
          c1="$reset$white"         # second color
          c2="$reset$yellow"        # third color

          ## OUTPUT

    echo """
        ''${c0}      ___     ''${nc}''${USER}''${grey}@''${reset}''${hn}''${host}''${reset} 
        ''${c0}     (''${c1}.. ''${c0}\    ''${lc}''${osi}  ''${ic}''${os}''${reset}
        ''${c0}     (''${c2}<> ''${c0}|    ''${lc}''${ki}  ''${ic}''${kernel}''${reset}
        ''${c0}    /''${c1}/  \\ ''${c0}\\   ''${lc}''${ri}  ''${ic}''${RAM}''${memstat} ''${mempercent}
        ''${c0}   ( ''${c1}|  | ''${c0}/|  ''${lc}''${pi}  ''${ic}''${packages} (''${manager})''${reset}
        ''${c2}  _''${c0}/\\ ''${c1}__)''${c0}/''${c2}_''${c0})  ''${lc}''${ui}  ''${ic}''${uptime}''${reset}
        ''${c2}  \/''${c0}-____''${c2}\/''${reset}   ''${lc}''${ci}  ''${red}███''${green}███''${yellow}███''${blue}███''${magenta}███''${cyan}███''${reset}
        """
  '';
in { home.packages = [ nerdfetch ]; }
