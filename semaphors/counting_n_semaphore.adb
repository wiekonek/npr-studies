with Ada.Text_IO;
use Ada.Text_IO;

procedure Counting_N_Semaphore is
    protected Semaphore is
        entry P(n: in Positive);
        procedure V(n: in Positive);
    private
        s: Integer := 4;
        temp_n: Positive := Positive'First;
        entry Wait;

    end Semaphore;

    protected body Semaphore is

        entry P(n: in Positive) when Wait'count = 0 is
        begin
            if n <= s then
                s := s - n;
            else
                temp_n := n;
                requeue Wait;
            end if;
        end P;

        procedure V(n: in Positive) is
        begin
            s := s + n;
        end V;

        entry Wait when temp_n <= s is
        begin
            s:= s - temp_n;
        end Wait;

    end Semaphore;

    task task1;
    task task2;
    task task3;

    task body task1 is
    begin
        loop
            Semaphore.P(1);
            Put_Line("task1 in critical section");
            delay 0.5;
            Put_Line("task1 out of critical section");
            Semaphore.V(1);
        end loop;
    end task1;

    task body task2 is
    begin
        loop
            Semaphore.P(3);
            Put_Line("task2 in critical section");
            delay 1.0;
            Put_Line("task2 out of critical section");
            Semaphore.V(3);
        end loop;
    end task2;

    task body task3 is
    begin
        loop
            Semaphore.P(2);
            Put_Line("task3 in critical section");
            delay 2.0;
            Put_Line("task3 out of critical section");
            Semaphore.V(2);
        end loop;
    end task3;

begin
    null;
end Counting_N_Semaphore;

