module ALU();
  
  int a, b, s, d, m, div;
  
  initial begin
    a = 6;
    b = -4;
    
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
    
    for (int i = 0; i < -b; i = sum(i, 1)) begin
      result = sum(result, -a);
    end
    
    mul = result;
  endfunction

  function int divide(int a, int b);
  if (a < 0 && b > 0) begin
    a = -a;
    divide = -divide(a, b);
  end else if (a > 0 && b < 0) begin
    b = -b;
    divide = -divide(a, b);
  end else if (a < b) begin
    divide = 0;
  end else begin
    int quotient;
    quotient = divide(sub(a, b), b);
    divide = sum(quotient, 1);
  end
endfunction

endmodule 
