-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Common shim layer between IP Integrator interface and surf AXI Stream interface
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'SLAC Firmware Standard Library', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;

entity HD_SlaveAxiStreamIpIntegrator is
   generic (
      INTERFACENAME   : string                 := "S_AXIS";
      HAS_TLAST       : natural range 0 to 1   := 1;
      HAS_TKEEP       : natural range 0 to 1   := 1;
      HAS_TSTRB       : natural range 0 to 1   := 0;
      HAS_TREADY      : natural range 0 to 1   := 1;
      TUSER_WIDTH     : natural range 1 to 8   := 2;
      TID_WIDTH       : natural range 1 to 8   := 1;
      TDEST_WIDTH     : natural range 1 to 8   := 1;
      TDATA_NUM_BYTES : natural range 1 to 128 := 1);
   port (
      -- IP Integrator AXI Stream Interface
      S_AXIS_ACLK    : in  std_logic                                        := '0';
      S_AXIS_ARESETN : in  std_logic                                        := '0';
      S_AXIS_TVALID  : in  std_logic                                        := '0';
      S_AXIS_TDATA   : in  std_logic_vector((8*TDATA_NUM_BYTES)-1 downto 0) := (others => '0');
      S_AXIS_TSTRB   : in  std_logic_vector(TDATA_NUM_BYTES-1 downto 0)     := (others => '0');
      S_AXIS_TKEEP   : in  std_logic_vector(TDATA_NUM_BYTES-1 downto 0)     := (others => '0');
      S_AXIS_TLAST   : in  std_logic                                        := '0';
      S_AXIS_TDEST   : in  std_logic_vector(TDEST_WIDTH-1 downto 0)         := (others => '0');
      S_AXIS_TID     : in  std_logic_vector(TID_WIDTH-1 downto 0)           := (others => '0');
      S_AXIS_TUSER   : in  std_logic_vector(TUSER_WIDTH-1 downto 0)         := (others => '0');
      S_AXIS_TREADY  : out std_logic;
      -- SURF AXI Stream Interface
      axisMaster     : out HD_AxiStreamMasterType;
      axisSlave      : in  AxiStreamSlaveType := AXI_STREAM_SLAVE_FORCE_C);
end HD_SlaveAxiStreamIpIntegrator;

architecture mapping of HD_SlaveAxiStreamIpIntegrator is

   attribute X_INTERFACE_INFO      : string;
   attribute X_INTERFACE_PARAMETER : string;

   attribute X_INTERFACE_INFO of S_AXIS_TVALID     : signal is "xilinx.com:interface:axis:1.0 " & INTERFACENAME & " TVALID";
   attribute X_INTERFACE_INFO of S_AXIS_TLAST      : signal is "xilinx.com:interface:axis:1.0 " & INTERFACENAME & " TLAST";
   attribute X_INTERFACE_INFO of S_AXIS_TDATA      : signal is "xilinx.com:interface:axis:1.0 " & INTERFACENAME & " TDATA";
   attribute X_INTERFACE_INFO of S_AXIS_TKEEP      : signal is "xilinx.com:interface:axis:1.0 " & INTERFACENAME & " TKEEP";
   attribute X_INTERFACE_INFO of S_AXIS_TREADY     : signal is "xilinx.com:interface:axis:1.0 " & INTERFACENAME & " TREADY";
   attribute X_INTERFACE_PARAMETER of S_AXIS_TDATA : signal is
      "XIL_INTERFACENAME " & INTERFACENAME & ", " &
      "LAYERED_METADATA undef, " &
      "HAS_TLAST " & integer'image(HAS_TLAST) & ", " &
      "HAS_TKEEP " & integer'image(HAS_TKEEP) & ", " &
      "HAS_TSTRB " & integer'image(HAS_TSTRB) & ", " &
      "HAS_TREADY " & integer'image(HAS_TREADY) & ", " &
      "TDATA_NUM_BYTES " & integer'image(TDATA_NUM_BYTES);

   attribute X_INTERFACE_INFO of S_AXIS_ARESETN      : signal is "xilinx.com:signal:reset:1.0 RST." & INTERFACENAME & "_ARESETN RST";
   attribute X_INTERFACE_PARAMETER of S_AXIS_ARESETN : signal is
      "XIL_INTERFACENAME RST." & INTERFACENAME & "_ARESETN, " &
      "POLARITY ACTIVE_LOW";

   attribute X_INTERFACE_INFO of S_AXIS_ACLK      : signal is "xilinx.com:signal:clock:1.0 CLK." & INTERFACENAME & "_ACLK CLK";
   attribute X_INTERFACE_PARAMETER of S_AXIS_ACLK : signal is
      "XIL_INTERFACENAME CLK." & INTERFACENAME & "_ACLK, " &
      "ASSOCIATED_BUSIF " & INTERFACENAME & ", " &
      "ASSOCIATED_RESET " & INTERFACENAME & "_ARESETN";

    constant HD_AXI_STREAM_MASTER_INIT_C : HD_AxiStreamMasterType(tdata(TDATA_NUM_BYTES*8-1 downto 0),tstrb(TDATA_NUM_BYTES-1 downto 0),tkeep(TDATA_NUM_BYTES-1 downto 0)):= (
        tValid => '0',
        tData  => (others => '0'),
        tStrb  => (others => '1'),
        tKeep  => (others => '1'),
        tLast  => '0');


   signal S_AXIS_Master : HD_AxiStreamMasterType(tdata(TDATA_NUM_BYTES*8-1 downto 0),tstrb(TDATA_NUM_BYTES-1 downto 0),tkeep(TDATA_NUM_BYTES-1 downto 0));
   signal S_AXIS_Slave  : AxiStreamSlaveType  := AXI_STREAM_SLAVE_FORCE_C;

begin
   axisMaster   <= S_AXIS_Master;
   S_AXIS_Slave <= axisSlave;

   S_AXIS_Master.tValid                                <= S_AXIS_TVALID;
   S_AXIS_Master.tData((8*TDATA_NUM_BYTES)-1 downto 0) <= S_AXIS_TDATA;
   S_AXIS_Master.tStrb(TDATA_NUM_BYTES-1 downto 0)     <= S_AXIS_TSTRB when(HAS_TSTRB /= 0) else (others => '1');
   S_AXIS_Master.tKeep(TDATA_NUM_BYTES-1 downto 0)     <= S_AXIS_TKEEP when(HAS_TKEEP /= 0) else (others => '1');
   S_AXIS_Master.tLast                                 <= S_AXIS_TLAST when(HAS_TLAST /= 0) else '0';
   S_AXIS_TREADY <= S_AXIS_Slave.tReady when(HAS_TREADY /= 0) else '1';

end mapping;
