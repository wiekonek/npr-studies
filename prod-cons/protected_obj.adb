-- Producer - consumer, buffor n el., protected object

with Ada.Text_IO;
use Ada.Text_IO;

procedure Protected_Obj is

    type Buffer_Storage is array(0..9) of Integer;
    task producer;
    task consumer;
    protected  Buffer is
        entry Put (product_id: in Integer);
        entry Get (product_id: out Integer);
    private
        buf: Buffer_Storage;
        count: Integer := 0;
        out_index: Integer := 0;
        in_index: Integer := 0;
    end Buffer;

    task body producer is
        product_id: Integer := 0;
    begin
        loop
            delay 0.5;
            Buffer.Put(product_id);
            Put("Producing: ");
            Put_Line(Integer'Image(product_id));
            product_id := product_id + 1;
        end loop;
    end;

    task body consumer is
        product: Integer;
    begin
        loop
            delay 0.75;
            Buffer.Get(product);
            Put("Consuming: ");
            Put_Line(Integer'Image(product));
        end loop;
    end;

    protected body Buffer is
        entry Put(product_id: in Integer) when count < buf'Length is
        begin
            buf(in_index) := product_id;
            in_index := in_index + 1;
            count := count + 1;
        end Put;

        entry Get(product_id: out Integer) when count > 0 is
        begin
            product_id := buf(out_index);
            out_index := out_index + 1;
            count := count - 1;
        end Get;
    end Buffer;

begin
    null;
end Protected_Obj;

