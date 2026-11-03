
module atm_tb;

reg clk, reset;
reg card, pin_valid, withdraw, balance;

wire dispense, show_balance, transaction_done;

atm_controller uut(
    .clk(clk),
    .reset(reset),
    .card(card),
    .pin_valid(pin_valid),
    .withdraw(withdraw),
    .balance(balance),
    .dispense(dispense),
    .show_balance(show_balance),
    .transaction_done(transaction_done)
);

// Clock generation
always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    card = 0;
    pin_valid = 0;
    withdraw = 0;
    balance = 0;

    #10 reset = 0;

    // Insert card
    #10 card = 1;
    #10 card = 0;

    // Enter correct PIN
    #10 pin_valid = 1;
    #10 pin_valid = 0;

    // Select withdrawal
    #10 withdraw = 1;
    #10 withdraw = 0;

    #50 $finish;
end

initial
begin
    $monitor("Time=%0t | Dispense=%b | Balance=%b | Done=%b",
    $time, dispense, show_balance, transaction_done);
end

endmodule
