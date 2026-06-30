`timescale 1ns/1ps

import tb_pkg::*;

module tb_top;

    // Interface
    fifo_if fifoif();

    // DUT
    fifo dut (

        .clk      (fifoif.clk),
        .rst      (fifoif.rst),

        .w_en     (fifoif.w_en),
        .r_en     (fifoif.r_en),

        .data     (fifoif.data),

        .data_out (fifoif.data_out),

        .full     (fifoif.full),
        .empty    (fifoif.empty)

    );

    // Environment and Test Handles
    environment env;

    test tst;

    // Clock Generation
    initial
    begin

        fifoif.clk = 0;

        forever #5 fifoif.clk = ~fifoif.clk;

    end

    // Reset Generation
    initial
    begin

        fifoif.rst = 1;

        fifoif.w_en = 0;
        fifoif.r_en = 0;
        fifoif.data = 8'h00;

        #20;

        fifoif.rst = 0;

    end

    // Start Test
    initial
    begin

        env = new(fifoif);

        tst = new(env);

        tst.run();

    end

endmodule
