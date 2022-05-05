
module CPU (
	clk_clk,
	pio_key_external_connection_export,
	pio_led_external_connection_export,
	pio_wifi_reset_external_connection_export,
	reset_reset_n,
	wifi_uart0_external_connection_rxd,
	wifi_uart0_external_connection_txd,
	wifi_uart0_external_connection_cts_n,
	wifi_uart0_external_connection_rts_n,
	get_pixels_slave_0_conduit_end_r_export,
	get_pixels_slave_0_conduit_end_g_export,
	get_pixels_slave_0_conduit_end_b_export,
	get_pixels_slave_0_conduit_end_x_export,
	get_pixels_slave_0_conduit_end_y_export,
	get_pixels_slave_0_conduit_end_sw_export,
	get_pixels_slave_0_conduit_end_reqclk_export,
	frame_control_slave_0_conduit_end_sw0_export,
	frame_control_slave_0_conduit_end_sw1_export);	

	input		clk_clk;
	input	[1:0]	pio_key_external_connection_export;
	output	[3:0]	pio_led_external_connection_export;
	output		pio_wifi_reset_external_connection_export;
	input		reset_reset_n;
	input		wifi_uart0_external_connection_rxd;
	output		wifi_uart0_external_connection_txd;
	input		wifi_uart0_external_connection_cts_n;
	output		wifi_uart0_external_connection_rts_n;
	input	[7:0]	get_pixels_slave_0_conduit_end_r_export;
	input	[7:0]	get_pixels_slave_0_conduit_end_g_export;
	input	[7:0]	get_pixels_slave_0_conduit_end_b_export;
	input	[10:0]	get_pixels_slave_0_conduit_end_x_export;
	input	[10:0]	get_pixels_slave_0_conduit_end_y_export;
	input		get_pixels_slave_0_conduit_end_sw_export;
	output		get_pixels_slave_0_conduit_end_reqclk_export;
	output		frame_control_slave_0_conduit_end_sw0_export;
	output		frame_control_slave_0_conduit_end_sw1_export;
endmodule
