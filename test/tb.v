`timescale 1ns / 1ps

module tb;

    reg clk;
    reg rst_n;
    reg ena;

    reg [7:0] ui_in;
    reg [7:0] uio_in;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    reaction_timer dut (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst_n = 0;
        ena = 1;
        ui_in = 0;
        uio_in = 0;

        // Reset
        #20;
        rst_n = 1;

        // Start timer
        #10;
        ui_in[0] = 1;
        #10;
        ui_in[0] = 0;

        // Let it count
        #50;

        // Stop timer
        ui_in[1] = 1;
        #10;
        ui_in[1] = 0;

        #20;

        $finish;
    end

endmodule

