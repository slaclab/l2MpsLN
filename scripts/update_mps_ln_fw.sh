#!/bin/bash
# This script will write the FW image specified in argument 1 to all the mps Link Nodes that are in use.
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sph-sp06-1 -n 2 -c cpu-sph-sp06 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsyh-sp01-1 -n 2 -c cpu-bsyh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsyh-sp02-1 -n 2 -c cpu-bsyh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sps-sp05-2 -n 2 -c cpu-sps-sp05 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-sps-sp05-1 -n 2 -c cpu-sps-sp05 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsys-sp01-1 -n 2 -c cpu-bsys-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-bsys-sp02-1 -n 2 -c cpu-bsys-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp01-1 -n 2 -c cpu-ltuh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp01-2 -n 2 -c cpu-ltuh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp02-1 -n 2 -c cpu-ltuh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp02-2 -n 2 -c cpu-ltuh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltuh-sp03-1 -n 2 -c cpu-ltuh-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp01-1 -n 2 -c cpu-ltus-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp02-1 -n 2 -c cpu-ltus-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp02-2 -n 2 -c cpu-ltus-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp03-1 -n 2 -c cpu-ltus-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-ltus-sp04-1 -n 2 -c cpu-ltus-sp04 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp01-1 -n 2 -c cpu-undh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp01-2 -n 2 -c cpu-undh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp01-3 -n 2 -c cpu-undh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp02-1 -n 2 -c cpu-undh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp02-2 -n 2 -c cpu-undh-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp03-1 -n 2 -c cpu-undh-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-undh-sp03-2 -n 2 -c cpu-undh-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp01-1 -n 2 -c cpu-unds-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp02-1 -n 2 -c cpu-unds-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp02-2 -n 2 -c cpu-unds-sp02 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp03-1 -n 2 -c cpu-unds-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-unds-sp03-2 -n 2 -c cpu-unds-sp03 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-feeh-sp01-1 -n 2 -c cpu-feeh-sp01 -m $1
/usr/local/lcls/package/cpsw/utils/ProgramFPGA/R1.2.0/ProgramFPGA.bash -s shm-fees-sp01-1 -n 2 -c cpu-fees-sp01 -m $1

