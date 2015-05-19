-------------------------------------------------------------------------------
-- Title         : Version Constant File
-- Project       : COB Zynq DTM
-------------------------------------------------------------------------------
-- File          : Version.vhd
-- Author        : Ryan Herbst, rherbst@slac.stanford.edu
-- Created       : 05/18/2014
-------------------------------------------------------------------------------
-- Description:
-- Version Constant Module
-------------------------------------------------------------------------------
-- Copyright (c) 2012 by SLAC. All rights reserved.
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

package Version is

constant FPGA_VERSION_C : std_logic_vector(31 downto 0) := x"00000005"; -- MAKE_VERSION

constant BUILD_STAMP_C : string := "JesdAdcKc705: Vivado v2014.4 (x86_64) Built Mon May 18 15:46:12 PDT 2015 by bareese";

end Version;
 
-------------------------------------------------------------------------------
-- Revision History:
-------------------------------------------------------------------------------
-- 05/15/2015 - 00000000      - ADC F22 61.44MHz out. 370MHz ref
-- 05/15/2015 - 00000001      - ADC F22 61.44MHz out. 184.32MHz ref 7.3728GHz
-- 05/18/2015 - 00000002      - ADC F22 61.44MHz out. 184.32MHz ref 7.3728GHz. Pol = '1'
-- 05/18/2015 - 00000003      - ADC F22 61.44MHz out. 184.32MHz ref 7.3728GHz. Pol = '1', byte swapped
-- 05/18/2015 - 00000004      - ADC F22 61.44MHz out. 184.32MHz ref 7.3728GHz. Pol = '0', byte swapped
-- 05/18/2015 - 00000005      - Chipscope test