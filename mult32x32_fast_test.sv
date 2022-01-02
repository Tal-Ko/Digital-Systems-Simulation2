// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------

    mult32x32_fast uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .a(a),
        .b(b),
        .busy(busy),
        .product(product)
    );

    initial begin
        clk = 1'b1;
        reset = 1'b1;
        start = 1'b0;
        a = 64'b0;
        b = 64'b0;

        repeat (4) begin
            @(posedge clk);
        end

        reset = 1'b0;
        @(posedge clk);

        a = 207016353; // 00001100010101101101000110100001
        b = 207905126; // 00001100011001000110000101100110

        start = 1'b1;
        @(posedge clk);
        start = 1'b0;

        @(negedge busy);

        @(posedge clk);

        a = a & 32'hFFFF0000;
        b = b & 32'hFFFF0000;

        start = 1'b1;
        @(posedge clk);
        start = 1'b0;

        @(negedge busy);

        // // -----------------

        // @(posedge clk);

        // a = a & 32'hFFFF0000;
        // b = 207905126;

        // start = 1'b1;
        // @(posedge clk);
        // start = 1'b0;

        // @(negedge busy);

        // @(posedge clk);

        // a = 207016353;
        // b = b & 32'hFFFF0000;

        // start = 1'b1;
        // @(posedge clk);
        // start = 1'b0;

        // @(negedge busy);

        // // -----------------
    end

    always begin
        #1 clk = ~clk;
    end

// End of your code

endmodule
