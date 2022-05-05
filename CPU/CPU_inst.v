	CPU u0 (
		.clk_clk                                      (<connected-to-clk_clk>),                                      //                                   clk.clk
		.pio_key_external_connection_export           (<connected-to-pio_key_external_connection_export>),           //           pio_key_external_connection.export
		.pio_led_external_connection_export           (<connected-to-pio_led_external_connection_export>),           //           pio_led_external_connection.export
		.pio_wifi_reset_external_connection_export    (<connected-to-pio_wifi_reset_external_connection_export>),    //    pio_wifi_reset_external_connection.export
		.reset_reset_n                                (<connected-to-reset_reset_n>),                                //                                 reset.reset_n
		.wifi_uart0_external_connection_rxd           (<connected-to-wifi_uart0_external_connection_rxd>),           //        wifi_uart0_external_connection.rxd
		.wifi_uart0_external_connection_txd           (<connected-to-wifi_uart0_external_connection_txd>),           //                                      .txd
		.wifi_uart0_external_connection_cts_n         (<connected-to-wifi_uart0_external_connection_cts_n>),         //                                      .cts_n
		.wifi_uart0_external_connection_rts_n         (<connected-to-wifi_uart0_external_connection_rts_n>),         //                                      .rts_n
		.get_pixels_slave_0_conduit_end_r_export      (<connected-to-get_pixels_slave_0_conduit_end_r_export>),      //      get_pixels_slave_0_conduit_end_r.export
		.get_pixels_slave_0_conduit_end_g_export      (<connected-to-get_pixels_slave_0_conduit_end_g_export>),      //      get_pixels_slave_0_conduit_end_g.export
		.get_pixels_slave_0_conduit_end_b_export      (<connected-to-get_pixels_slave_0_conduit_end_b_export>),      //      get_pixels_slave_0_conduit_end_b.export
		.get_pixels_slave_0_conduit_end_x_export      (<connected-to-get_pixels_slave_0_conduit_end_x_export>),      //      get_pixels_slave_0_conduit_end_x.export
		.get_pixels_slave_0_conduit_end_y_export      (<connected-to-get_pixels_slave_0_conduit_end_y_export>),      //      get_pixels_slave_0_conduit_end_y.export
		.get_pixels_slave_0_conduit_end_sw_export     (<connected-to-get_pixels_slave_0_conduit_end_sw_export>),     //     get_pixels_slave_0_conduit_end_sw.export
		.get_pixels_slave_0_conduit_end_reqclk_export (<connected-to-get_pixels_slave_0_conduit_end_reqclk_export>), // get_pixels_slave_0_conduit_end_reqclk.export
		.frame_control_slave_0_conduit_end_sw0_export (<connected-to-frame_control_slave_0_conduit_end_sw0_export>), // frame_control_slave_0_conduit_end_sw0.export
		.frame_control_slave_0_conduit_end_sw1_export (<connected-to-frame_control_slave_0_conduit_end_sw1_export>)  // frame_control_slave_0_conduit_end_sw1.export
	);

