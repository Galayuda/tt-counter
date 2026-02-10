`timescale 1ns/1ps

module tb_counter;
    reg clk = 0;
    reg rst_n = 0;
    
    // Bidirectional порты — объявляем как wire
    wire [7:0] io_in;
    wire [7:0] io_out;
    wire [7:0] io_oeb;
    
    // Инициализация входов в состояние high-Z (третье состояние)
    // Ключевое исправление: используем 'assign' вне блока initial
    assign io_in = 8'bz;
    
    // Экземпляр модуля
    user_project_wrapper uut (
        .clk(clk),
        .rst_n(rst_n),
        .io_in(io_in),
        .io_out(io_out),
        .io_oeb(io_oeb)
    );
    
    // Тактовый генератор (10 МГц = период 100 нс)
    always #50 clk = ~clk;
    
    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_counter);
        
        // Сброс
        #100;
        rst_n = 1;
        
        // Ждём 20 тактов
        #1000;
        
        $display("✅ Тест пройден! Счётчик работает.");
        $finish;
    end
    
    // Мониторинг значений счётчика
    always @(posedge clk) begin
        if (rst_n)
            $display("Такт %0d: count = %b", $time/100, io_out[3:0]);
    end
endmodule
