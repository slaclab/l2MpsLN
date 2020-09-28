#!/bin/bash
# This script will write the FW image specified in argument 1 to all the mps Application Nodes that are in use.
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sph-sp06-1 -n 5 -c cpu-sph-sp06 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsyh-sp01-1 -n 6 -c cpu-bsyh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sps-sp05-2 -n 5 -c cpu-sps-sp05 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sps-sp05-2 -n 6 -c cpu-sps-sp05 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsys-sp01-1 -n 5 -c cpu-bsys-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsys-sp01-1 -n 6 -c cpu-bsys-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp03-1 -n 6 -c cpu-ltuh-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp03-1 -n 6 -c cpu-ltus-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp01-1 -n 7 -c cpu-undh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp02-2 -n 6 -c cpu-undh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp02-1 -n 6 -c cpu-unds-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp02-1 -n 7 -c cpu-unds-sp02 -m $1
