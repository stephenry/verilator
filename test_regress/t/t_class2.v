// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

class Dead;
endclass

module ModDead;
class DeadInMod;
   int memberdead;
endclass
endmodule
package Pkg;
   typedef enum { ENUMP_VAL = 33 } enump_t;
endpackage
   
module t (/*AUTOARG*/);
class Cls;
   int imembera;
   int imemberb;
   typedef enum { ENUM_VAL = 22 } enum_t;
endclass : Cls

   Cls c;
   Cls d;

   generate
      if (0) begin
         ModDead cellDead();
      end
   endgenerate

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
      if (Pkg::ENUMP_VAL != 33) $stop;
      if (Cls::ENUM_VAL != 22) $stop;
      if (c.ENUM_VAL != 22) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
