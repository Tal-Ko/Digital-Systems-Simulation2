// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic a_sel,           // Select one 2-byte word from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [1:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here
// ------------------

    // Declaring the FSM states
    typedef enum {
        A_start,
        B_a_15_0xb_15_0,
        C_a_15_0xb_31_16,
        D_a_31_16xb_15_0,
        E_a_31_16xb_31_16
    } sm_type;

    sm_type current_state;
    sm_type next_state;

    // FSM synchronous procedural block.
    // Async clk and reset signals.
    always_ff @(posedge clk, posedge reset) begin
        if (reset == 1'b1) begin
            current_state <= A_start;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM combinatorial logic block.
    always_comb begin
        // Handle reset values
        if (reset == 1'b1) begin
            busy = 1'b0;
            clr_prod = 1'b1;
        end else begin
            clr_prod = 1'b0;
        end // end else

        // Default Assignments
        // Most used output values
        upd_prod = 1'b1;
        a_sel = 1'b0;
        b_sel = 1'b0;
        busy = 1'b1;

        case (current_state)
            A_start: begin
                busy = 1'b0;
                upd_prod = 1'b0;
                if (start == 1'b1) begin
                    next_state = B_a_15_0xb_15_0;
                    clr_prod = 1'b1;
                end
            end
            B_a_15_0xb_15_0: begin
                next_state = C_a_15_0xb_31_16;

                shift_sel = {1'b0, 1'b0};
            end
            C_a_15_0xb_31_16: begin
                next_state = D_a_31_16xb_15_0;

                shift_sel = {1'b0, 1'b1};
                b_sel = 1'b1;
            end
            D_a_31_16xb_15_0: begin
                next_state = E_a_31_16xb_31_16;

                shift_sel = {1'b0, 1'b1};
                a_sel = 1'b1;
            end
            E_a_31_16xb_31_16: begin
                next_state = A_start;

                shift_sel = {1'b1, 1'b0};
                a_sel = 1'b1;
                b_sel = 1'b1;
            end
        endcase
    end

// End of your code

endmodule
