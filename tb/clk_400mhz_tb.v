`timescale 1ns / 1ps

module clk_400mhz_tb;

    reg  clk_in1;
    reg  reset;
    wire clk_out1;
    wire locked;

    real period_sum_ns;
    real average_period_ns;
    real frequency_mhz;
    time last_rise_time;
    integer edge_count;

    clk_400mhz dut (
        .clk_in1 (clk_in1),
        .reset   (reset),
        .clk_out1(clk_out1),
        .locked  (locked)
    );

    // 100 MHz input clock
    initial clk_in1 = 1'b0;
    always #5 clk_in1 = ~clk_in1;

    initial begin
        reset = 1'b1;
        period_sum_ns = 0.0;
        average_period_ns = 0.0;
        frequency_mhz = 0.0;
        edge_count = 0;
        last_rise_time = 0;

        $display("[%0t ns] Starting clock frequency testbench", $time);

        #50;
        reset = 1'b0;
        $display("[%0t ns] Reset deasserted", $time);

        wait (locked === 1'b1);
        $display("[%0t ns] Clock wizard locked", $time);

        repeat (8) begin
            @(posedge clk_out1);

            if (edge_count > 0) begin
                period_sum_ns = period_sum_ns + ($realtime - last_rise_time);
            end

            last_rise_time = $time;
            edge_count = edge_count + 1;
        end

        average_period_ns = period_sum_ns / (edge_count - 1);
        frequency_mhz = 1000.0 / average_period_ns;

        $display("Measured output clock period: %0.3f ns", average_period_ns);
        $display("Measured output clock frequency: %0.3f MHz", frequency_mhz);

        #20;
        $finish;
    end

endmodule
