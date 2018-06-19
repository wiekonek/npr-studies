-- Producer-consumer, buffer 1 el., tasks

with Ada.Text_IO;
use Ada.Text_IO;

procedure Tasks_1 is

    task producer;
    task consumer;
    task buffer is
        entry Put (param: in Integer);
        entry Get (param: out Integer);
    end;
    productId: Integer := 0;

    task body producer is
    begin
        loop
            delay 1.0;
            buffer.Put(productId);
            Put("Producing: ");
            Put_Line(Integer'Image(productId));
            productId := productId + 1;
        end loop;
    end;

    task body consumer is
        product: Integer;
    begin
        loop
            buffer.Get(product);
            Put("Consuming: ");
            Put_Line(Integer'Image(product));
        end loop;
    end;

    task body buffer is
        buf: Integer := -1; -- -1 = empty
    begin
        loop
            select
                when buf = -1 => accept Put(param: in Integer) do
                    buf := param;
                end Put;
            or
                when buf > -1 => accept Get(param: out Integer) do
                    param := buf;
                    buf := -1;
                end Get;
            end select;
        end loop;
    end;
begin
    null;
end Tasks_1;

