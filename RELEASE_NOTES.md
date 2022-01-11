# Release notes

Release notes for the SLAC LCLS-II HPS MPS Link Node

## Releases:
* __l2MpsLN-R3-19-1__: 2022-01-11 J. Mock
  * Add directories for new IOCs sioc-gunb-mp02,
      sioc-l3b-mp06, sioc-undh-mp11

* __l2MpsLN-R3-19-0__: 2022-01-11 J. Mock
  * Upgrade timing modules for enum direction change 
  * No longer convert any low level analog inputs PVs from raw counts to mV
  * Change prefix of :LCLSMODE from {MPS_PREFIX} to {IOC_NAME}

* __l2MpsLN-R3-18-0__: 2021-10-20 J. Mock
  * New FW version R4.4.9 built against amc_carrier_core 4.4.9

* __l2MpsLN-R3-17-0__: 2021-10-6 J. Mock
  * Restore ana_units.req to autosave facility for all analog link nodes

* __l2MpsLN-R3-16-0__: 2021-09-19 J. Mock
  * Add new IOCs to support additional analog inputs
  * Update boot scripts to point to current configuration
  * Temporarily enable MPS at boot until mps_manager fixed
  * Update TIMING_MODE PV to LCLSMODE
  * Add support for new LN type: Digital Node.  Used in FEES/H

* __l2MpsLN-R3-15-0__: 2021-08-18 J. Vasquez
  * Update `l2Mps` to version `R3.7.0`.
  * Update `l2MpsAsyn` to version `R3.7.0`.

* __l2MpsLN-R3-14-0__: 2021-08-17 J. Vasquez
  * Update `l2Mps` to version `R3.6.0`.
  * Update `l2MpsAsyn` to version `R3.6.0`.

* __l2MpsLN-R3-13-0__: 2021-07-27 J. Mock
  * Add PV support for PGP Tx and Rx bandwidth monitoring and frame statistics
    as added to MpsConcentrator
  * Update FW to lcls2-mps `v4.6.0`:
    * Increase number of active analog thresholds from 7 to 8
    * Change analog threshold counter to roll over when it reaches its max value
    * Add registers for bandwidth monitoring on PGP lanes

* __l2MpsLN-R3-12-0__: 2021-06-29 J. Vasquez
  * Fix the crossbar read-back PV YCPSWASYN `ADDR` parameter.
  * Update `BsaCore` and `evrClient` modules. This includes a fix to handle an
    exception for the `process()` in `RingBufferSync`.
  * Timing mode: added database to support setting and monitoring the operating
    mode(SC/NC).

* __l2MpsLN-R3-11-0__: 2021-04-22 J. Vasquez
  * Add crossbarControl module
  * Remove l2MpsLN specific control of crossbar
  * Change l2MpsLN crossbar PVs to monitor only.

* __l2MpsLN-R3-10-2__: 2021-03-30 J. Mock
  * Fix typo in sioc-l2b-mp01/st.cmd
  * Set .PROC field to 1 for $(P):TIM_CLK_SRC so crossbar
    configure properly upon boot

* __l2MpsLN-R3-10-1__: 2021-03-23 J. Mock
  * Change boot order in link node and application node so default.yaml
    is loaded before config.yaml.


* __l2MpsLN-R3-10-0__: 2021-03-16 J. Mock
  * Remove crossbar configuration from `iocBoot/common/configs/specificsLN.yaml`.
    This has been moved to the `configs.yaml` created by the `mps_configuration`
    to allow different link nodes to configure crossbars differently, depending on
    location

* __l2MpsLN-R3-9-1__: 2021-03-04 J. Vasquez
  * Move `sioc-undh-mp03` and `sioc-undh-mp04` to different CPUs.

* __l2MpsLN-R3-9-0__: 2021-02-16 J. Vasquez
  * Add new IOCs for SC and bypass areas.
  * Change GUNB IOC to boot using the standard script.

* __l2MpsLN-R3-8-0__: 2021-02-05 J. Vasquez
  * Update l2Mps to version R3.5.0.
  * Update l2MpsAsyn to version R3.5.0.
  * Add FW image for the digital link node, version `58ab448`.

* __l2MpsLN-R3-7-3__: 2020-09-28 J. Mock
  * Fix mps_link_node_change_units.py to handle the HXR and SXR PVs for each analog device
  * Add scripts to write FW to all LN and AN (update_mps_an_fw.sh and update_mps_ln_fw.sh)
  * Fix mistake in iocBoot/common/ana_units.req - the values for pedestal start time were not autosaved
  * Fix mistake in sioc-fees-mp01 and sioc-feeh-mp01 so they no longer look for payload in slot 6. Should
      be slot 2

* __l2MpsLN-R3-7-2__: 2020-09-17 J. Vasquez
  * Update firmware images to version `7bec288`, which solves the raw ADC data sign jump when
    in positive saturation.
  * Revert RT priorities for BSA related threads, which was introduced in the previous release.
    This was affecting BPM systems in production.
  * Remove local patched YAML file AmcGenericAdcDacCtrl.yaml. This file was used to fix an issue
    which is now fixed in the firmware repository, so this local fix is not longer necessary.

* __l2MpsLN-R3-7-1__: 2020-07-09 J. Vasquez
  * Set BsaCore threads RT priority to 90 and the LCLS1 BSA stream receiver thread RT priority
    to 80, and its policy to SCHED_FIFO.

* __l2MpsLN-R3-7-0__: 2020-07-09 J. Vasquez
  * Remove BSA PVs as they will be generated from the mps database
  * Update tprPattern to version R1.4.1 which solve an issue when the IOC crashes when BsaCore
    throws an exception due to pattern buffer overruns.
  * Update LN and AN firmware images which allow to control the BSA data rate using TPG5. This
    help to prevent BsaCore pattern buffer overruns.

* __l2MpsLN-R3-6-2__: 2020-06-17 J. Mock
  * Add PK and PD WTH and DEL PVs to autosave so the calibrated values don't get lost

* __l2MpsLN-R3-6-1__: 2020-05-20 J. Mock
  * Upgrade iocAdmin to version R3.1.16-1.3.0 to deal with timezone PV problem
  * Add seq version R2.2.4-1.2 to RELEASE. Load devSeqCar.dbd and lib devSeqCar seq pv
      in the src/Makefile to load the devSeqCar.db file for Accelerator network screens
  * Change the macro for autosave from ${L2MPS_PREFIX} to ${IOC_NAME} to conform with
      Accelerator Network common screens.  Changed in link_node.cmd and application_node.cmd
  * Comment in TPR Pattern load in application_node.cmd - this was a mistake in R3-6-0
  * Add sioc-b084-mp03 to run on shm-b084-hp04 slot 2 on cpu-b084-hp03 - BLEN/BCM test stand

* __l2MpsLN-R3-6-0__: 2020-05-14 J. Mock
  * Add support for PV inputs to MPS Digital APP (i.e. soft inputs) (#37, #38)
    * Update l2Mps to version R3.4.1
    * Update l2MpsAsyn to version R3.4.1
  * Merge Application Node support into this App
    * Add firmware/mpsAN.dict
    * Add l2MpsLNApp/Db/mpsAN.substitutions
    * Add iocBoot/common/application_node.cmd
  * Create directory for useful MPS LN scripts
    * Add init_lcls1_timins.sh which sets up the TPR for NC operation
    * Add mps_link_node_change_units.py which changes the units of an analog input
    * Add setupBPClock.sh which initializes the SALT settings for the crate
  * Update firmware to latest release
    * LN - AmcCarrierMpsAnalogLinkNode-0x00000049-20200423162244-leosap-fba853c.mcs
    * AN - AmcCarrierMpsApplicationNode-0x00000001-20200423162251-leosap-fba853c.mcs
  * Convert all the analog core PVs to mV units (#25)
  * Convert the processing window PVs to ns (#28, #31)
  * Fix parameter types used with YCPSWASYN (#29)
    Update YCPSWASYN to version R3.3.3 which includes bug fixes needed related to
    wrong parameter types. Also, fix some parameters types which didn't match the
    register type they were connected to.
  * Fix LCLS1 BSA implementation (#30).
    Fix several issues with the LCLS1 BSA implementation:
    * It was missing the tprPattern, and the evrClient EPICS modules,
    * There was also a bug in the stream data processing, as it was not considering the
      packetizer header and footer which were added since the initial BSA driver
      implementation.
    I also rename the BSA PV for more clarity. Instead of using index (0..23), use Bay
    number, channel number, and integration number.
  * Bring TPR BSA drivers into link_node.cmd (#32)
  * Analog Values Autosave (#34)
    Add autosave of EGU, EGUF, and EGUL for analog core values associated with analog
    inputs. Add script to iocBoot/common to change these values.
  * Bug fix: remove hard-coded name used to load the `bsaATTREdef.db` (#33, #35)

* __l2MpsLN-R3-5-0__: 2020-03-06 J. Mock
  * general ioc cleanup
  * change default yaml load to be from FW
  * add common/configs/specifics.yaml to set timing settings
  * add ${IOC}/configs/specifics.yaml to set LC1 kicker magnet type

* __l2MpsLN-R3-4-0__: 2020-02-07 J. Vasquez
  * Update versions:
  * buildroot to 2019.08
  * CPSW to R4.4.1
  * l2Mps to R3.3.0
  * yamlReader to R1.2.0
  * deviceLibrary to R1.2.0
  * hpsTpr to R1.1.0
  * asyn to R4.32-1.0.0
  * yamlLoader to R2.1.0
  * l2MpsAsyn to R3.3.0
  * ycpswasyn to R3.3.1
  * yamlDownloader to R1.2.0
  * tprTrigger to R1.5.0
  * BsaCore to R1.5.3

* __l2MpsLN-R3-3-0__: 2020-02-07 J. Vasquez
  * Add support to read raw waveforms from all ADC channels.
  * Bug fix: Add missing env vars to the local database `mps.env` file.
  * Update st.mcd for correct slot and crate for cu area.
  * Update default configuration files.
  * Update MCS file with current version `1cd2cbf`.

* __l2MpsLN-R3-2-0__: 2019-12-17 J. Vasquez
  * Merge `R2-branch` back into master.
  * Update both l2Mps and l2MpsAsyn to version `R3.2.0`.
  * Re-enable the `DownloadYamlFile` module.
  * Migrate application to EPICS v7.

* __l2MpsLN-R3-1-0__: 2019-09-24 J. Vasquez
  * Add PVs for new FW register related to LCLS1
    operation: Analog core register used on LCLS1
    mode.
  * Add PVs for the new FW module ASM Core.
  * Removed deprecated PVs for the Analog core
    peak detect enable and values, and add PVs for
    the new PrcValueSelect and ForcePrcVals registers.
  *  Update CPSW framework to version R4.2.0, and all the dependent modules:
    * l2Mps to R3.1.0,
    * yamlReader to R1.1.1,
    * deviceLibrary to R1.1.1,
    * yamlLoader to R1.1.4,
    * yamlDownloader to R1.1.1,
    * yCPSWAsyn to R3.1.2, and
    * l2MpsAsyn to R3.1.1

* __l2MpsLN-R3-0-0__: 2019-07-31 J. Vasquez
  * Update l2Mps to version R3.0.0 and l2MpsAsyn to version
    R3.0.0.
  * The IOC now read the EPICS database definition and firmware
    configuration files generated by the MPS database. We are
    using local copy in this application at this moment for testing.
  * The IOC now contacts the MPS manager at boot to request for its
    thresholds PVs to be set.

* __l2MpsLN-R2-6-0__: 2019-11-25 J. Vasquez
  * Update cpsw/framework to version R4.3.1.
  * Add the directory 'firmware/yaml_fixes' and add it to the CPSW's
    "YAML_PATH" environmental variable, to override YAML files coming
    from the FPGA.
  * Update PVs for the AnaloCore device.
  * Rename PV related to the LCLS2 Analog core. Added "LC2_" to be
    consistent with the LCLS1 Analog core PVs.
  * Update MCS file to current version.
  * Add new PVs for the Concentrator device.
  * Add support for the tprTrigger EPICS module.
  * Add support for the BsaCore module.
  * Process the firmware data stream with LCLS1 BSA data, and send it
    to BsaCore.
  * Update PVs for the mitigation core device, including adding a new PV
    for selection the type of mitigation kicker.
  * Minor bug fixes.

* __l2MpsLN-R2-5-0__: 2019-09-24 J. Vasquez
  * Update CPSW framework to version R4.2.0, and all the dependent modules:
    * l2Mps to R2.2.0,
    * yamlReader to R1.1.1,
    * deviceLibrary to R1.1.1,
    * yamlLoader to R1.1.4,
    * yamlDownloader to R1.1.1,
    * yCPSWAsyn to R3.1.2, and
    * l2MpsAsyn to R2.4.0

* __l2MpsLN-R2-4-0__: 2019-09-23 J. Vasquez
  * Add PVs for new FW register related to LCLS1
    operation: Analog core register used on LCLS1
    mode.
  * Add PVs for the new FW module ASM Core.
  * Removed deprecated PVs for the Analog core
    peak detect enable and values, and add PVs for
    the new PrcValueSelect and ForcePrcVals registers.

* __l2MpsLN-R2-3-3__: 2020-05-26 J. Vasquez
  * Udate the LN used in EIC to buildroot 2019.08.
    This includes update the following:
    * Packages:
      * cpsw/framework -> R4.4.1
      * l2Mps -> R2.4.0
      * yamlReader -> R1.2.0
      * deviceLibrary -> R1.2.0
    * EPICS modules:
      * asyn -> R4.32-1.0.0
      * yamlLoader -> R2.1.0
      * yamlDownloader -> R1.2.0
      * ycpswssyn -> R3.3.1
      * l2MpsAsyn -> R2.6.0
  * Added a local copy of the FW YAML files, as this
    old version has some bugs which are catch by the
    new CPSW version. The bugs in the local copy were
    manually fixed.
  * Disabled the yamlDownloader, and use the local
    copy of the YAML files.

* __l2MpsLN-R2-3-2__: 2019-08-16 J. Vasquez
  * Update l2MpsAsyn top version R2.3.2.

* __l2MpsLN-R2-3-1__: 2019-08-13 J. Vasquez
  * Update l2Mps top version R2.1.2 and l2MpsAsyn
    to version R2.3.1. Those versions includes a
    bug fix where an argument name was shadowing
    the protected member name. This was causing
    the polling thread to consume a lot of CPU.

* __l2MpsLN-R2-3-0__: 2019-07-18 J. Vasquez
  * Update the folllwing packages:
    * cpsw/framework -> R4.1.2
    * l2Mps -> R2.1.1
    * yamlReader -> R1.1.0
    * deviceLibrary -> R1.1.0
  * Update the following EPICS modules:
    * yamlLoader -> R1.1.3
    * yamlDownloader -> R1.1.0
    * YCpswAsyn -> R3.1.1
    * l2MpsAsyn -> R2.3.0

* __l2MpsLN-R2-2-0__: 2019-06-13 J. Vasquez
  * Add support for the LCLS-I operation related registers.

* __l2MpsLN-R2-1-0__: 2019-06-12 J. Vasquez
  * Update l2MpsAsyn to version R2.1.0.
  * Autosave files are build using the info(autosaveFields)
    defined in the databse. Am autosave file, with manually
    defined PVs was added.
  * Add Link Node for building 34.

* __l2MpsLN-R2-0-0__: 2019-02-28 J. Vasquez
  * Update CPSW framework to version R3.6.6, boost to 1.64.0 and
    yaml-cpp to yaml-cpp-0.5.3_boost-1.64.0.
  * Update l2Mps and l2MpsAsyn to version R2.0.0.
  * Update yamlLoader to R1.1.2 and YCPSWASYN to R3.0.5.
  * Use the yamlDownloader to get the YAML files from the FPGA.
  * Use AI record for the ADC values.
  * Set JesdRx.InvertAdcData = 0xF to invert the ADC data and
    revert the effect of the HW inverter present in the ADC card.
  * Add DEV IOC (sioc-b084-mp02).
  * Minor bug fixes and code clean ups.

* __l2MpsLN-R1-0-0__: 2018-07-18 J. Vasquez
  * First stable release for EIC.
