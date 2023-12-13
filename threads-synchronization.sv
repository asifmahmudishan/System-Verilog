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
endclass

class Seller;
  int cash;
  Packet pkt = new();
  string name;
  mailbox #(Packet) via;
  event sellerWaiting, sellerSending, doAgain;  

  function void EventDec(event sellerWaiting, sellerSending, doAgain);
    this.sellerWaiting = sellerWaiting;
    this.sellerSending = sellerSending;
    this.doAgain = doAgain;
  endfunction

  task selling();
    $display($time, "ns || Seller is waiting for customer's order");

    // Seller waiting for 50 ns
    #50;

   // $display($time, "ns || Seller Waiting ");
    $display($time, "ns || Seller Got order from Customer and now preparing item");
    pkt.amount = 80;

    // Preparing packet for 50 ns
    #50;

    $display($time, "ns || Seller Item prepared, now sending");
    via.put(pkt);
    ->sellerSending;

    $display($time, "ns || Seller waiting for response of Customer");

    // Customer response for 50 ns
    #50;

    if (pkt.amount != 100) begin
      // If packet is not okay, take the order again
      $display($time, "ns || Seller received packet back, something is wrong. Taking the order again.");
      ->sellerWaiting;
    end else begin
      $display($time, "ns || Seller Says Thanks");
    end
  endtask
endclass

class Buyer;
  int cash;
  Packet pkt = new();
  string name;
  mailbox #(Packet) via;
  event buyerOrder, buyerReceiving, doAgain;

  function void EventDec(event buyerOrder, buyerReceiving, doAgain);
    this.buyerOrder = buyerOrder;
    this.buyerReceiving = buyerReceiving;
    this.doAgain = doAgain;
  endfunction

  task buying();
    $display($time, "ns || Buyer Thinking of what to buy");

    // Waiting for 50 ns
    #50;

    // Customer places order
    ->buyerOrder;
    $display($time, "ns || Buyer Place Order");
    $display($time, "ns || Buyer Waiting for Seller to send package");

    // Mechanism to receive the package for 50 ns
    #60;

    $display($time, "ns || Buyer Receiving");
    via.get(pkt);
    $display($time, "ns || Buyer pkt.amount = %0d", pkt.amount);
    $display($time, "ns || Buyer got package");

    // Dealay for checking the item for 50 ns
    #50;

    if (pkt.amount != 100) begin
      // If packet is not okay, return and take the order again
      $display($time, "ns || Buyer Found Problem in package, returning");
      ->doAgain;
    end else begin
      $display($time, "ns || Buyer Found Package okay. Say Thanks");
      ->doAgain;
    end
  endtask
endclass

module sb_p3();
  Buyer buyer;
  Seller seller;

  event packetWaiting, packetSending, packetWaitingAgain;

  initial begin
    buyer = new();
    seller = new();

    buyer.EventDec(packetWaiting, packetSending, packetWaitingAgain);
    seller.EventDec(packetWaiting, packetSending, packetWaitingAgain);

    buyer.via = new(2);
    seller.via = buyer.via;

    fork
      buyer.buying();
      seller.selling();
    join

    $display($time, "ns   ||   Operation Done");
  end
endmodule
