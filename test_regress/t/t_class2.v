// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

// Note UVM internals do not require classes-in-classes
package P;
class Cls;
   int imembera;
   int imemberb;
endclass : Cls
endpackage : P

class Dead;
endclass

module t (/*AUTOARG*/);
   P::Cls c;
   P::Cls d;
   initial begin
      // Alternate between two versions to make sure we don't
      // constant propagate between them.
      c = new;
      d = new;
      c.imembera = 10;
      d.imembera = 11;
      c.imemberb = 20;
      d.imemberb = 21;
      if (c.imembera != 10) $stop;
      if (d.imembera != 11) $stop;
      if (c.imemberb != 20) $stop;
      if (d.imemberb != 21) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
