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
    result = sub(0, result); //for minues value 
  end
  else begin
    repeat (b) result = sum(result, a);
  end

  mul = result;
endfunction


//Calculte div
function int div(int a, int b);
  static int quotient = 0;
  static int reminder = 1;

  if (b == 0) begin
    $display("Error: Division by zero");
    div = 0;
    return div;
  end

  if (a < 0) begin
    reminder = -reminder;
    a = -a;
  end

  if (b < 0) begin
    reminder = -reminder;
    b = -b;
  end

  while (a >= b) begin
    a = sub(a, b);
    quotient = sum(quotient, 1);
  end

  div = reminder * quotient;
endfunction



endmodule
