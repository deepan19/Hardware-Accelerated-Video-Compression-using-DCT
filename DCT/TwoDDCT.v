module eight_test(
    input CLOCK_50
);

logic clk;
assign clk = CLOCK_50;

logic [11:0] clk_count;

always_ff @(posedge clk) begin
    case(B_finish)
    1: clk_count <= clk_count;
    0: clk_count <= clk_count + 11'd1;
    default: clk_count <= 11'd0;
    endcase
end

matA	matA_inst (
	.address ( addressA ),
	.clock ( clk ),
	.q ( qA )
	);

matB	matB_inst (
	.address ( addressB ),
	.clock ( clk ),
	.data ( data_in_B ),
	.wren ( wrenB ),
    .q(qB)
	);

assign addressB = A_finish ? addressB_2 : addressB_1;

matC	matC_inst (
	.address ( addressC ),
	.clock ( clk ),
	.data ( data_in_C ),
	.wren ( wrenC ),
	.q ( qC )
	);

logic [5:0] addressA, addressB, addressC;
logic [5:0] addressB_1, addressB_2;
logic [14:0] qA, qB, qC;
logic wrenB, wrenC;
logic [14:0] data_in_B, data_in_C;



logic [9:0] stateA /* synthesis keep */;

parameter A_IDLE =                10'b0000000000;
parameter A_READ_NEW_ROW =        10'b0000000001;
parameter A_READ_ROW_ELEM =       10'b0000000010;
parameter A_READ_INCREMENT_COL =  10'b0000000011;
parameter A_READ_CHECK_LIMIT =    10'b0000001101;
parameter A_READ_ROW_ELEM_WAIT =  10'b0000000100;
parameter A_WRITE_ROW_ELEM =      10'b0000000101;
parameter A_WAIT1 =               10'b0000000110;
parameter A_WAIT2 =               10'b0000000111;
parameter A_WAIT3 =               10'b0000001000;
parameter A_WRITE_INCREMENT_COL = 10'b0000001001;
parameter A_WRITE_CHECK_LIMIT =   10'b0000001110;
parameter A_INCREMENT_ROW =       10'b0000001010;
parameter A_ROW_LIMIT_CHECK =     10'b0000001111;
parameter A_FINISH =              10'b0000001011;
parameter A_STOP =                10'b0000001100;


logic [3:0] A_row;
logic [3:0] A_col_r;
logic [3:0] A_col_w;

logic [14:0] Ax[7:0];
logic [14:0] Ay[7:0];

logic A_finish;
fast_test DCT_INST(.x0(Ax[0]),
                   .x1(Ax[1]),
                   .x2(Ax[2]),
                   .x3(Ax[3]),
                   .x4(Ax[4]),
                   .x5(Ax[5]),
                   .x6(Ax[6]),
                   .x7(Ax[7]),
                   .y0(Ay[0]),
                   .y1(Ay[1]),
                   .y2(Ay[2]),
                   .y3(Ay[3]),
                   .y4(Ay[4]),
                   .y5(Ay[5]),
                   .y6(Ay[6]),
                   .y7(Ay[7]));


//CONTROLLER stateA MACHINE
always_ff @(posedge clk) begin
    case(stateA)
    A_IDLE: stateA <= A_READ_NEW_ROW;
    A_READ_NEW_ROW: stateA <= A_READ_ROW_ELEM;
    A_READ_ROW_ELEM: stateA <= A_READ_INCREMENT_COL;
    A_READ_INCREMENT_COL: stateA <= A_READ_CHECK_LIMIT;
    A_READ_CHECK_LIMIT: begin
        if(A_col_r >= 4'd8)
            stateA <= A_WRITE_ROW_ELEM;
        else
            stateA <= A_READ_ROW_ELEM_WAIT;
    end
    A_READ_ROW_ELEM_WAIT: stateA <= A_READ_ROW_ELEM;
    A_WRITE_ROW_ELEM: stateA <= A_WAIT1;
    A_WAIT1: stateA <= A_WAIT2;
    A_WAIT2: stateA <= A_WAIT3;
    A_WAIT3: stateA <= A_STOP;
    A_STOP: stateA <= A_WRITE_INCREMENT_COL;
    A_WRITE_INCREMENT_COL: stateA <= A_WRITE_CHECK_LIMIT;
    A_WRITE_CHECK_LIMIT: begin
        if(A_col_w >= 4'd8)
            stateA <= A_INCREMENT_ROW;
        else
            stateA <= A_WRITE_ROW_ELEM;
    end
    A_INCREMENT_ROW: stateA <= A_ROW_LIMIT_CHECK;
    A_ROW_LIMIT_CHECK: begin
        if(A_row >= 4'd8)
            stateA <= A_FINISH;
        else
            stateA <= A_READ_NEW_ROW;
    end
    A_FINISH: stateA <= A_FINISH;
    default: stateA <= A_IDLE;
    endcase

end


//CONTROLLER OUTPUT
always_ff @(posedge clk) begin
    case(stateA)
    A_IDLE: begin
        addressA <= 6'd0;
        addressB_1 <= 6'd0;
        A_row <= 4'd0;
        A_col_r <= 4'd0;
        A_col_w <= 4'd0;
        wrenB <= 1'b0;
        A_finish <= 1'b0;
    end
    A_READ_NEW_ROW:;
    A_READ_ROW_ELEM: begin
        Ax[A_col_r] <= qA;
    end    
    A_READ_INCREMENT_COL: begin
        A_col_r <= A_col_r + 4'd1;
        addressA <= addressA + 6'd1;
    end
    A_READ_CHECK_LIMIT:;
    A_READ_ROW_ELEM_WAIT: ;
    A_WRITE_ROW_ELEM: begin
        data_in_B <= Ay[A_col_w];
    end
    A_WAIT1: begin
        wrenB <= 1'b1;
    end
    A_WAIT2:;
    A_WAIT3:;
    A_STOP: begin
        wrenB <= 1'b0;
    end
    A_WRITE_INCREMENT_COL: begin
        A_col_w <= A_col_w + 4'd1;
        addressB_1 <= addressB_1 + 6'd1;
    end
    A_WRITE_CHECK_LIMIT:;
    A_INCREMENT_ROW: begin
        A_row <= A_row + 4'd1;
        A_col_r <= 4'd0;
        A_col_w <= 4'd0;
    end
    A_ROW_LIMIT_CHECK:;
    A_FINISH: begin
        A_finish <= 1'b1;
        wrenB <= 1'b0;
    end
    default:;
    endcase
end

logic [9:0] stateB /* synthesis keep */;

parameter B_IDLE =                10'b0000000000;
parameter B_READ_NEW_COL =        10'b0000000001;
parameter B_READ_COL_ELEM =       10'b0000000010;
parameter B_READ_INCREMENT_ROW1 = 10'b0000000011;
parameter B_READ_CHECK_LIMIT =    10'b0000001101;
parameter B_READ_COL_ELEM_WAIT =  10'b0000000100;
parameter B_WRITE_COL_ELEM =      10'b0000000101;
parameter B_WAIT1 =               10'b0000000110;
parameter B_WAIT2 =               10'b0000000111;
parameter B_WAIT3 =               10'b0000001000;
parameter B_WRITE_INCREMENT_ROW1 = 10'b0000001001;
parameter B_WRITE_CHECK_LIMIT =   10'b0000001110;
parameter B_INCREMENT_COL =       10'b0000001010;
parameter B_COL_LIMIT_CHECK =     10'b0000001111;
parameter B_FINISH =              10'b0000001011;
parameter B_STOP =                10'b0000001100;
parameter B_READ_INCREMENT_ROW2 = 10'b0000010000;
parameter B_WRITE_INCREMENT_ROW2 = 10'b0000010001;
parameter B_READ_COL_ELEM_WAIT2 = 10'b0000010010;

logic [3:0] B_col;
logic [3:0] B_row_r;
logic [3:0] B_row_w;

logic [14:0] Bx[7:0];
logic [14:0] By[7:0];

logic B_finish;
fast_test DCT_INST2(.x0(Bx[0]),
                   .x1(Bx[1]),
                   .x2(Bx[2]),
                   .x3(Bx[3]),
                   .x4(Bx[4]),
                   .x5(Bx[5]),
                   .x6(Bx[6]),
                   .x7(Bx[7]),
                   .y0(By[0]),
                   .y1(By[1]),
                   .y2(By[2]),
                   .y3(By[3]),
                   .y4(By[4]),
                   .y5(By[5]),
                   .y6(By[6]),
                   .y7(By[7]));

//CONTROLLER STATE MACHINE B
always_ff @(posedge clk) begin
    case(stateB)
    B_IDLE: begin
        if(A_finish)
            stateB <= B_READ_NEW_COL;
        else
            stateB <= B_IDLE;
    end

    B_READ_NEW_COL: stateB <= B_READ_INCREMENT_ROW2;

    B_READ_INCREMENT_ROW2: stateB <= B_READ_COL_ELEM_WAIT;

    B_READ_COL_ELEM_WAIT: stateB <= B_READ_COL_ELEM_WAIT2;

    B_READ_COL_ELEM_WAIT2: stateB <= B_READ_COL_ELEM;

    B_READ_COL_ELEM: stateB <= B_READ_CHECK_LIMIT;

    B_READ_CHECK_LIMIT: begin
        if(B_row_r >= 4'd7)
            stateB <= B_WRITE_INCREMENT_ROW2;
        else 
            stateB <= B_READ_INCREMENT_ROW1;
    end

    B_READ_INCREMENT_ROW1: stateB <= B_READ_INCREMENT_ROW2;

    B_WRITE_INCREMENT_ROW2: stateB <= B_WRITE_COL_ELEM;

    B_WRITE_COL_ELEM: stateB <= B_WAIT1;

    B_WAIT1: stateB <= B_WAIT2;

    B_WAIT2: stateB <= B_WAIT3;

    B_WAIT3: stateB <= B_STOP;

    B_STOP: stateB <= B_WRITE_CHECK_LIMIT;

    B_WRITE_CHECK_LIMIT: begin
        if(B_row_w >= 4'd7)
            stateB <= B_COL_LIMIT_CHECK;
        else 
            stateB <= B_WRITE_INCREMENT_ROW1;
    end

    B_WRITE_INCREMENT_ROW1: stateB <= B_WRITE_INCREMENT_ROW2;

    B_COL_LIMIT_CHECK: begin
        if(B_col >= 4'd7)
            stateB <= B_FINISH;
        else 
            stateB <= B_INCREMENT_COL;
    end

    B_INCREMENT_COL: stateB <= B_READ_NEW_COL;


    B_FINISH: stateB <= B_FINISH;

    default: stateB <= B_IDLE;
    endcase
end

//OUTPUT B
always_ff @(posedge clk) begin
    case(stateB)

    B_IDLE: begin
        addressB_2 <= 6'd0;
        addressC <= 6'd0;
        B_col <= 4'd0;
        B_row_r <= 4'd0;
        B_row_w <= 4'd0;
        wrenC <= 1'b0;
        B_finish <= 1'b0;
    end

    B_READ_NEW_COL:;

    B_READ_INCREMENT_ROW2: begin
        addressB_2 <= B_row_r*8 + B_col;
    end

    B_READ_COL_ELEM_WAIT:;

    B_READ_COL_ELEM_WAIT2:;


    B_READ_COL_ELEM: begin
        Bx[B_row_r] <= qB;
    end

    B_READ_CHECK_LIMIT:;

    B_READ_INCREMENT_ROW1: begin
        B_row_r <= B_row_r + 4'd1;
    end

    B_WRITE_INCREMENT_ROW2: begin
        addressC <= B_row_w*8 + B_col;
    end


    B_WRITE_COL_ELEM: begin
        data_in_C <= By[B_row_w];
    end

    B_WAIT1: begin
        wrenC <= 1'b1;
    end

    B_WAIT2:;

    B_WAIT3:;


    B_STOP:begin
        wrenC <= 1'b0;
    end

    B_WRITE_CHECK_LIMIT:;

    B_WRITE_INCREMENT_ROW1: begin
        B_row_w <= B_row_w + 4'd1;
    end

    B_COL_LIMIT_CHECK:;

    B_INCREMENT_COL: begin
        B_col <= B_col + 4'd1;
        B_row_r <= 4'd0;
        B_row_w <= 4'd0;
    end

    B_FINISH: begin
        addressB_2 <= 6'd0;
        addressC <= 6'd0;
        B_col <= 4'd0;
        B_row_r <= 4'd0;
        B_row_w <= 4'd0;
        B_finish <= 1'b1;
        wrenC <= 1'b0;
    end
    
    default:;
    endcase
end




endmodule