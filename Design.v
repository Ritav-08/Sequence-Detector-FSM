module sdFSM1011(input  wire clk_i,
                 input  wire rst_i,
                 input  wire data_i, 
                 output reg  doit_o
);

//net(s)
reg [2:0] state;

//Parameter(s)
localparam S0 = 000, 
           S1 = 001, 
           S2 = 010, 
           S3 = 011, 
           S4 = 100;

//state(s)
always@(rst_i, posedge clk_i) begin
   //Reset
   if(rst_i) begin
      state  <= S0;
      dout_o <= 1'b0;
   end
   //State Transitions
   else begin
      case (state)
         S0: begin
                       dout_o <= 1'b0;
            if(data_i) state  <= S1;
            else       state  <= S0;
         end
         S1: begin
                       dout_o <= 1'b0;
            if(data_i) state  <= S1;
            else       state  <= S2;
         end
         S2: begin
                       dout_o <= 1'b0;
            if(data_i) state  <= S3;
            else       state  <= S0;
         end
         S3: begin
                       dout_o <= 1'b0;
            if(data_i) state  <= S4;
            else       state  <= S2;
         end
         S4: begin
                       dout_o <= 1'b1;
            if(data_i) state  <= S1;
            else       state  <= S2;
         end
         default: begin 
            dout_o <= 1'b0;
            state  <= S0;
         end
      endcase
   end //else block
end //always block

endmodule