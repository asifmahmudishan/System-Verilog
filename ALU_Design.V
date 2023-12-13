module alu();

  int a, b, s, sb, m, d;

  initial begin
    a = -12;
    b = 3;
   
    s = sum(a, b);
    $display("Sum: %0d", s);

    sb = sub(a, b);
    $display("Sub: %0d", sb);

    m = mul(a, b);
    $display("Mul: %0d", m);

    d = div(a, b);
    $display("Div: %0d", d);

  end

//Calculate Sum
  function int sum(int a, int b);
    sum = a + b;
  endfunction

//Calculate sub
  function int sub(int a, int b);
    b = ~b;
    b = sum(b, 1);
    sub = sum(a, b);
  endfunction

/// Calculate multiplication
function int mul(int a, int b);
  static int result = 0;

  if (b < 0) begin
    b = -b;
    repeat (b) result = sum(result, a);
    result = sub(0, result);
  end
  else begin
    repeat (b) result = sum(result, a);
  end

  mul = result;
endfunction


// Calculate Division
function int div(int a, int b);
  static int quotient = 0;

  if (b == 0) begin
    $display("Error: Division by zero");
    div = 0;
    return div;
  end

  if ((a < 0) ^ (b < 0)) begin
    quotient = sub(0, quotient);
  end

  if (a < 0) begin
    a = sub(0, a);
  end

  if (b < 0) begin
    b = sub(0, b);
  end

  while (a >= b) begin
    a = sub(a, b);
    quotient = sum(quotient, 1);
  end

  div = quotient;
endfunction


endmodule
