// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

typedef class Cls;

class Cls;
   int imembera;
   int imemberb;
endclass : Cls

class Dead;
endclass

module t (/*AUTOARG*/);
   initial begin
      Cls c;
      if (c != null) $stop;
      $display("Display: null = \"%p\"", c);  // null
      c = new;
      $display("Display: newed = \"%p\"", c);  // '{imembera:0, imemberb:0}
      c.imembera = 10;
      c.imemberb = 20;
      $display("Display: set = \"%p\"", c);  // '{imembera:10, imemberb:20}
      if (c.imembera != 10) $stop;
      if (c.imemberb != 20) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
