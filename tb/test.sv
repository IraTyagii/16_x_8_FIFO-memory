class test;

    environment env;

    function new(environment env);
        this.env = env;
    endfunction

    task run();

        integer i;

        env.build();
        env.run();

        
        // Wait for reset
        
        #20;

       
        // TEST 1 : Reset
        
        $display("\n========== TEST 1 : RESET ==========");
        #20;

        
        // TEST 2 : Write One Data
       
        $display("\n========== TEST 2 : WRITE ONE ==========");

        env.gen.send(1,0,8'h11);
        #20;

        
        // TEST 3 : Read One Data
        
        $display("\n========== TEST 3 : READ ONE ==========");

        env.gen.send(0,1,8'h00);
        #20;

        
        // TEST 4 : Fill FIFO
        
        $display("\n========== TEST 4 : FILL FIFO ==========");

        for(i=0;i<16;i++)
        begin
            env.gen.send(1,0,i);
            #20;
        end

     
        // TEST 5 : Write when Full
     
        $display("\n========== TEST 5 : WRITE WHEN FULL ==========");

        env.gen.send(1,0,8'hAA);
        #20;

        
        // TEST 6 : Read Until Empty
        
        $display("\n========== TEST 6 : READ UNTIL EMPTY ==========");

        for(i=0;i<16;i++)
        begin
            env.gen.send(0,1,8'h00);
            #20;
        end

        
        // TEST 7 : Read Empty FIFO
        
        $display("\n========== TEST 7 : READ EMPTY ==========");

        env.gen.send(0,1,8'h00);
        #20;

       
        // TEST 8 : Simultaneous Read/Write (Normal)
        
        $display("\n========== TEST 8 : SIMULTANEOUS NORMAL ==========");

        env.gen.send(1,0,8'h11);
        #20;

        env.gen.send(1,0,8'h22);
        #20;

        env.gen.send(1,0,8'h33);
        #20;

        env.gen.send(1,1,8'h44);
        #20;

       
        // TEST 9 : Simultaneous when Full
        
        $display("\n========== TEST 9 : SIMULTANEOUS FULL ==========");

        for(i=0;i<13;i++)
        begin
            env.gen.send(1,0,i+8'h50);
            #20;
        end

        env.gen.send(1,1,8'h99);
        #20;

        
        // TEST 10 : Simultaneous when Empty
        
        $display("\n========== TEST 10 : SIMULTANEOUS EMPTY ==========");

        while(i>0)
            i--;

        for(i=0;i<16;i++)
        begin
            env.gen.send(0,1,0);
            #20;
        end

        env.gen.send(1,1,8'h77);
        #20;

        
        // TEST 11 : Pointer Wraparound
        
        $display("\n========== TEST 11 : POINTER WRAP ==========");

        for(i=0;i<16;i++)
        begin
            env.gen.send(1,0,i);
            #20;
        end

        for(i=0;i<8;i++)
        begin
            env.gen.send(0,1,0);
            #20;
        end

        for(i=0;i<8;i++)
        begin
            env.gen.send(1,0,i+8'h80);
            #20;
        end

        
        // TEST 12 : FIFO Ordering
      
        $display("\n========== TEST 12 : FIFO ORDER ==========");

        env.gen.send(1,0,8'hA1); #20;
        env.gen.send(1,0,8'hB2); #20;
        env.gen.send(1,0,8'hC3); #20;
        env.gen.send(1,0,8'hD4); #20;

        env.gen.send(0,1,0); #20;
        env.gen.send(0,1,0); #20;
        env.gen.send(0,1,0); #20;
        env.gen.send(0,1,0); #20;

    
        // TEST 13 : Alternate Read/Write
      
        $display("\n========== TEST 13 : ALTERNATE ==========");

        for(i=0;i<10;i++)
        begin
            env.gen.send(1,0,i);
            #20;
            env.gen.send(0,1,0);
            #20;
        end

       
        // TEST 14 : Random Operations

        $display("\n========== TEST 14 : RANDOM ==========");

        for(i=0;i<1000;i++)
        begin
            env.gen.send($urandom_range(0,1),
                         $urandom_range(0,1),
                         $urandom_range(0,255));
            #20;
        end


        // TEST 15 : Write After Empty
 
        $display("\n========== TEST 15 : WRITE AFTER EMPTY ==========");

        for(i=0;i<16;i++)
        begin
            env.gen.send(1,0,i);
            #20;
        end

        for(i=0;i<16;i++)
        begin
            env.gen.send(0,1,0);
            #20;
        end

        env.gen.send(1,0,8'hAB);
        #20;

     
        // TEST 16 : Read After Full
       
        $display("\n========== TEST 16 : READ AFTER FULL ==========");

        for(i=0;i<15;i++)
        begin
            env.gen.send(1,0,i);
            #20;
        end

        env.gen.send(0,1,0);
        #20;

        env.gen.send(1,0,8'hCD);
        #20;

   
        // TEST 17 : Continuous Write
  
        $display("\n========== TEST 17 : CONTINUOUS WRITE ==========");

        for(i=0;i<30;i++)
        begin
            env.gen.send(1,0,i);
            #20;
        end

        // TEST 18 : Continuous Read
      
        $display("\n========== TEST 18 : CONTINUOUS READ ==========");

        for(i=0;i<30;i++)
        begin
            env.gen.send(0,1,0);
            #20;
        end

        #100;

        $display("\n========================================");
        $display("ALL FIFO TEST CASES COMPLETED");
        $display("========================================");

        $finish;

    endtask

endclass
