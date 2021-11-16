`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11/15/21
// Design Name: 
// Module Name:    game 
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
module game(
	clr,
	gameclk,
	scoreclk,
	barpos, 
	holepos,
	plrpos,
	timealive,
	lives
);

output reg [3:0] barpos;
output reg [3:0] holepos;
output reg [3:0] plrpos;
output reg [15:0] timealive;
output reg [1:0] lives;
input gameclk;
input clr;
input scoreclk;
initial
begin
	barpos = 0;
	holepos = ($urandom & 15)%14;
	plrpos = 8;
	lives <= 3;
	timealive <= 0;
end

always @(posedge gameclk or posedge clr)
begin
	if (clr == 1)
	begin
		barpos = 0;
		holepos = ($urandom & 15)%14;
		plrpos = 8;
		lives <= 3;
	end
	else
	begin
		if (barpos == 11) 
		begin
			if (plrpos < holepos || plrpos > holepos + 2)
			begin
				lives <= lives - 1;
			end
			else
			barpos = 0;
			holepos = ($urandom & 15)%14;
		end
		else 
		begin
			barpos = barpos + 1;
		end
	end
	
	
end

// score timer
always @(posedge scoreclk or posedge clr)
begin
	if (clr == 1)
	begin
		timealive <= 0;
	end
	else
	begin
		if (lives > 0 && clr == 0)
		begin
			timealive <= timealive + 1;
		end
	end
end

endmodule