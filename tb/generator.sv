class generator;

    mailbox gen2drv;

    transaction trans;

    function new(mailbox gen2drv);
        this.gen2drv = gen2drv;
    endfunction

    task send(bit w_en, bit r_en, bit [7:0] data);

        trans = new();

        trans.w_en = w_en;
        trans.r_en = r_en;
        trans.data = data;

        trans.display("GENERATOR");

        gen2drv.put(trans);

    endtask

endclass
