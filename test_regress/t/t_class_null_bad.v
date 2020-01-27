// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

class Cls;
   int imembera;
endclass : Cls

module t (/*AUTOARG*/);
   Cls c;
   initial begin
      c = null;  // Not really required as null is default
      c.imembera = 10;  // BAD IEEE 8.4
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
