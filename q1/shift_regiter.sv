module shifter_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out);


logic [N-1:0] regdata; //define variable of register


assign serial_out = regdata[0];
assign parallel_out = regdata;



always_ff@(posedge clk or negedge rst_n)begin                 

if(!rst_n) begin

regdata <= 'b0;

end


else if(!serial_parallel && load_enable) begin             //for serial in

  regdata[N-2:0] <= regdata[N-1:1];                       //data input                      
  regdata[N-1] <= serial_in;

end


else if(serial_parallel && load_enable)             //for parallel in
begin
  
  regdata <= parallel_in;   //parallel output              

end

end
endmodule

