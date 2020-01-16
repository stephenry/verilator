// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

module t (/*AUTOARG*/);

class Cls;
   int imembera;
   int imemberb;
endclass : Cls

class Dead;
endclass

   task f;
      int flocal;
      $display("f %d", flocal);  // FIXME remove this
   endtask

   initial begin
      Cls c;
      if (c != null) $stop;
      f();
      c = new;
      c.imembera = 10;
      c.imemberb = 20;
      if (c.imembera != 10) $stop;
      if (c.imemberb != 20) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
