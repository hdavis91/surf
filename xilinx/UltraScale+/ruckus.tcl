# Load RUCKUS library
source $::env(RUCKUS_PROC_TCL_QUIET)

# Load the Core
loadRuckusTcl "$::DIR_PATH/../UltraScale/general"
loadRuckusTcl "$::DIR_PATH/clocking"
loadRuckusTcl "$::DIR_PATH/gthUs"
