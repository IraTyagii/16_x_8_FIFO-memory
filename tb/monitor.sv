class read_monitor;

    mailbox mon2scb;

    transaction trans;

    virtual fifo_if vif;

    function new(mailbox mon2scb, virtual fifo_if vif);

        this.mon2scb = mon2scb;
        this.vif = vif;

    endfunction
    
    
    task run();

        forever begin

            @(posedge vif.clk);

        // Ignore idle cycles
            if (!(vif.w_en || vif.r_en))
            continue;

            trans = new();

            trans.w_en  = vif.w_en;
            trans.r_en  = vif.r_en;
            trans.data  = vif.data;
            trans.full  = vif.full;
            trans.empty = vif.empty;

        // Wait for DUT outputs to settle
            #1;
            trans.data_out = vif.data_out;

            trans.display("MONITOR");

            mon2scb.put(trans);

        end

    endtask
