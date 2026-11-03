
module atm_controller(
    input clk,
    input reset,
    input card,
    input pin_valid,
    input withdraw,
    input balance,
    output reg dispense,
    output reg show_balance,
    output reg transaction_done
);

parameter IDLE      = 3'b000,
          CARD      = 3'b001,
          PIN       = 3'b010,
          MENU      = 3'b011,
          WITHDRAW  = 3'b100,
          BALANCE   = 3'b101,
          DONE      = 3'b110;

reg [2:0] state, next_state;

// State register
always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always @(*)
begin
    next_state = state;

    case(state)

        IDLE:
            if(card)
                next_state = CARD;

        CARD:
            next_state = PIN;

        PIN:
            if(pin_valid)
                next_state = MENU;
            else
                next_state = IDLE;

        MENU:
            if(withdraw)
                next_state = WITHDRAW;
            else if(balance)
                next_state = BALANCE;

        WITHDRAW:
            next_state = DONE;

        BALANCE:
            next_state = DONE;

        DONE:
            next_state = IDLE;

        default:
            next_state = IDLE;

    endcase
end

// Output logic
always @(*)
begin
    dispense = 0;
    show_balance = 0;
    transaction_done = 0;

    case(state)

        WITHDRAW:
            dispense = 1;

        BALANCE:
            show_balance = 1;

        DONE:
            transaction_done = 1;

    endcase
end

endmodule
