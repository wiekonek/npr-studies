with Ada.Text_IO;
use Ada.Text_IO;

procedure Barrier_Example is

    N: constant Integer := 2;

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

    task task1;
    task task2;

    task body task1 is
    begin
        Put_Line("1 started");
        delay 1.0;
        Put_Line("1 waiting");
        Barrier.Await;
        Put_Line("1 ended");
    end task1;

    task body task2 is
    begin
        Put_Line("2 started");
        delay 0.5;
        Put_Line("2 waiting");
        Barrier.Await;
        Put_Line("2 ended");
    end task2;

begin
    null;
end Barrier_Example;

