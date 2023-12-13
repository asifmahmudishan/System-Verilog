class parent;
  
  local int math_number = 31;
  //int secret_number = math_number; //1st way
  function int secret_number();
  return math_number;
  endfunction
  
endclass


class child extends parent;
  
  function int get_number;
   // secret_number();
   //super.secret_number();
  //$display("Secret Math number = %0d", secret_number()); //2nd way
  endfunction
  
endclass

module tb();
  
  child chld;
  
  initial begin
    
    chld = new();
    chld.get_number;
    $display("Secret Math Number :%0d",chld.get_number()); //2nd way
    
  end
endmodule 
