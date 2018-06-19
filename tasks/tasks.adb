-- Producent - konsument, buffor 1 el., spotkania

with Ada.Text_IO;
use Ada.Text_IO;

procedure Tasks is

    task producer;
    task consumer;
    task type BUF is
        entry Put (param: in Integer);
        entry Get (param: out Integer);
    end BUF;
    bufTask: BUF;
    productId: Integer := 0;

    task body producer is
    begin
        loop
            delay 1.0;
            bufTask.Put(productId);
            Put("Producing: ");
            Put_Line(Integer'Image(productId));
            productId := productId + 1;
        end loop;
    end;

    task body consumer is
        product: Integer;
    begin
        loop
            bufTask.Get(product);
            Put("Consuming: ");
            Put_Line(Integer'Image(product));
        end loop;
    end;

    task body BUF is
        buffer: Integer := -1; -- -1 = buffer
    begin
        loop
            select
                when buffer = -1 => accept Put(param: in Integer) do
                    buffer := param;
                end Put;
            or
                when buffer > -1 => accept Get(param: out Integer) do
                    param := buffer;
                    buffer := -1;
                end Get;
            end select;
        end loop;
    end;
begin
    null;
end Tasks;

