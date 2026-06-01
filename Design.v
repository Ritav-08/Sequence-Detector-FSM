`timescale 1ns / 1ps

module sdFSM1011(input  wire clk_i,
                 input  wire rst_i,
                 input  wire data_i, 
                 output reg  dout_o
);

//net(s)
reg [2:0] state;

//Parameter(s)
localparam S0 = 3'b000, 
           S1 = 3'b001, 
           S2 = 3'b010, 
           S3 = 3'b011, 
           S4 = 3'b100;

//state(s)
always@(posedge clk_i, posedge rst_i) begin
   //Reset
   if(rst_i) begin
      state  <= S0;
   end
   //State Transitions (Sequential)
   else begin
      case (state)
         S0: begin
            if(data_i) state  <= S1;
            else       state  <= S0;
         end
         S1: begin
            if(data_i) state  <= S1;
            else       state  <= S2;
         end
         S2: begin
            if(data_i) state  <= S3;
            else       state  <= S0;
         end
         S3: begin
            if(data_i) state  <= S4;
            else       state  <= S2;
         end
         S4: begin
            if(data_i) state  <= S1;
            else       state  <= S2;
         end
         default: begin 
            state  <= S0;
         end
      endcase
   end //else block
end //always block

//Output transitions
  //assign dout_o = (state == S4);
always@(*) begin
   case(state)
      S4:      dout_o = 1'b1;
      default: dout_o = 1'b0;
   endcase
end

endmodule
