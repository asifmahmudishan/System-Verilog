module ALU();
  
  int a, b, s, d, m, div, and_op, or_op, xor_op, xnor_op;
  
  initial begin
    a = 8;
    b = 4;
    
    // Addition
    s = sum(a, b);
    $display("Sum: %0d", s);
    
    // Subtraction
    d = sub(a, b);
    $display("Subtraction: %0d", d);
    
    // Multiplication
    m = mul(a, b);
    $display("Multiplication: %0d", m);
    
     // Division
    div = divide(a, b);
    $display("Division: %0d", div);

	// Logical AND
    and_op = logical_and(a, b);
    $display("Logical AND: %0d", and_op);
    
    // Logical OR
    or_op = logical_or(a, b);
    $display("Logical OR: %0d", or_op);
    
    // Logical XOR
    xor_op = logical_xor(a, b);
    $display("Logical XOR: %0d", xor_op);
    
    // Logical XNOR
    xnor_op = logical_xnor(a, b);
    $display("Logical XNOR: %0d", xnor_op);
  end 
  
  function int sum(int a, int b);
    sum = a + b;
  endfunction
  
  function int sub(int a, int b);
    b = ~b;
    b = sum(b, 1);
    sub = sum(a, b);
  endfunction

  function int mul(int a, int b);
    int result;
    result = 0;
    
    for (int i = 0; i < b; i = sum(i, 1)) begin
      result = sum(result, a);
    end
    
    mul = result;
  endfunction
  
  
/*
  function int divide(int a, int b);
    int quotient;
    quotient = 0;
    
    
    while (a >= b) begin
      a = sub(a, b);
      quotient = sum(quotient, 1);
    end
    
    
    divide = quotient;
  endfunction
*/

  function int divide(int a, int b);
  if (a < b) begin
    divide = 0;
   end else begin
    int quotient;
    quotient = divide(sub(a, b), b);
    divide = sum(quotient, 1);
   end
  endfunction

	function int logical_and(int a, b);
    logical_and = a & b;
  endfunction
  
  function int logical_or(int a, b);
    logical_or = a | b;
  endfunction
  
  function int logical_xor(int a, b);
    logical_xor = a ^ b;
  endfunction
  
  function int logical_xnor(int a, b);
    logical_xnor = ~(a ^ b);
  endfunction
   
endmodule 
