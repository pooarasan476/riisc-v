
module fulladder8 (
    input  [7:0] A,
    input  [7:0] B,
    input        Cin,
    output [7:0] Sum,
    output       Cout
);

    wire [8:0] carry;

    assign carry[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign Sum[i] = A[i] ^ B[i] ^ carry[i];

            assign carry[i+1] =
                (A[i] & B[i]) |
                (A[i] & carry[i]) |
                (B[i] & carry[i]);
        end
    endgenerate

    assign Cout = carry[8];

endmodule
