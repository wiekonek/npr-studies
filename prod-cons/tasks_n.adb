-- Producer - consumer, buffor n el., tasks

with Ada.Text_IO;
use Ada.Text_IO;

procedure Tasks_n is

    task producer;
    task consumer;
    task buffer is
        entry Put (productId: in Integer);
        entry Get (productId: out Integer);
    end;
    productId: Integer := 0;

    task body producer is
    begin
        loop
            delay 0.5;
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
            delay 0.75;
            buffer.Get(product);
            Put("Consuming: ");
            Put_Line(Integer'Image(product));
        end loop;
    end;

    task body buffer is
        buf: array(1..10) of Integer := (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1); -- -1 = empty
        count: Integer := 0;
        -- prodIndex: Integer := 1;
        -- consIndex: Integer := 0;
    begin
        loop
        -- Put_Line(Integer'Image(buf'Length));
        -- Put_Line(Integer'Image(count));
            select
                when count < buf'Length=> accept Put(productId: in Integer) do
                    for i in buf'range loop
                        if buf(i) = -1 then
                            buf(i) := productId;
                            count :=  count + 1;
                            exit;
                        end if;
                    end loop;
                end Put;
            or
                when count > 0 => accept Get(productId: out Integer) do
                    for i in buf'range loop
                        if buf(i) /= -1 then
                            productId := buf(i);
                            buf(i) := -1;
                            count := count - 1;
                            exit;
                        end if;
                    end loop;
                end Get;
            end select;
        end loop;
    end;
begin
    null;
end Tasks_n;

