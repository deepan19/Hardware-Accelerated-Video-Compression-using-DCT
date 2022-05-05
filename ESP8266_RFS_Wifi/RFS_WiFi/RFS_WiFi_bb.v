
module RFS_WiFi (
	clk_clk,
	frame_controller_0_conduit_end_sw0_export,
	frame_controller_0_conduit_end_sw1_export,
	get3_0_conduit_end_b_export,
	get3_0_conduit_end_g_export,
	get3_0_conduit_end_r_export,
	get3_0_conduit_end_reqclk_export,
	get3_0_conduit_end_sw_export,
	get3_0_conduit_end_x_export,
	get3_0_conduit_end_y_export,
	pio_key_external_connection_export,
	pio_led_external_connection_export,
	pio_wifi_reset_external_connection_export,
	reset_reset_n,
	seg7_if_0_conduit_end_export,
	wifi_uart0_external_connection_rxd,
	wifi_uart0_external_connection_txd,
	wifi_uart0_external_connection_cts_n,
	wifi_uart0_external_connection_rts_n);	

	input		clk_clk;
	output		frame_controller_0_conduit_end_sw0_export;
	output		frame_controller_0_conduit_end_sw1_export;
	input	[7:0]	get3_0_conduit_end_b_export;
	input	[7:0]	get3_0_conduit_end_g_export;
	input	[7:0]	get3_0_conduit_end_r_export;
	output		get3_0_conduit_end_reqclk_export;
	input		get3_0_conduit_end_sw_export;
	input	[10:0]	get3_0_conduit_end_x_export;
	input	[10:0]	get3_0_conduit_end_y_export;
	input	[1:0]	pio_key_external_connection_export;
	output	[3:0]	pio_led_external_connection_export;
	output		pio_wifi_reset_external_connection_export;
	input		reset_reset_n;
	output	[47:0]	seg7_if_0_conduit_end_export;
	input		wifi_uart0_external_connection_rxd;
	output		wifi_uart0_external_connection_txd;
	input		wifi_uart0_external_connection_cts_n;
	output		wifi_uart0_external_connection_rts_n;
endmodule
