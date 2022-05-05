	component CPU is
		port (
			clk_clk                                      : in  std_logic                     := 'X';             -- clk
			pio_key_external_connection_export           : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			pio_led_external_connection_export           : out std_logic_vector(3 downto 0);                     -- export
			pio_wifi_reset_external_connection_export    : out std_logic;                                        -- export
			reset_reset_n                                : in  std_logic                     := 'X';             -- reset_n
			wifi_uart0_external_connection_rxd           : in  std_logic                     := 'X';             -- rxd
			wifi_uart0_external_connection_txd           : out std_logic;                                        -- txd
			wifi_uart0_external_connection_cts_n         : in  std_logic                     := 'X';             -- cts_n
			wifi_uart0_external_connection_rts_n         : out std_logic;                                        -- rts_n
			get_pixels_slave_0_conduit_end_r_export      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			get_pixels_slave_0_conduit_end_g_export      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			get_pixels_slave_0_conduit_end_b_export      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			get_pixels_slave_0_conduit_end_x_export      : in  std_logic_vector(10 downto 0) := (others => 'X'); -- export
			get_pixels_slave_0_conduit_end_y_export      : in  std_logic_vector(10 downto 0) := (others => 'X'); -- export
			get_pixels_slave_0_conduit_end_sw_export     : in  std_logic                     := 'X';             -- export
			get_pixels_slave_0_conduit_end_reqclk_export : out std_logic;                                        -- export
			frame_control_slave_0_conduit_end_sw0_export : out std_logic;                                        -- export
			frame_control_slave_0_conduit_end_sw1_export : out std_logic                                         -- export
		);
	end component CPU;

	u0 : component CPU
		port map (
			clk_clk                                      => CONNECTED_TO_clk_clk,                                      --                                   clk.clk
			pio_key_external_connection_export           => CONNECTED_TO_pio_key_external_connection_export,           --           pio_key_external_connection.export
			pio_led_external_connection_export           => CONNECTED_TO_pio_led_external_connection_export,           --           pio_led_external_connection.export
			pio_wifi_reset_external_connection_export    => CONNECTED_TO_pio_wifi_reset_external_connection_export,    --    pio_wifi_reset_external_connection.export
			reset_reset_n                                => CONNECTED_TO_reset_reset_n,                                --                                 reset.reset_n
			wifi_uart0_external_connection_rxd           => CONNECTED_TO_wifi_uart0_external_connection_rxd,           --        wifi_uart0_external_connection.rxd
			wifi_uart0_external_connection_txd           => CONNECTED_TO_wifi_uart0_external_connection_txd,           --                                      .txd
			wifi_uart0_external_connection_cts_n         => CONNECTED_TO_wifi_uart0_external_connection_cts_n,         --                                      .cts_n
			wifi_uart0_external_connection_rts_n         => CONNECTED_TO_wifi_uart0_external_connection_rts_n,         --                                      .rts_n
			get_pixels_slave_0_conduit_end_r_export      => CONNECTED_TO_get_pixels_slave_0_conduit_end_r_export,      --      get_pixels_slave_0_conduit_end_r.export
			get_pixels_slave_0_conduit_end_g_export      => CONNECTED_TO_get_pixels_slave_0_conduit_end_g_export,      --      get_pixels_slave_0_conduit_end_g.export
			get_pixels_slave_0_conduit_end_b_export      => CONNECTED_TO_get_pixels_slave_0_conduit_end_b_export,      --      get_pixels_slave_0_conduit_end_b.export
			get_pixels_slave_0_conduit_end_x_export      => CONNECTED_TO_get_pixels_slave_0_conduit_end_x_export,      --      get_pixels_slave_0_conduit_end_x.export
			get_pixels_slave_0_conduit_end_y_export      => CONNECTED_TO_get_pixels_slave_0_conduit_end_y_export,      --      get_pixels_slave_0_conduit_end_y.export
			get_pixels_slave_0_conduit_end_sw_export     => CONNECTED_TO_get_pixels_slave_0_conduit_end_sw_export,     --     get_pixels_slave_0_conduit_end_sw.export
			get_pixels_slave_0_conduit_end_reqclk_export => CONNECTED_TO_get_pixels_slave_0_conduit_end_reqclk_export, -- get_pixels_slave_0_conduit_end_reqclk.export
			frame_control_slave_0_conduit_end_sw0_export => CONNECTED_TO_frame_control_slave_0_conduit_end_sw0_export, -- frame_control_slave_0_conduit_end_sw0.export
			frame_control_slave_0_conduit_end_sw1_export => CONNECTED_TO_frame_control_slave_0_conduit_end_sw1_export  -- frame_control_slave_0_conduit_end_sw1.export
		);

