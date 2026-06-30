class environment;

    
    generator      gen;
    driver         drv;
    read_monitor   mon;
    scoreboard     scb;

    
    mailbox gen2drv;
    mailbox mon2scb;

 
    virtual fifo_if vif;

  
    function new(virtual fifo_if vif);

        this.vif = vif;

    endfunction

    task build();

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);

        drv = new(gen2drv, vif);

        mon = new(mon2scb, vif);

        scb = new(mon2scb);

    endtask


    task run();

        fork

            drv.run();

            mon.run();

            scb.run();

        join_none

    endtask

endclass
