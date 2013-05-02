//module: Localizer_2
//inputs: positions of the microphones & TDOAs
//outputs:the position of the acoustic source <x,y>

module localizer_2(
   input signed [34:0] tau1,
   input signed [34:0] tau2,		 
   input signed [34:0] tau3,
   output reg signed [90:0] posx,
   output reg signed [90:0] posy
		 		 
		 
);
   
   localparam [32:0] x1 = $floor(0.08*33554432);
   localparam [32:0] y1 = $floor(0.16*33554432);
   localparam [32:0] x2 = $floor(0.16*33554432);
   localparam [32:0] y2 = $floor(0.16*33554432);
   localparam [32:0] x3 = $floor(0.16*33554432);
   localparam [32:0] y3 = 0;
   localparam [24:0] v  = $floor(340.3);

   //not sure if these are supposed to be signed ???????????????????????????????????
   
   wire signed [69:0] 	    A2;
   wire signed [69:0] 	    A3;
   wire signed [69:0] 	    B2;
   wire signed [69:0] 	    B3;
   wire signed [152:0] 	    C2;
   wire signed [152:0] 	    C3;

   wire signed [222:0] 	    numx;
   wire signed [222:0] 	    numy;
   wire signed [139:0] 	    denom;
   
   assign testing = 2*x1*tau2;

   wire [69:0] 		    a2_1, a2_2, a2_3, a2_4, a2_5, a2_6, a2_7;
   wire [69:0] 		    a3_1, a3_2, a3_3, a3_4, a3_5, a3_6, a3_7;
   wire [69:0] 		    b2_1, b2_2, b2_3, b2_4, b2_5, b2_6, b2_7;
   wire [69:0] 		    b3_1, b3_2, b3_3, b3_4, b3_5, b3_6, b3_7;
   
   assign a2_1 = $signed(2*x2);
   assign a2_2 = $signed(tau1);
   assign a2_3 = $signed(2*x1);
   assign a2_4 = $signed(tau2);
   assign a2_5 = $signed(a2_1*a2_2);
   assign a2_6 = $signed(a2_3*a2_4);
   assign a2_7 = $signed(a2_5-a2_6);

   assign A2 = a2_7;
   
    
   assign a3_1 = $signed(2*x3);
   assign a3_2 = $signed(tau1);
   assign a3_3 = $signed(2*x1);
   assign a3_4 = $signed(tau3);
   assign a3_5 = $signed(a3_1*a3_2);
   assign a3_6 = $signed(a3_3*a3_4);
   assign a3_7 = $signed(a3_5-a3_6);

   assign A3 = a3_7;

   assign b2_1 = $signed(2*y2);
   assign b2_2 = $signed(tau1);
   assign b2_3 = $signed(2*y1);
   assign b2_4 = $signed(tau2);
   assign b2_5 = $signed(b2_1*b2_2);
   assign b2_6 = $signed(b2_3*b2_4);
   assign b2_7 = $signed(b2_5-b2_6);

   assign B2 = b2_7;
   
    
   assign b3_1 = $signed(2*y3);
   assign b3_2 = $signed(tau1);
   assign b3_3 = $signed(2*y1);
   assign b3_4 = $signed(tau3);
   assign b3_5 = $signed(b3_1*b3_2);
   assign b3_6 = $signed(b3_3*b3_4);
   assign b3_7 = $signed(b3_5-b3_6);

   assign B3 = b3_7;
   
   
   // A2 $signed($signed(2*x2)*$signed(tau1)) - $signed($signed(2*x1)*$signed(tau2));
   // A3 $signed($signed(2*x3)*$signed(tau1)) - $signed($signed(2*x1)*$signed(tau3));
   // B2 $signed($signed(2*y2)*$signed(tau1)) - $signed($signed(2*y1)*$signed(tau2));
   // B3 $signed($signed(2*y3)*$signed(tau1)) - $signed($signed(2*y1)*$signed(tau3));

   wire [222:0]      c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17;
   wire [222:0]      d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17;

   assign c1 =  $signed(v**2)*$signed(tau2)*$signed(tau1); 
   assign c2 =  $signed($signed(tau2) - $signed(tau1));
   assign c3 =  $signed(tau2);
   assign c4 =  $signed(x1)*$signed(x1);
   assign c5 =  $signed(y1)*$signed(y1);
   assign c6 =  $signed(tau1);
   assign c7 =  $signed(x2)*$signed(x2);
   assign c8 =  $signed(y2)*$signed(y2);
   assign c9 =  $signed($signed(c1)*$signed(c2)); //v**2*tau2*tau1*(tau2 - tau1)
   assign c10 = $signed(c3);    //tau2
   assign c11 = $signed(c4)+ $signed(c5); //x1**2 + y1**2
   assign c12 = $signed(c6);    //tau1
   assign c13 = $signed(c7)+ $signed(c8); //x2**2 + y2**2
   assign c14 = $signed(c3*c11);
   assign c15 = $signed(c6*c13);
   assign c16 = $signed(c9+c14);
   assign c17 = $signed(c16-c15);
   
   assign d1 =  $signed(v**2)*$signed(tau3)*$signed(tau1); 
   assign d2 =  $signed($signed(tau3) - $signed(tau1));
   assign d3 =  $signed(tau3);
   assign d4 =  $signed(x1)*$signed(x1);
   assign d5 =  $signed(y1)*$signed(y1);
   assign d6 =  $signed(tau1);
   assign d7 =  $signed(x3)*$signed(x3);
   assign d8 =  $signed(y3)*$signed(y3);
   assign d9 =  $signed(d1*d2); //v**2*tau2*tau1*(tau2 - tau1)
   assign d10 = $signed(d3);    //tau2
   assign d11 = $signed(d4)+ $signed(d5); //x1**2 + y1**2
   assign d12 = $signed(d6);    //tau1
   assign d13 = $signed(d7)+ $signed(d8); //x2**2 + y2**2
   assign d14 = $signed(d3*d11);
   assign d15 = $signed(d6*d13);
   assign d16 = $signed(d9+d14);
   assign d17 = $signed(d16-d15);

   assign C2 = c17;
   assign C3 = d17; 
   
   assign numx  = $signed($signed(B2)*$signed(C3) - $signed(B3)*$signed(C2));
   assign numy  = $signed($signed(A3)*$signed(C2) - $signed(A2)*$signed(C3));
   assign denom = $signed($signed(A2)*$signed(B3) - $signed(A3)*$signed(B2)); 


   wire [90:0] tempx;
   wire [90:0] tempy;
   
   assign tempx = $signed(numx)/$signed(denom);  // 24-bit fixed point; 8 bits int, 16 bits frac
   assign tempy = $signed(numy)/$signed(denom);

   always @(*) begin
      posx = tempx;
      posy = tempy;
   end
   
   
endmodule
 

   
   
   
   
		 
     		 
