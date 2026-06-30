class reference_model;

    logic [7:0] ref_mem [0:15];

    int wr_ptr;
    int rd_ptr;
    int count;

    function new();

        wr_ptr = 0;
        rd_ptr = 0;
        count  = 0;

    endfunction

    task write(input bit [7:0] data);

        if(count < 16)
        begin
            ref_mem[wr_ptr] = data;
            wr_ptr = (wr_ptr + 1) % 16;
            count++;
        end

    endtask

    task read(output bit [7:0] data);

        if(count > 0)
        begin
            data = ref_mem[rd_ptr];
            rd_ptr = (rd_ptr + 1) % 16;
            count--;
        end

    endtask

    function bit get_full();

        return (count == 16);

    endfunction

    function bit get_empty();

        return (count == 0);

    endfunction

endclass
