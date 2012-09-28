#!/bin/bash
#
# Copyright (c) 2009-2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"
#git="git am --whitespace=fix"

if [ -f ${DIR}/system.sh ] ; then
	source ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

function bugs_trivial {
	echo "bugs and trivial stuff"
	${git} "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"
	${git} "${DIR}/patches/trivial/0001-kbuild-Fix-link-to-headers-in-make-deb-pkg.patch"
}

function am33x-cleanup {
	echo "[git] am33x-cleanup"
	echo "pulling ti_am33x_v3.2-staging_7"
	git pull ${GIT_OPTS} git://github.com/RobertCNelson/linux.git ti_am33x_v3.2-staging_7

	#place holder when diffing...
	${git} "${DIR}/patches/3.2.30/0136-Linux-3.2.30.patch"
	#Breaks: BeagleBone: eth0: dhcp doesn't get ip address...
	${git} "${DIR}/patches/3.2.30/0137-Revert-ARM-OMAP2-Fix-dmtimer-set-source-clock-failur.patch"

	${git} "${DIR}/patches/led/0001-leds-heartbeat-stop-on-shutdown-reboot-or-panic.patch"
	${git} "${DIR}/patches/led/0002-led-triggers-rename-trigger-to-trig-for-unified-nami.patch"
	${git} "${DIR}/patches/led/0003-led-triggers-create-a-trigger-for-CPU-activity.patch"
	${git} "${DIR}/patches/led/0004-ARM-use-new-LEDS-CPU-trigger-stub-to-replace-old-one.patch"

	${git} "${DIR}/patches/libertas/0001-USB-convert-drivers-net-to-use-module_usb_driver.patch"
	${git} "${DIR}/patches/libertas/0002-net-fix-assignment-of-0-1-to-bool-variables.patch"
	${git} "${DIR}/patches/libertas/0003-switch-debugfs-to-umode_t.patch"
	${git} "${DIR}/patches/libertas/0004-drivers-net-Remove-unnecessary-k.alloc-v.alloc-OOM-m.patch"
	${git} "${DIR}/patches/libertas/0005-libertas-remove-dump_survey-implementation.patch"
	${git} "${DIR}/patches/libertas/0006-wireless-libertas-remove-redundant-NULL-tests-before.patch"
	${git} "${DIR}/patches/libertas/0007-libertas-fix-signedness-bug-in-lbs_auth_to_authtype.patch"
	${git} "${DIR}/patches/libertas/0008-drivers-net-wireless-libertas-if_usb.c-add-missing-d.patch"
	${git} "${DIR}/patches/libertas/0009-libertas-Firmware-loading-simplifications.patch"
	${git} "${DIR}/patches/libertas/0010-libertas-harden-up-exit-paths.patch"
	${git} "${DIR}/patches/libertas/0011-libertas-add-asynchronous-firmware-loading-capabilit.patch"
	${git} "${DIR}/patches/libertas/0012-libertas-SDIO-convert-to-asynchronous-firmware-loadi.patch"
	${git} "${DIR}/patches/libertas/0013-libertas-USB-convert-to-asynchronous-firmware-loadin.patch"
	${git} "${DIR}/patches/libertas/0014-libertas-CS-convert-to-asynchronous-firmware-loading.patch"
	${git} "${DIR}/patches/libertas/0015-libertas-add-missing-include.patch"
	${git} "${DIR}/patches/libertas/0016-remove-debug-msgs-due-to-missing-in_interrupt.patch"

	${git} "${DIR}/patches/pwm/0001-PWM-ecap-Correct-configuration-of-polarity.patch"
	${git} "${DIR}/patches/pwm/0002-ARM-OMAP2-am335x-mux-add-ecap2_in_pwm2_out-string-en.patch"
	${git} "${DIR}/patches/pwm/0003-ARM-OMAP2-AM335x-hwmod-Remove-PRCM-entries-for-PWMSS.patch"
	${git} "${DIR}/patches/pwm/0004-PWM-ecap-Resets-the-PWM-output-to-low-on-stop.patch"
	${git} "${DIR}/patches/pwm/0005-PWM-ecap-Fix-for-throwing-PWM-output-before-running.patch"
	${git} "${DIR}/patches/pwm/0006-pwm-ehrpwm-Configure-polarity-on-pwm_start.patch"

	${git} "${DIR}/patches/mfd/0001-Add-TPS65217-Backlight-Driver.patch"

	${git} "${DIR}/patches/beaglebone/0001-f_rndis-HACK-around-undefined-variables.patch"
	${git} "${DIR}/patches/beaglebone/0002-da8xx-fb-add-DVI-support-for-beaglebone.patch"
	${git} "${DIR}/patches/beaglebone/0003-beaglebone-rebase-everything-onto-3.2-WARNING-MEGAPA.patch"
	${git} "${DIR}/patches/beaglebone/0004-more-beaglebone-merges.patch"
	${git} "${DIR}/patches/beaglebone/0005-beaglebone-disable-tsadc.patch"
	${git} "${DIR}/patches/beaglebone/0006-tscadc-Add-general-purpose-mode-untested-with-touchs.patch"
	${git} "${DIR}/patches/beaglebone/0007-tscadc-Add-board-file-mfd-support-fix-warning.patch"
	${git} "${DIR}/patches/beaglebone/0008-AM335X-init-tsc-bone-style-for-new-boards.patch"
	${git} "${DIR}/patches/beaglebone/0009-tscadc-make-stepconfig-channel-configurable.patch"
	${git} "${DIR}/patches/beaglebone/0010-tscadc-Trigger-through-sysfs.patch"
	${git} "${DIR}/patches/beaglebone/0011-meta-ti-Remove-debug-messages-for-meta-ti.patch"
	${git} "${DIR}/patches/beaglebone/0012-tscadc-switch-to-polling-instead-of-interrupts.patch"
	${git} "${DIR}/patches/beaglebone/0013-beaglebone-fix-ADC-init.patch"
	${git} "${DIR}/patches/beaglebone/0014-AM335x-MUX-add-ehrpwm1A.patch"
	${git} "${DIR}/patches/beaglebone/0015-beaglebone-enable-PWM-for-lcd-backlight-backlight-is.patch"
	${git} "${DIR}/patches/beaglebone/0016-omap_hsmmc-Set-dto-to-max-value-of-14-to-avoid-SD-Ca.patch"
	${git} "${DIR}/patches/beaglebone/0017-beaglebone-set-default-brightness-to-50-for-pwm-back.patch"
	${git} "${DIR}/patches/beaglebone/0018-st7735fb-WIP-framebuffer-driver-supporting-Adafruit-.patch"
	${git} "${DIR}/patches/beaglebone/0019-beaglebone-use-P8_6-gpio1_3-as-w1-bus.patch"
	${git} "${DIR}/patches/beaglebone/0020-beaglebone-add-support-for-Towertech-TT3201-CAN-cape.patch"
	${git} "${DIR}/patches/beaglebone/0021-beaglebone-add-more-beagleboardtoys-cape-partnumbers.patch"
	${git} "${DIR}/patches/beaglebone/0022-beaglebone-add-gpio-keys-for-lcd7-add-notes-for-miss.patch"
	${git} "${DIR}/patches/beaglebone/0023-beaglebone-add-enter-key-for-lcd7-cape.patch"
	${git} "${DIR}/patches/beaglebone/0024-beaglebone-add-gpio-keys-for-lcd.patch"
	${git} "${DIR}/patches/beaglebone/0025-beaglebone-fix-direction-of-gpio-keys.patch"
	${git} "${DIR}/patches/beaglebone/0026-beaglebone-fix-3.5-lcd-cape-support.patch"
	${git} "${DIR}/patches/beaglebone/0027-beaglebone-decrease-PWM-frequency-to-old-value-LCD7-.patch"
	${git} "${DIR}/patches/beaglebone/0028-beaglebone-fix-ehrpwm-backlight.patch"
	${git} "${DIR}/patches/beaglebone/0029-beaglebone-also-report-cape-revision.patch"
	${git} "${DIR}/patches/beaglebone/0030-beaglebone-don-t-compare-undefined-characters-it-mak.patch"
	${git} "${DIR}/patches/beaglebone/0031-beaglebone-fix-3.5-cape-support.patch"
	${git} "${DIR}/patches/beaglebone/0032-beaglebone-connect-batterycape-GPIO-to-gpio-charger.patch"
	${git} "${DIR}/patches/beaglebone/0033-beaglebone-add-support-for-CAN-and-RS232-cape.patch"
	${git} "${DIR}/patches/beaglebone/0034-beaglebone-add-support-for-DVI-rev.-A2-capes.patch"
	${git} "${DIR}/patches/beaglebone/0035-beaglebone-enable-LEDs-for-DVI-LCD3-and-LCD7-capes.patch"
	${git} "${DIR}/patches/beaglebone/0036-Beaglebone-Fixed-compiletime-warnings.patch"
	${git} "${DIR}/patches/beaglebone/0037-Beaglebone-Added-missing-termination-record-to-bone_.patch"
	${git} "${DIR}/patches/beaglebone/0038-board-am335xevm.c-Beaglebone-expose-all-pwms-through.patch"
	${git} "${DIR}/patches/beaglebone/0039-ARM-OMAP-Mux-Fixed-debugfs-mux-output-always-reporti.patch"
	${git} "${DIR}/patches/beaglebone/0040-beaglebone-export-SPI2-as-spidev-when-no-capes-are-u.patch"
	${git} "${DIR}/patches/beaglebone/0041-st7735fb-Working-WIP-changes-to-make-DMA-safe-and-ad.patch"
	${git} "${DIR}/patches/beaglebone/0042-omap-hwmod-silence-st_shift-error.patch"
	${git} "${DIR}/patches/beaglebone/0043-cpsw-phy_device-demote-PHY-message-to-INFO.patch"
	${git} "${DIR}/patches/beaglebone/0044-beaglebone-add-support-for-7-LCD-cape-revision-A2.patch"
	${git} "${DIR}/patches/beaglebone/0045-beaglebone-allow-capes-to-disable-w1-gpio.patch"
	${git} "${DIR}/patches/beaglebone/0046-beaglebone-add-stub-for-the-camera-cape-to-disable-w.patch"
	${git} "${DIR}/patches/beaglebone/0047-Adding-many-of-the-missing-signals-to-the-mux-table.patch"
	${git} "${DIR}/patches/beaglebone/0048-Fixed-reversed-part-of-LCD-bus.-Added-even-more-miss.patch"
	${git} "${DIR}/patches/beaglebone/0049-ts_tscadc-add-defines-for-4x-and-16x-oversampling.patch"
	${git} "${DIR}/patches/beaglebone/0050-ts_tscadc-switch-to-4x-oversampling.patch"
	${git} "${DIR}/patches/beaglebone/0051-Fixed-size-of-pinmux-data-array-in-EEPROM-data-struc.patch"
	${git} "${DIR}/patches/beaglebone/0052-Implemented-Bone-Cape-configuration-from-EEPROM.-Onl.patch"
	${git} "${DIR}/patches/beaglebone/0053-Replaced-conditional-debug-code-by-pr_debug-statemen.patch"
	${git} "${DIR}/patches/beaglebone/0054-Workaround-for-boards-with-mistaken-ASCII-interpreta.patch"
	${git} "${DIR}/patches/beaglebone/0055-Workaround-for-EEPROM-contents-blocking-further-I2C-.patch"
	${git} "${DIR}/patches/beaglebone/0056-Added-check-on-EEPROM-revision-to-prevent-interpreti.patch"
	${git} "${DIR}/patches/beaglebone/0057-i2c-prescalar-fix-i2c-fixed-prescalar-setting-issue.patch"
	${git} "${DIR}/patches/beaglebone/0058-beaglebone-annotate-default-beaglebone-pinmux.patch"
	${git} "${DIR}/patches/beaglebone/0059-beaglebone-fix-pin-free-thinko-this-method-doesn-t-g.patch"
	${git} "${DIR}/patches/beaglebone/0060-beaglebone-switch-RS232-cape-to-ttyO2.patch"
	${git} "${DIR}/patches/beaglebone/0061-beaglebone-make-uart2-pinmux-match-the-uart0-pinmux.patch"
	${git} "${DIR}/patches/beaglebone/0062-da8xx-fb-Rounding-FB-size-to-satisfy-SGX-buffer-requ.patch"
	${git} "${DIR}/patches/beaglebone/0063-beaglebone-dvi-cape-audio-hacks.patch"
	${git} "${DIR}/patches/beaglebone/0064-beaglebone-always-execute-the-pin-free-checks.patch"
	${git} "${DIR}/patches/beaglebone/0065-ti_tscadc-switch-to-16x-averaging.patch"
	${git} "${DIR}/patches/beaglebone/0066-video-da8xx-fb-Add-Newhaven-LCD-Panel-details.patch"
	${git} "${DIR}/patches/beaglebone/0067-beaglebone-add-support-for-the-4.3-lcd-cape-with-res.patch"
	${git} "${DIR}/patches/beaglebone/0068-beaglebone-add-support-for-LCD3-rev-A1.patch"
	${git} "${DIR}/patches/beaglebone/0069-beaglebone-fix-buttons-spidev-clash-when-using-mcasp.patch"
	${git} "${DIR}/patches/beaglebone/0070-beaglebone-fix-LCD3-led-key-overlap.patch"
	${git} "${DIR}/patches/beaglebone/0071-beaglebone-fix-audio-spi-clash.patch"
	${git} "${DIR}/patches/beaglebone/0072-beaglebone-add-support-for-QuickLogic-Camera-interfa.patch"
	${git} "${DIR}/patches/beaglebone/0073-beaglebone-add-support-for-DVI-audio-and-audio-only-.patch"
	${git} "${DIR}/patches/beaglebone/0074-beaglebone-disable-LBO-GPIO-for-battery-cape.patch"
	${git} "${DIR}/patches/beaglebone/0075-video-da8xx-fb-calculate-pixel-clock-period-for-the-.patch"
	${git} "${DIR}/patches/beaglebone/0076-beaglebone-improve-GPMC-bus-timings-for-camera-cape.patch"
	${git} "${DIR}/patches/beaglebone/0077-beaglebone-disable-UYVY-VYUY-and-YVYU-modes-in-camer.patch"
	${git} "${DIR}/patches/beaglebone/0078-beaglebone-error-handling-for-DMA-completion-in-cssp.patch"
	${git} "${DIR}/patches/beaglebone/0079-AM335X-errata-OPP50-on-MPU-domain-is-not-supported.patch"
	${git} "${DIR}/patches/beaglebone/0080-vfs-Add-a-trace-point-in-the-mark_inode_dirty-functi.patch"
	${git} "${DIR}/patches/beaglebone/0081-beaglebone-add-support-for-LCD7-A3.patch"
	${git} "${DIR}/patches/beaglebone/0082-beaglebone-add-rudimentary-support-for-eMMC-cape.patch"
	${git} "${DIR}/patches/beaglebone/0083-beaglebone-add-extra-partnumber-for-camera-cape.patch"
	${git} "${DIR}/patches/beaglebone/0084-beaglebone-cssp_camera-driver-cleanup.patch"
	${git} "${DIR}/patches/beaglebone/0085-beaglebone-mux-camera-cape-orientation-pin-to-gpio.patch"
	${git} "${DIR}/patches/beaglebone/0086-board-am335xevm-Add-Beaglebone-Motor-Cape-Support.patch"
	${git} "${DIR}/patches/beaglebone/0087-mux33xx-Fix-MUXENTRYs-for-MCASP0_ACLKX-FSX-to-add-eh.patch"
	${git} "${DIR}/patches/beaglebone/0088-beaglebone-add-a-method-to-skip-mmc-init.patch"
	${git} "${DIR}/patches/beaglebone/0089-beaglebone-do-mmc-init-in-TT3202-setup-method.patch"

	${git} "${DIR}/patches/beaglebone/0001-bone-disable-OPPTURBO.patch"
	${git} "${DIR}/patches/beaglebone/0002-BeagleBone-A2-fixup-eeprom-and-initialization.patch"

#	${git} "${DIR}/patches/beaglebone/0001-ARM-omap-am335x-BeagleBone-userspace-SPI-support.patch"
#	${git} "${DIR}/patches/fixes/0001-rt2x00-Add-support-for-D-Link-DWA-127-to-rt2800usb.patch"
}

rt_patchset () {
	${git} "${DIR}/patches/rt/0001-rt-patch-3.2.30-rt45.patch"
}

am33x-cleanup
bugs_trivial
#rt_patchset

echo "patch.sh ran successful"

