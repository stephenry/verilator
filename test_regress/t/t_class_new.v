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
      c1 = new;
      if (c1.imembera != 5) $stop;
      c2 = new(2);
      if (c2.imembera != 3) $stop;

      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
