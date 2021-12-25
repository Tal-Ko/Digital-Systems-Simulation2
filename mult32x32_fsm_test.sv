// 32X32 Multiplier FSM
module mult32x32_fsm_test;

    logic clk;             // Clock
    logic reset;           // Reset
    logic start;           // Start signal
    logic busy;            // Multiplier busy indication
    logic a_sel;           // Select one 2-byte word from A
    logic b_sel;           // Select one 2-byte word from B
    logic [1:0] shift_sel; // Select output from shifters
    logic upd_prod;        // Update the product register
    logic clr_prod;        // Clear the product register

    mult32x32_fsm FSM (
        .clk(clk),
        .reset(reset),
        .start(start),
        .busy(busy),
        .a_sel(a_sel),
        .b_sel(b_sel),
        .shift_sel(shift_sel),
        .upd_prod(upd_prod),
        .clr_prod(clr_prod)
    );

    initial begin
        clk = 1'b0;
        start = 1'b1;
        reset = 1'b0;

        #5
        start = 1'b0;

        #5

        #5

        #5

        #5

        #5

        #5

        #5

        #5

        #5
        $stop;
    end

    always begin
        #5
        clk = ~clk;
    end

endmodule // mult32x32_fsm_test
