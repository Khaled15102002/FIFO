module test_bench();
parameter FIFO_WIDTH = 16, FIFO_DEPTH = 512;
reg [FIFO_WIDTH-1:0] din_a;
reg wen_a, ren_b, clk_a, clk_b, rst;
wire [FIFO_WIDTH-1:0] dout_b;
wire full, empty;
Q5 x(din_a, wen_a, ren_b, clk_a, clk_b, rst, dout_b, full, empty);
initial begin
    clk_a=0;
    forever begin
        #1clk_a=~clk_a;
    end
end
initial begin
    clk_b=0;
    forever begin
        #2clk_b=~clk_b;
    end
end
initial begin
    rst=1;
    din_a=5;
    wen_a=0;
    ren_b=0;
    @(negedge clk_b);
    rst=0;
    ren_b=0;
    wen_a=1;

    repeat(512)begin
        din_a=$urandom;
        @(negedge clk_a);
    end

    wen_a=0;
    ren_b=1;

    repeat(512)begin
        @(negedge clk_b);
    end

    $stop;
end
endmodule



