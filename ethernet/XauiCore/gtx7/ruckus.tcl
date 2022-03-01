# Load RUCKUS library
source $::env(RUCKUS_PROC_TCL_QUIET)

# Load Source Code
if { $::env(VIVADO_VERSION) >= 2014.4 } {
   loadSource -lib surf -dir  "$::DIR_PATH/rtl"
   loadSource -lib surf -path "$::DIR_PATH/images/XauiGtx7Core_block.dcp"
} else {
   puts "\n\nWARNING: $::DIR_PATH requires Vivado 2014.4 (or later)\n\n"
}
