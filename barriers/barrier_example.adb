with Ada.Text_IO;
use Ada.Text_IO;

procedure Barrier_Example is

    N: constant Integer := 3;

    protected Barrier is
        entry Await;
    private
        entry Wait;
        count: Natural := Natural'First;
    end Barrier;

    protected body Barrier is

        entry Await when true is
        begin
            count := count + 1;
            requeue Wait;
        end Await;

        entry Wait when count >= N is
        begin
            null;
        end Wait;


    end Barrier;

    task type T(id: Integer) is
    end T;

    task body T is
    begin
        Put_Line(Integer'Image(id) & " started");
        delay id * 0.5;
        Put_Line(Integer'Image(id) & " waiting");
        Barrier.Await;
        Put_Line(Integer'Image(id) & " ended");
    end T;


    task1: T(1);
    task2: T(2);
    task3: T(3);


begin
    null;
end Barrier_Example;

