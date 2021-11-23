`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:38 11/18/2021 
// Design Name: 
// Module Name:    toplevel 
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
module toplevel(
clk,
clr,
anode,
segment,
thsync,
tvsync,
tred,
tgreen,
tblue,
MOSI,
MISO,
SS,
SCLK,
led
    );
    
input clk;
input clr;    
    
wire dclk;
wire segclk;
wire scoreclk;
wire gameclk;

wire [8:0] barpos;
wire [3:0] holepos;
wire [3:0] plrpos;
wire [15:0] timealive;
wire [1:0] lives;


output reg [3:0] anode;
output reg [6:0] segment;

output reg thsync;
output reg tvsync;
output reg [2:0] tred;
output reg [2:0] tgreen;
output reg [1:0] tblue;

wire [9:0] posData;

output reg [2:0] led;

wire hsync;
wire vsync;
wire [2:0] red;
wire [2:0] green;
wire [1:0] blue;

wire tMOSI;
wire tSS;
wire tSCLk;

input MISO;
output reg MOSI;
output reg SS;
output reg SCLK;


clockdiv clockdiv_(
       .clk(clk),
       .clr(clr),
       .gameclk(gameclk),
       .scoreclk(scoreclk),
       .segclk(segclk),
       .dclk(dclk)
);   

game game_(
       .gameclk(gameclk),
       .clr(clr),
       .scoreclk(scoreclk),
       .barpos(barpos[8:0]),
       .holepos(holepos[3:0]),
       .plrpos(plrpos[3:0]),
       .timealive(timealive),
       .lives(lives)
);
/*
score score_(
       .segclk(segclk),
       .timealive(timealive),
       .anode(anode),
       .segment(segment)
);
*/
vga vga_(
    .dclk(dclk),
    .clr(clr),
    .barpos(barpos[8:0]),
    .holepos(holepos[3:0]),
    .plrpos(plrpos[3:0]),
    .hsync(hsync),
    .vsync(vsync),
    .red(red[2:0]),
    .green(green[2:0]),
    .blue(blue[1:0])
);
/*
			input CLK;					// 100Mhz onboard clock
			input RST;					// Button D
			input MISO;					// Master In Slave Out, Pin 3, Port JA
			output SS;					// Slave Select, Pin 1, Port JA
			output MOSI;				// Master Out Slave In, Pin 2, Port JA
			output SCLK;	
            */
joystick joystick_(
       .CLK(clk),
       .RST(clr),
       .MISO(MISO),
       .SS(tSS),
       .MOSI(tMOSI),
       .SCLK(tSCLK),
       .posData(posData[9:0])
);

movement movement_(
        .clk(gameclk),
        .plrpos(plrpos[3:0]),
        .posData(posData[9:0])
);

lives lives_(
        .scoreclk(scoreclk),
        .clr(clr),
        .lives(lives),
        .led(led)
);


display display_(
        .segclk(segclk),
        .timealive(timealive),
        .anode(anode),
        .segment(segment)
);


always @(*)
begin
    thsync = hsync;
    tvsync = vsync;
    tred = red;
    tgreen = green;
    tblue = blue;
    MOSI = tMOSI;
    SS = tSS;
    SCLK = tSCLK;
end

endmodule