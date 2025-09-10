module Q5(din_a, wen_a, ren_b, clk_a, clk_b, rst, dout_b, full, empty);
parameter FIFO_WIDTH = 16, FIFO_DEPTH = 512;
input [FIFO_WIDTH-1:0] din_a;
input wen_a, ren_b, clk_a, clk_b, rst;
output reg [FIFO_WIDTH-1:0] dout_b;
output reg full, empty;
reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
reg [8:0] wr_ptr, rd_ptr;
reg wr_wrap, rd_wrap;
wire write_wrap_out, read_wrap_out;
wire [8:0] write_ptr_out, read_ptr_out;
Sync_Gray#(1) readwrap(rd_wrap,rst,clk_b,clk_a,read_wrap_out);
Sync_Gray#(1) writewrap(wr_wrap,rst,clk_a,clk_b,write_wrap_out);
Sync_Gray#(9) readptr(rd_ptr,rst,clk_b,clk_a,read_ptr_out);
Sync_Gray#(9) writeptr(wr_ptr,rst,clk_a,clk_b,write_ptr_out);

always @(posedge clk_a) begin
    if(rst)begin
        wr_ptr<=0;
        wr_wrap<=0;
    end

    else if(wen_a && ~full)begin
        mem[wr_ptr]<=din_a;
        wr_ptr<= wr_ptr+1;
        if (wr_ptr==FIFO_DEPTH-1)   
        wr_wrap<=~wr_wrap;  
    end
end

always @(posedge clk_b)begin
    if(rst)begin
        dout_b<=0;
        rd_ptr<=0;
        rd_wrap<=0;
    end
    else if(ren_b && ~empty)begin
        dout_b<=mem[rd_ptr];
        rd_ptr<= rd_ptr+1;
        if (rd_ptr==FIFO_DEPTH-1)
        rd_wrap<=~rd_wrap;  
    end
end
always @(*) begin
    if(rst)begin
        full=0;
        empty=1;
    end
    else begin
        full=((wr_ptr==read_ptr_out) && (wr_wrap!=read_wrap_out))? 1 : 0;
        empty=((write_ptr_out==rd_ptr) && (write_wrap_out==rd_wrap))? 1 : 0;
    end
    
end
endmodule