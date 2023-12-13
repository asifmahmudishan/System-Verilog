class Packet;
  int amount;
  static int count;
  string name;

  function new();
    string ID;
    count++;
    ID.itoa(count);
    name = {"PKT_", ID};
    $display($time,"ns || %s created", name);
  endfunction

	/*
  function Packet copy ();
    Packet Second;
    Second = new();
    Second.amount = this.amount;
    return Second;
  endfunction
  */

endclass

class Seller;
  int cash;
  Packet pkt;
  string name;

  function new(string name);
    this.name = name;
  endfunction

  function show();
    $display($time, "ns || [SELLER] %s (with cash %0d) has %s with %0d items", name, cash, pkt.name, pkt.amount);
  endfunction

endclass





module P2_tb();
  Seller seller1, seller2;

  initial begin
    seller1 = new("seller1"); //Seller1 memory
    seller1.pkt = new(); //
    seller2 = new("Seller2"); //Deep copy Same line declaration as new

    seller1.pkt.amount = 100;
    seller1.cash = 123;
    seller1.show(); //
	
	/*
	//Shallow copy
	seller2 = new seller1; 

    seller2.show();
    seller2.name = "seller2";
    seller2.show();
    seller1.show();

    //seller2.name = "Seller2";
    seller2.cash = 100;
    
    seller2.show();
    seller1.show();

    seller2.pkt.amount = 200; //seller 2 subclass

    seller2.show();
    seller1.show();
	*/

	//Deep Copy    
    seller2.pkt = seller1.pkt.copy;
    seller2.cash = seller1.cash;

    seller2.show();
    seller1.show();

    seller2.cash = 456;
    seller2.pkt.amount = 1000;

    seller2.show(); //After changing the value of seller2 
    seller1.show(); //After changing the value of seller2
    
    
  end

endmodule





    /* This portion is ony for Shallow copy Test
    seller2 = new seller1;

    seller2.show();
    seller2.name = "seller2";
    seller2.show();
    seller1.show();

    seller2.name = "Seller2";
    seller2.cash = 100;
    
    seller2.show();
    seller1.show();

    seller2.pkt.amount = 200;

    seller2.show();
    seller1.show();

    */

