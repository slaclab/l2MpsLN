# Release notes Update

Release notes for the SLAC LCLS-II HPS MPS Link Node

## Releases:

* tag:__l2MpsLN-R5-5-1__: 2025-05-13 jmock
  * Fix problem with WF type channels offset

* tag:__l2MpsLN-R5-5-0__: 2025-05-13 jmock
  * Add MPS_OFFSET PV for analog channels that allows user to set offset in EGU

* tag:__l2MpsLN-R5-4-9__: 2025-05-12 lujko
  * New tag for build system compatibility

* tag:__l2MpsLN-R5-4-8__: 2025-04-18 lujko
  * New tag for build system compatibility

* tag:__l2MpsLN-R5-4-7__: 2025-04-18 lujko
  * New tag for buildy system compatibility

* __l2MpsLN-R5-4-6__: 2025-04-16 lujko
  * Fix alarm severity states 

* __l2MpsLN-R5-4-5__: 2025-04-16 lujko
  * Add new alarm on MITMSG_TMSTMP records 

* __l2MpsLN-R5-4-4__: 2025-4-02 jmock
  * Add EGU to WF START and NELM records

* __l2MpsLN-R5-4-3__: 2025-03-20 jmock
  * Fix typo in ATTR input

* __l2MpsLN-R5-4-2__: 2025-03-20 jmock
  * Change AutoRearm and AMC_CLK_FREQ PV names to avoid duplicates
  * Change SC BSSS PV that I(0/1)_(ATTR)_ uses to L since that is the only one that doesn't seem to care about beam presence

* __l2MpsLN-R5-4-1__: 2025-03-19 jmock
  * Fix MPS_SLOPE naming collision between FAST and AMC inputs

* __l2MpsLN-R5-4-0__: 2025-03-19 jmock
  * Refactor ioc boot files to simplify changes
  * Update channel 15 timing settings to look at bits instead of destinations
  * Deprecate ana_units.sav
  * Restore I1 scalar (not float) BSA PVs
  * Change scan rate of asyn analog PV to 0.1 s
  * Add time stamp delay to autosave
  * Add cblm-specific time window properties to yaml files
  * Add in default analog time windows since avg processing is used

* __l2MpsLN-R5-3-1__: 2025-02-19 jmock
  * Pare down LCLS2 BSA list to I0 scalar only

* __l2MpsLN-R5-3-0__: 2025-02-18 jmock
  * Build against new cpsw and modules for rocky9 host
  * Update PVs and ioc booting for fixed analog processing

* __l2MpsLN-R5-2-5__: 2025-01-22 jmock
  * Add in I1 LCLS2 BSA PVs so as not to break choice.

* __l2MpsLN-R5-2-4__: 2025-01-22 jmock
  * Change analog processing asynchronous PVs to point to BSA values if available and 
    FW reads if no beam present.  See analog.template

* __l2MpsLN-R5-2-3__: 2025-01-15 jmock
  * Change sioc-clts-mp01 analog processing to use avg values instead of peak values

* __l2MpsLN-R5-2-2__: 2025-01-15 jmock
  * Change sioc-clts-mp01, sioc-bsys-mp04, and sioc-bsyh-mp03 to
    be UND type, so the kicker watching works better until FW bug fix
    is finished

* __l2MpsLN-R5-2-1__: 2025-01-13 jmock
  * Create missing iocBoot/common/configs/specificsAN_UND.yaml

* __l2MpsLN-R5-2-0__: 2025-01-13 jmock
  * build against mps_configuration 2025-01-09-a
  * Allow FW 4.10.2 to run against this version of the application
    * New dict and substitution files to handle different register data types
    * High level PV names are the same

* __l2MpsLN-R5-1-0__: 2024-10-21 jmock
  * build against mps_configuration 2024-10-21-a (include PBLM:DASEL:415)
  * Build against l2MpsAsyn 4.1.2
  * Activate BSAS for I0 and I0 FLOAT
  * Activate BSA for I0, I0 FLOAT, and I1

* __l2MpsLN-R5-0-1__: 2024-10-08 jmock
  * build against mps_configuration 2024-10-07-a

* __l2MpsLN-R5-0-0__: 2024-10-08 jmock
  * build against l2MpsAsyn 4.1.0
  * refactor databases to load from local instead of mps_configuration
  * New analog processing

* __l2MpsLN-R4-6-3__: 2024-05-07 jmock
  * Add analog processing settings to specific.yaml for:
    * BYKIK in sioc-bsyh-mp03
    * BYKIKS in sioc-bsys-mp04
    * BKRCUS in sioc-clts-mp01
  * Stop loading BSAS to see if it help IOC crashing

* __l2MpsLN-R4-6-2__: 2024-04-23 jmock
  * Add a PROC for LC1 Enable on startup - it's not always
    getting done on time and needs extra help.

* __l2MpsLN-R4-6-1__: 2024-04-17 jmock
  * Re-enable BSAS service in all IOCs

* __l2MpsLN-R4-6-0__: 2024-04-03 jmock
  * Update app framework to build for host arch and target arch
    * Update to modules:
      * ATCACOMMON_MODULE_VERSION       = R2.0.1
      * YAMLLOADER_MODULE_VERSION       = R2.3.5
      * L2MPSASYN_MODULE_VERSION        = R3.11.1
      * YCPSWASYN_MODULE_VERSION        = R3.3.6
      * YAMLDOWNLOADER_MODULE_VERSION   = R1.2.3
      * TPRTRIGGER_MODULE_VERSION       = R2.6.3
      * BSACORE_MODULE_VERSION          = R1.5.6
      * TIMINGAPI_MODULE_VERSION        = R0.9
      * TPRPATTERN_MODULE_VERSION       = R2.3.7
      * EVRCLIENT_MODULE_VERSION        = R1.5.3
      * BSADRIVER_MODULE_VERSION        = R4.2.0
    * Update to Packages:
      * LINUX_VERSION       = rhel7
      * HPSTPR_VERSION      = R2.5.0
      * BSA_VERSION         = R2.6.0
      * COMMONATCA_VERSION  = R2.0.0
    * Move waveform stream support from ATCACommon back to the app
      * The ATCACommon PR was rejected.  Temporary until
        we decide how to move forward
  * Create new dev ioc sioc-b34-mp11

* __l2MpsLN-R4-5-2__: 2024-03-26 jmock
  * Update iocBoot/sioc-gunb-mp02/mitigation_config.yaml:
    * Duplicate ASM settings for laser 1 to laser 2.
      AOM Permit and Trigger select for Bay 1 will match Bay 0

* __l2MpsLN-R4-5-1__: 2024-03-08 jmock
  * Fix FLNK bug in Reg3BitsRW.template - RBV PV needs to link to CALC PV
    but it was linking to set PV
  * Adjust mitigation_config.yaml in iocBoot/sioc-sps-mp02 so that RTM_DOUT permits
    2 and 3 listen to destination 5 (LESA) instead of destination 4 (SXR)

* __l2MpsLN-R4-5-0__: 2023-08-01 jmock
  * Adjust modeManagerLN.db to turn off NC Core when in SC Mode
    * This happens as part of mode switching and is driven by
      FACMODE

* __l2MpsLN-R4-4-4__: 2023-05-24 jmock
  * Adjust disableBsa.yaml file to fix "- "
  * Change I0 asyn scan rate back to 0.1 seconds

* __l2MpsLN-R4-4-3__: 2023-05-22 jmock
  * Change ANA_BSA_SCAN rate from .1 second to 1 second

* __l2MpsLN-R4-4-2__: 2023-05-22 jmock
  * Update TPR version to 2.5

* __l2MpsLN-R4-4-1__: 2023-05-22 jmock
  * Remove BSAS from IOC boot script

* __l2MpsLN-R4-4-0__: 2023-05-18 jmock
  * Update bsaDriver to R4.0.0

* __l2MpsLN-R4-3-1__: 2023-05-17 jmock
  * Change RTM mitigation for mechanical shutter from
    dest 0x2 to dest 0xE in sioc-gunb-mp01

* __l2MpsLN-R4-3-0__: 2023-05-10 jmock
  * Upgrade bsaDriver to 3.2.1
    * Change init_lc2_bsas.cmd to work with bsaDriver 3.2.1
  * Fix calc bug to determine mode in modeManagerDN.db
  * Change INST for TPR from :1 to :0 

* __l2MpsLN-R4-2-2__: 2023-04-24 jmock
  * Change BSAS NTNDArray Prefix from {L2MPS_PREFIX} to {TPR}
    to be consistent with BPMs

* __l2MpsLN-R4-2-1__: 2023-04-23 jmock
  * Fix bug in modeManagerAN and modeManagerDN

* __l2MpsLN-R4-2-0__: 2023-04-23 jmock
  * Update BSA driver to 3.2.0
  * Add NC / SC BSA stream enable to FACMODE calc

* __l2MpsLN-R4-1-0__: 2023-02-07 jmock
  * Update mode manager PVs
  * Update boot scripts to make maintenance easier
  * Update FW/SW to 4.10.2 for bsa bug fix and DN yaml fix

* __l2MpsLN-R4-0-0__: 2023-02-07 jmock
  * Update mode manager database to read in external mode setting
  * Update mode manager database to change name from LCLSMODE
    to FACMODE
  * Rewrite l2MpsL1Bsa driver to be an epics thread instead of a POSIX thread
  * Add an asyn port driver component to set the slope and intercept of the
    lcls1 bsa data.  Follows same convention of LCLS2 BSA slope and intercept
  * Add PVs to read in and out the status of l1 bsa driver

* __l2MpsLN-R3-26-3__: 2023-01-11 jmock
  * Change units for application node from us to counts (raw)

* __l2MpsLN-R3-26-2__: 2022-10-23 J. Mock
  * Make RTM DO channel 1 in sioc-l0b-mp04 point to dest 13 for LHS

* __l2MpsLN-R3-26-1__: 2022-10-20 J. Mock
  * Add missing substitution file to repository

* __l2MpsLN-R3-26-0__: 2022-10-20 J. Mock
  * Load from ATCACommon new dbs for waveform and gain control

* __l2MpsLN-R3-25-0__: 2022-09-28 J. Mock
  * Upgrade AN and DN firmware to 4.8.6

* __l2MpsLN-R3-24-1__: 2022-09-06 J. Mock
  * Fix sioc-l0b-mp05/st.cmd to point to shm-l0b-sp03-1 (10.0.1.102)

* __l2MpsLN-R3-24-0__: 2022-09-03 J. Mock
  * Upgrade Analog Link Node FW to 4.8.6
  * Stop temporarily loading yaml files from temp locations - load from downloader
  * Update init_timing script

* __l2MpsLN-R3-23-0__: 2022-08-31 J. Mock
  * Upgrade modules and FW to amc_carrier_core R4.8
  * Temporary: Load 000TopLevel.yaml file static - no downloader
  * Temporary: Load default.yaml static

* __l2MpsLN-R3-22-1__: 2022-05-16 J. Mock
  * Change scan rate of ANA_BSA PVs to .1 second
  * Change number of samples in diag stream to 1024
  * Set streams to automatically arm at bootup

* __l2MpsLN-R3-22-0__: 2022-05-16 J. Mock
  * Add mitigation_config.yaml to link node startup files for the 
    5 link nodes that are also mitigation nodes to properly configure
    them to listen to correct destinations.

* __l2MpsLN-R3-21-1__: 2022-05-16 J. Mock
  * Change path to epics area in link_node_launch.cmd to point to current
  * Temporarily load defaults.yaml file for link node from iocBoot/common/config
    until problem in FW is fixed

* __l2MpsLN-R3-21-0__: 2022-05-06 J. Mock
  * Upgrade ApplicationNode and DigitalNode FW to R4.8.1
  * Upgrade AnalogLinkNode to FW R4.7.0
  * Add PV and register access for latching timing fault
  * Upgrade to l2Mps R3.8.0
  * Upgrade to l2MpsAsyn R3.12.0
  * Change BSA type from uint32 to int32

* __l2MpsLN-R3-20-0__: 2022-01-11 J. Mock
  * Add script for auto archive file generation

* __l2MpsLN-R3-19-2__: 2022-01-11 J. Mock
  * Fix bug related to mode calculation and setting.

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
