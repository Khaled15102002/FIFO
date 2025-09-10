module Gray_To_Binary(in,out);
parameter WIDTH = 9;
input [WIDTH-1:0] in;
output [WIDTH-1:0] out;
genvar i;
generate
    for(i=0;i<WIDTH;i=i+1)begin
       assign out[i] = ^ in[WIDTH-1:i];
    end
endgenerate
endmodule