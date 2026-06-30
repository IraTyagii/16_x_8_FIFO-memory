class scoreboard;

  
    mailbox mon2scb;

    
    transaction trans;

    
    reference_model ref_model;

   
    function new(mailbox mon2scb);

        this.mon2scb = mon2scb;

        ref_model = new();

    endfunction

    
    task run();

        bit [7:0] expected_data;

        forever
        begin

           
            mon2scb.get(trans);

            trans.display("SCOREBOARD");

           
            if (trans.w_en && !trans.r_en)
            begin

                if (!trans.full)
                begin
                    ref_model.write(trans.data);

                    $display("[SCB] WRITE : Data = %0h", trans.data);
                end
                else
                begin
                    $display("[SCB] WRITE IGNORED (FIFO FULL)");
                end

            end

       
            else if (!trans.w_en && trans.r_en)
            begin

                if (!trans.empty)
                begin

                    ref_model.read(expected_data);

                    if (expected_data === trans.data_out)
                    begin
                        $display("--------------------------------");
                        $display("PASS");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end
                    else
                    begin
                        $display("--------------------------------");
                        $display("FAIL");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end

                end
                else
                begin
                    $display("[SCB] READ IGNORED (FIFO EMPTY)");
                end

            end

            else if (trans.w_en && trans.r_en)
            begin

                if (trans.empty)
                begin

                  
                    ref_model.write(trans.data);

                    $display("[SCB] SIMULTANEOUS : FIFO EMPTY -> WRITE ONLY");

                end

                else if (trans.full)
                begin

                    
                    ref_model.read(expected_data);

                    if (expected_data === trans.data_out)
                    begin
                        $display("--------------------------------");
                        $display("PASS");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end
                    else
                    begin
                        $display("--------------------------------");
                        $display("FAIL");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end

                    
                    ref_model.write(trans.data);

                end

                else
                begin

                    
                    ref_model.read(expected_data);

                    if (expected_data === trans.data_out)
                    begin
                        $display("--------------------------------");
                        $display("PASS");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end
                    else
                    begin
                        $display("--------------------------------");
                        $display("FAIL");
                        $display("Expected = %0h", expected_data);
                        $display("Actual   = %0h", trans.data_out);
                        $display("--------------------------------");
                    end

                    ref_model.write(trans.data);

                end

            end

        end

    endtask

endclass
