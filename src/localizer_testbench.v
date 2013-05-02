//testbench for the localizer module

`timescale 1ns/1ps

module localizer_testbench();

   parameter Halfcycle = 5; //half period is 5ns
    
    localparam Cycle = 2*Halfcycle;
    
    reg Clock;
    
    // Clock Signal generation:
    initial Clock = 0; 
    always #(Halfcycle) Clock = ~Clock;

   //Registers and wires to test the localizer
   reg signed  [90:0] REFout [0:1];
   wire signed [90:0] DUTout [0:1];
   reg signed [34:0] tau1;
   reg signed [34:0] tau2;
   reg signed [34:0] tau3;
   reg signed [23:0] TEMPout [0:1];
   
   wire [23:0]	     testing;
   
	

   //Task for checking the output
   task checkOutput;
       if (($signed(REFout[0]) - $signed(DUTout[0]) >= -(REFout[0]*0.1)) && 
	   ($signed(REFout[0]) - $signed(DUTout[0]) <= (REFout[0]*0.1))  && 
	   ($signed(REFout[1]) - $signed(DUTout[1]) >= -(REFout[1]*0.1)) && 
	   ($signed(REFout[1]) - $signed(DUTout[1]) <= (REFout[1]*0.1))) begin
	   $display("####################################    ERROR WITHIN 10 PERCENT     ######################################");
           $display("PASS    DUTout[0]: %d, REFout[0]: %d", $signed(DUTout[0]), $signed(REFout[0]));
	   $display("PASS    DUTout[1]: %d, REFout[1]: %d", $signed(DUTout[1]), $signed(REFout[1]));
        end
        else begin
           $display("FAIL    DUTout: %d, REFout: %d", $signed(DUTout[0]), $signed(REFout[0]));
	   $display("FAIL    DUTout: %d, REFout: %d", $signed(DUTout[1]), $signed(REFout[1]));
	   //$finish();
        end
   endtask // checkOutput
   
   
   //this is where the modules being tested are instanatiated.
   localizer_2 localizer_test(.tau1(tau1), .tau2(tau2), .tau3(tau3), .posx(DUTout[0]), .posy(DUTout[1]));

  
  
   
   initial begin
      $display("\n\nSTARTING ALL TESTS");
    
      
    #10;
   
      tau1 = -16952;
      tau2 = -22290; //-6.48*(10**(-4));
      tau3 = -10618;//-2.07*(10**(-4));
   #100;
    
      
      REFout[0] = $floor(11*33554432);   //11
      REFout[1] = $floor(12*33554432);   //12
       
      #10;
      checkOutput();
       
      $finish();
      
   end

endmodule // localizer_testbench


			    
