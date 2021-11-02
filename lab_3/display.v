`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:14 10/28/2021 
// Design Name: 
// Module Name:    display 
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
module display(
anode,
led,
fastclk,
blinkclk,
sel,
adj,
mincounter,
seccounter
    );

input fastclk;
input blinkclk;
input sel;
input adj;
input [5:0] mincounter;
input [5:0] seccounter;
output reg [3:0] anode;
output reg [6:0] led;
reg [3:0] value;
reg [1:0] counter;

initial
begin
	counter = 0;
end

always @(posedge fastclk)
begin
	case(counter)
		2'b00:
		begin
			anode = 4'b0111;
			value = mincounter / 10;
		end
		2'b01:
		begin
			anode = 4'b1011;
			value = mincounter % 10;
		end
		2'b10:
		begin
			anode = 4'b1101;
			value = seccounter / 10;
		end
		2'b11:
		begin
			anode = 4'b1110;
			value = seccounter % 10;
		end
	endcase
	counter = counter + 1;
	case(value)
		4'b0000: led = 7'b0000001;
		4'b0001: led = 7'b1001111;
		4'b0010: led = 7'b0010010;
		4'b0011: led = 7'b0000110;
		4'b0100: led = 7'b1001100;
		4'b0101: led = 7'b0100100;
		4'b0110: led = 7'b0100000;
		4'b0111: led = 7'b0001111;
		4'b1000: led = 7'b0000000;
		4'b1001: led = 7'b0000100;
		default: led = 7'b0000001;
	endcase
	
end

endmodule