
module fulladder8_tb;

    reg [7:0] A, B;
    reg Cin;

    wire [7:0] Sum;
    wire Cout;

    fulladder8 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin

        $monitor("A=%b B=%b Cin=%b Sum=%b Cout=%b",
                  A, B, Cin, Sum, Cout);

        A = 8'b00001010;
        B = 8'b00010100;
        Cin = 0;
        #10;

        A = 8'b01100100;
        B = 8'b00110010;
        Cin = 1;
        #10;

        A = 8'b11111111;
        B = 8'b00000001;
        Cin = 0;
        #10;

        $finish;
    end

endmodule
