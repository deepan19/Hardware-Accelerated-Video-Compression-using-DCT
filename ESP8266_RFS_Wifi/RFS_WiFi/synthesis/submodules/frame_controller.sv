module frame_controller(input csi_clk, input rsi_reset_n,
                        output coe_c0_SW0, coe_c0_SW1,
                        input [1:0] avs_s0_address,
                        input avs_s0_write, input [31:0] avs_s0_writedata);

always_ff @(posedge csi_clk or negedge rsi_reset_n) begin
    if(!rsi_reset_n) begin
        coe_c0_SW0 <= 0;
        coe_c0_SW1 <= 0;
    end else begin
        if(avs_s0_write) begin
            case(avs_s0_address)
            1'b0: coe_c0_SW0 <= avs_s0_writedata[0];
            1'b1: coe_c0_SW1 <= avs_s0_writedata[0];
            endcase
        end 
    end

end
endmodule