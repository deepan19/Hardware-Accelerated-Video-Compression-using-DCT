module get3(input [7:0] coe_c0_red,input [7:0] coe_c1_green, input [7:0] coe_c2_blue,
           input coe_c3_switchzero, output coe_c4_requestclock,
           input [10:0] coe_c5_x, input [10:0] coe_c6_y,
           input csi_clk,input rsi_reset_n,
           output avs_s0_waitrequest,
           input avs_s0_read, output [31:0] avs_s0_readdata);

logic done;
logic [4:0] state;

always_comb begin
    if(avs_s0_read) begin
        case(done)
        1'b1: avs_s0_waitrequest = 1'b0;
        1'b0: avs_s0_waitrequest = 1'b1;
        default:avs_s0_waitrequest = 1'bx;
        endcase
    end else begin
        avs_s0_waitrequest = 1'b0;
    end
end

parameter WAIT_FOR_READ = 5'b00000;
parameter CLOCK = 5'b00001;
parameter WAIT = 5'b00010;
parameter CHECK_X_Y = 5'b00011;
parameter STORE = 5'b00101;
parameter FINISH = 5'b00110;
parameter READ1 = 5'b00111;
parameter READ2 = 5'b01000;

always_ff @(posedge csi_clk or negedge rsi_reset_n) begin
    if(!rsi_reset_n) begin
        state <= WAIT_FOR_READ;
    end else begin
        case(state)
        WAIT_FOR_READ: begin
            if(avs_s0_read)
                state <= CLOCK;
            else
                state <= WAIT_FOR_READ;
        end
        CLOCK: state <= WAIT;
        WAIT: state <= CHECK_X_Y;
        CHECK_X_Y: begin
            if((coe_c5_x>=6) && (coe_c5_x<=637)) begin
                state <= STORE;
            end else if((coe_c5_x>=1) && (coe_c5_x<=5)) begin
                state <= FINISH;
            end else if ((coe_c5_x>=638) && (coe_c5_x<=640)) begin
                state <= FINISH;
            end else begin
                state <= CLOCK;
            end
        end
        STORE: state <= FINISH;
        FINISH: state <= READ1;
        READ1: state <= READ2;
        READ2: state <= WAIT_FOR_READ;
        default: state <= WAIT_FOR_READ;
        endcase
    end
    
end

always_ff @(posedge csi_clk) begin
    case(state)
    WAIT_FOR_READ: begin
        done <= 1'b0;
        avs_s0_readdata <= 32'd0;
        coe_c4_requestclock <= 1'b0;
    end
    CLOCK: begin
        coe_c4_requestclock <= 1'b1;
    end
    WAIT: begin
        coe_c4_requestclock <= 1'b0;
    end
    CHECK_X_Y:;
    STORE: begin
        avs_s0_readdata <= {8'b00000000,coe_c0_red,coe_c1_green,coe_c2_blue};
    end
    FINISH: begin
        done <= 1'b1;
    end

    READ1:;

    READ2:;
    default:;
    endcase
end

endmodule
