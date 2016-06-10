##############################################################################
## This file is part of 'SLAC Firmware Standard Library'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SLAC Firmware Standard Library', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

# Project SDK Run Script

#############################
## Get build system variables 
#############################
set VIVADO_BUILD_DIR $::env(VIVADO_BUILD_DIR)
source ${VIVADO_BUILD_DIR}/vivado_env_var_v1.tcl

sdk setws ${SDK_PRJ}
sdk projects -build  -type all
exec cp -f ${SDK_PRJ}/app_0/Release/app_0.elf ${SDK_ELF} 
exec chmod 664 ${SDK_ELF} 