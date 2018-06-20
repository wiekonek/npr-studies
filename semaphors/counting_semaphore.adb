with Ada.Text_IO;
use Ada.Text_IO;

procedure Counting_Semaphore is
    protected Semaphore is
        entry P;
        procedure V;
    private
        s: Integer := 2;
    end Semaphore;

    protected body Semaphore is

        entry P when s > 0 is
        begin
            s := s - 1;
        end P;

        procedure V is
        begin
            s := s + 1;
        end V;

    end Semaphore;

    task task1;
    task task2;
    task task3;

    task body task1 is
    begin
        loop
            Semaphore.P;
            Put_Line("task1 in critical section");
            delay 0.5;
            Put_Line("task1 out of critical section");
            Semaphore.V;
        end loop;
    end task1;

    task body task2 is
    begin
        loop
            Semaphore.P;
            Put_Line("task2 in critical section");
            delay 1.0;
            Put_Line("task2 out of critical section");
            Semaphore.V;
        end loop;
    end task2;

    task body task3 is
    begin
        loop
            Semaphore.P;
            Put_Line("task3 in critical section");
            delay 2.0;
            Put_Line("task3 out of critical section");
            Semaphore.V;
        end loop;
    end task3;

begin
    null;
end Counting_Semaphore;
