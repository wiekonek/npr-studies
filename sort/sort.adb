with Ada.Text_IO;
use Ada.Text_IO;


procedure Sort is
    type Vector is array (Integer range <>) of Float;
    arr : Vector(1..10) := (0.31, 0.9, 0.8, 0.4, 0.3, 1.0, 0.7, 0.2, 0.45, 0.246);

    procedure Sort_Vector(tab : in out Vector) is
        procedure Swap(Left, Right: in out Float) is
            Temp : Float := Left;
        begin
            Left := Right;
            Right := Temp;
        end Swap;
    begin
        for j in tab'range loop
            for i in tab'first..tab'last-j loop
                if tab(i) > tab(i+1) then
                    swap(tab(i), tab(i+1));
                end if;
            end loop;
        end loop;
    end Sort_Vector;
begin
    Put_Line("Before:");
    for i in arr'range loop
        Put(Float'Image(arr(i)));
        Put(" ");
    end loop;
    New_Line;

    Sort_Vector(arr);

    Put_Line("After:");
    for i in arr'range loop
        Put(Float'Image(arr(i)));
        Put(" ");
    end loop;
    New_Line;
end;

