module dct(input csi_clk,
           input rsi_reset_n,
           input [7:0] avs_s0_address,
           input avs_s0_write, input [31:0] avs_s0_writedata,
           input avs_s0_read, output reg [31:0] avs_s0_readdata);

logic [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
logic [15:0] y0,y1,y2,y3,y4,y5,y6,y7;

always_ff @(posedge csi_clk or negedge rsi_reset_n) begin
    if(!rsi_reset_n) begin
        x0 <= 0;
        x1 <= 0;
        x2 <= 0;
        x3 <= 0;
        x4 <= 0;
        x5 <= 0;
        x6 <= 0;
        x7 <= 0;
    end else begin
        if(avs_s0_write) begin
            case(avs_s0_address)
            3'b000: x0 <= avs_s0_writedata[15:0];
            3'b001: x1 <= avs_s0_writedata[15:0];
            3'b010: x2 <= avs_s0_writedata[15:0];
            3'b011: x3 <= avs_s0_writedata[15:0];
            3'b100: x4 <= avs_s0_writedata[15:0];
            3'b101: x5 <= avs_s0_writedata[15:0];
            3'b110: x6 <= avs_s0_writedata[15:0];
            3'b111: x7 <= avs_s0_writedata[15:0];
            default:;
            endcase
        end
    end
    
end

fast_test U1(x0,x1,x2,x3,x4,x5,x6,x7,y0,y1,y2,y3,y4,y5,y6,y7);

always_ff @(posedge csi_clk) begin
    if(avs_s0_read) begin
        case(avs_s0_address)
        3'b000: avs_s0_readdata <= {16'b0000000000000000,y0};
        3'b001: avs_s0_readdata <= {16'b0000000000000000,y1};
        3'b010: avs_s0_readdata <= {16'b0000000000000000,y2};
        3'b011: avs_s0_readdata <= {16'b0000000000000000,y3};
        3'b100: avs_s0_readdata <= {16'b0000000000000000,y4};
        3'b101: avs_s0_readdata <= {16'b0000000000000000,y5};
        3'b110: avs_s0_readdata <= {16'b0000000000000000,y6};
        3'b111: avs_s0_readdata <= {16'b0000000000000000,y7};
        default: avs_s0_readdata <= 32'hXXXX;
        endcase
    end
    
end



endmodule