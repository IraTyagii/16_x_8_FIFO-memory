class transaction;


    bit        w_en;
    bit        r_en;
    bit [7:0]  data;


    bit [7:0]  data_out;
    bit        full;
    bit        empty;


    function new();
    endfunction

    task display(input string name);

        $display("--------------------------------------------");
        $display("Component : %s", name);
        $display("--------------------------------------------");
        $display("w_en     = %0d", w_en);
        $display("r_en     = %0d", r_en);
        $display("data     = 0x%0h", data);
        $display("data_out = 0x%0h", data_out);
        $display("full     = %0d", full);
        $display("empty    = %0d", empty);
        $display("--------------------------------------------");

    endtask

endclass
