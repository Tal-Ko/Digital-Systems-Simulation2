// 32X32 Multiplier arithmetic unit template
module mult32x32_fast_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic a_sel,           // Select one 2-byte word from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [1:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic a_msw_is_0,     // Indicates MSW of operand A is 0
    output logic b_msw_is_0,     // Indicates MSW of operand B is 0
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------

    // Intermediate variables
    logic [31:0] intermediate_res;
    logic [63:0] shifter_res;

    logic [15:0] a_prod;
    logic [15:0] b_prod;

    logic [5:0] shift_val;

    always_comb begin
        a_msw_is_0 = 1'b0;
        b_msw_is_0 = 1'b0;

        if (a[15:0] == {16{1'b0}}) begin
            a_msw_is_0 = 1'b1;
        end

        if (b[15:0] == {16{1'b0}}) begin
            b_msw_is_0 = 1'b1;
        end
    end

    // Synchronous procedural block
    always_ff @(posedge clk, posedge reset) begin
        if (reset == 1'b1 || clr_prod == 1'b1) begin
            product <= 64'b0;
        end else if (upd_prod == 1'b1) begin
            product <= product + shifter_res;
        end
    end

    // Combinatorial logic block
    always_comb begin
        // A mux 2->1
        case (a_sel)
            1'b0: a_prod = a[15:0];
            1'b1: a_prod = a[31:16];
        endcase;

        // B mux 2->1
        case (b_sel)
            1'b0: b_prod = b[15:0];
            1'b1: b_prod = b[31:16];
        endcase;

        // Shifter mux 4->1
        case (shift_sel)
            2'b00: shift_val = 6'b000000;
            2'b01: shift_val = 6'b010000;
            2'b10: shift_val = 6'b100000;
        endcase;

        intermediate_res = a_prod * b_prod;
        shifter_res = intermediate_res << shift_val;
    end

// End of your code

endmodule
