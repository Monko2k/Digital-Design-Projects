`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:42 10/14/2021 
// Design Name: 
// Module Name:    float 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module float(
sign_result,
exponent,
significand,
fifth
    );

input [11:0] sign_result; 
output reg [2:0] exponent;
output reg [3:0] significand;
integer i;
output reg fifth;
integer j;

always @*
begin
	i=11;
	j=0;
	exponent = 8;
	while(sign_result[i] == 0 && i > 3)
	begin
		i = i - 1;
		exponent = exponent - 1;
	end
	while(j < 4)
	begin
		significand[3-j] = sign_result[i];
		i = i - 1;
		j = j + 1;
	end
	//if(i-4 >= 0)
	if (i >= 0)
	begin
		//fifth = sign_result[i-4];
		fifth = sign_result[i];
	end
	else
	begin
	fifth = 0;
	end
end
endmodule
