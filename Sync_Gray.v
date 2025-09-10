module Sync_Gray(in,rst,clk_a,clk_b,out);
parameter WIDTH = 9;
input [WIDTH-1:0] in;
input rst, clk_a, clk_b;
output [WIDTH-1:0] out;
wire [WIDTH-1:0] BG_out,sync_out;
reg [WIDTH-1:0] ff;
Binary_To_Gray#(WIDTH) BG(in,BG_out);
always @(posedge clk_a)begin
    if(rst)
    ff<=0;
    else
    ff<=BG_out;
end
genvar i;
generate
    for(i=0;i<WIDTH;i=i+1)begin
        Synchronizer ss(ff[i],rst,clk_b,sync_out[i]);
    end
endgenerate
Gray_To_Binary#(WIDTH) GB(sync_out,out);

endmodule