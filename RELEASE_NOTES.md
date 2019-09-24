# Release notes

Release notes for the SLAC LCLS-II HPS MPS Link Node

## Releases:
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
