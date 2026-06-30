interface fifo_if;

    logic clk;
    logic rst;

    logic w_en;
    logic r_en;

    logic [7:0] data;

    logic [7:0] data_out;

    logic full;
    logic empty;

endinterface
