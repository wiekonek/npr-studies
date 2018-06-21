with Ada.Text_IO;
use Ada.Text_IO;


procedure Priority_Semaphore is

    type Priorities is array(1..5) of Integer;

    protected Semaphore is
        entry P(id: Integer; priority: Natural);
        entry V(id: Integer);
    private
        entry Wait(id: Integer; priority: Natural);
        process_priorities: Priorities;
        max_priority: Natural := 0;
        locked: Boolean := False;
    end Semaphore;

    protected body Semaphore is

        entry P(id: Integer; priority: Natural) when true is
        begin
            process_priorities(id) := priority;
            for i in process_priorities'range loop
                if (max_priority < process_priorities(i)) then
                   max_priority := process_priorities(i);
                end if;
            end loop;
            requeue Wait;
        end P;

        entry Wait(id: Integer; priority: Natural) when not locked is
        begin
            if (max_priority = priority) then
                locked := True;
            else
                requeue P;
            end if;
        end Wait;



        entry V(id: Integer) when true is
        begin
            max_priority := 0;
            process_priorities(id) := -1;
            for i in process_priorities'range loop
                if (max_priority < process_priorities(i)) then
                   max_priority := process_priorities(i);
                end if;
            end loop;
            locked := false;
        end V;
    end Semaphore;
    task type T(id: Integer) is
    end T;

    task body T is
    begin
        loop
            delay 0.5;
            Semaphore.P(id, id);
            Put_Line(Integer'Image(id) & " in");
            delay 1.0;
            Put_Line(Integer'Image(id) & " out");
            Semaphore.V(id);
        end loop;
    end T;


    task1: T(1);
    task2: T(2);
    task3: T(3);
    task4: T(4);
    task5: T(5);


begin
    null;
end Priority_Semaphore;
