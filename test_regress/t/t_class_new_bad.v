// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.


class ClsNoArg;
   int imembera;
   function new();
      imembera = 5;
   endfunction
endclass

class ClsArg;
   int imembera;
   function new(int i);
      imembera = i + 1;
   endfunction
endclass

module t (/*AUTOARG*/);
   initial begin
      ClsNoArg c1;
      ClsArg c2;
      c1 = new(3);  // Bad, called with arg
      c2 = new();  // Bad, called without arg
      $stop;
   end
endmodule
