module f1_fsm (
    input logic         rst,
    input logic         clk,
    input logic         en,
    output logic [7:0]  data_out
);

typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
my_state current_state, next_state;

// state register
always_ff @(posedge clk)
    if (rst)
        current_state <= S0;
    else
        current_state <= next_state;

// next-state logic
always_comb
    case (current_state)
        S0: next_state = en ? S1 : S0;
        S1: next_state = en ? S2 : S1;
        S2: next_state = en ? S3 : S2;
        S3: next_state = en ? S4 : S3;
        S4: next_state = en ? S5 : S4;
        S5: next_state = en ? S6 : S5;
        S6: next_state = en ? S7 : S6;
        S7: next_state = en ? S8 : S7;
        S8: next_state = en ? S0 : S8;
        default: next_state = S0;
    endcase

// output logic
always_comb
    case (current_state)
        S0: data_out = 8'b00000000;
        S1: data_out = 8'b00000001;
        S2: data_out = 8'b00000011;
        S3: data_out = 8'b00000111;
        S4: data_out = 8'b00001111;
        S5: data_out = 8'b00011111;
        S6: data_out = 8'b00111111;
        S7: data_out = 8'b01111111;
        S8: data_out = 8'b11111111;
        default: data_out = 8'b00000000;
    endcase

endmodule