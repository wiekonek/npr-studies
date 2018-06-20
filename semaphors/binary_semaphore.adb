with Ada.Text_IO;
use Ada.Text_IO;

procedure Binary_Semaphore is

    task task1;
    task task2;
    task task3;

    protected Semaphore is
        entry P;
        entry V;
    private
        taken: Boolean := False;
    end Semaphore;


    protected body Semaphore is

        entry P when taken = False is
        begin
            taken := True;
        end P;

        entry V when taken = True is
        begin
           taken := False;
        end V;
    end Semaphore;


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
end Binary_Semaphore;
