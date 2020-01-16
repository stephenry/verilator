// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2020 by Wilson Snyder.

class Base1;
endclass

class Base2;
endclass

class Cls extends Base1, Base2;
endclass

module t (/*AUTOARG*/);
endmodule
