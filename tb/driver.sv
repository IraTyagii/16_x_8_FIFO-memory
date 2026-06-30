class driver;

    mailbox gen2drv;

    transaction trans;

    virtual fifo_if vif;

    function new(mailbox gen2drv, virtual fifo_if vif);

        this.gen2drv = gen2drv;
        this.vif = vif;

    endfunction

    task run();

        forever
        begin
            
            gen2drv.get(trans);
          
            @(posedge vif.clk);

          
            vif.w_en <= trans.w_en;
            vif.r_en <= trans.r_en;
            vif.data <= trans.data;

            trans.display("DRIVER");

            
            @(posedge vif.clk);

            
            vif.w_en <= 0;
            vif.r_en <= 0;
            vif.data <= 0;

        end

    endtask

endclass
