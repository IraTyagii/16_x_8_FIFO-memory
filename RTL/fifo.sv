module fifo (
    input  logic       clk,
    input  logic       rst,
    input  logic       w_en,
    input  logic       r_en,
    input  logic [7:0] data,

    output logic [7:0] data_out,
    output logic       full,
    output logic       empty
);

    logic [7:0] memory [0:15];

    logic [3:0] wr_ptr;
    logic [3:0] rd_ptr;

    logic [4:0] count;

    assign full  = (count == 5'd16);
    assign empty = (count == 5'd0);

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            data_out <= '0;
        end

        else if (w_en && r_en)
        begin
            if (full)
            begin
                memory[wr_ptr] <= data;
                data_out       <= memory[rd_ptr];

                wr_ptr <= wr_ptr + 1;
                rd_ptr <= rd_ptr + 1;
            end

            else if (empty)
            begin
                memory[wr_ptr] <= data;

                wr_ptr <= wr_ptr + 1;
                count  <= count + 1;
            end

            else
            begin
                memory[wr_ptr] <= data;
                data_out       <= memory[rd_ptr];

                wr_ptr <= wr_ptr + 1;
                rd_ptr <= rd_ptr + 1;
            end
        end

        else if (w_en && !full)
        begin
            memory[wr_ptr] <= data;

            wr_ptr <= wr_ptr + 1;
            count  <= count + 1;
        end

        else if (w_en && full)
        begin
            $display("FIFO FULL");
        end

        else if (r_en && !empty)
        begin
            data_out <= memory[rd_ptr];

            rd_ptr <= rd_ptr + 1;
            count  <= count - 1;
        end

        else if (r_en && empty)
        begin
            $display("Fifo empty");
        end
    end

endmodule
