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

	task body producer is
	begin
		for i in 1..10 loop
			bufTask.Put(i);
			Put("Producing: ");
			Put_Line(Integer'Image(i));
		end loop;
	end;

	task body consumer is
		product: Integer;
	begin
		for i in 1..10 loop
			bufTask.Get(product);
			Put("Consuming: ");
			Put_Line(Integer'Image(product));
		end loop;
	end;

	task body BUF is
	       buffer: Integer;	
	begin
		for i in 1..10 loop
			accept Put(param: in Integer) do
				buffer := param;
			end Put;
			accept Get(param: out Integer) do
				param := buffer;
			end Get;
		end loop;
	end;
begin
	null;
end Tasks;

