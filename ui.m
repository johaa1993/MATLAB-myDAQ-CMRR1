 %http://se.mathworks.com/matlabcentral/answers/6258-nidaq-continuous-and-background-acquisition

function ui
    close all;
    %clear all;
    clc;
 
    s = daq.createSession('ni');
    s.IsContinuous = true;
    s.Rate = 10;
    s.addAnalogInputChannel ('myDAQ1', 'ai0', 'Voltage');
    s.addAnalogInputChannel ('myDAQ1', 'ai1', 'Voltage');
    s.addAnalogOutputChannel('myDAQ1', 'ao1', 'Voltage');
    s.Channels(1).Range = [-10 10];
    s.Channels(2).Range = [-10 10];
    s.addlistener ('DataAvailable', @plot_data);
    s.addlistener ('DataRequired', @queue_more_data);
    
    
    main_figure = figure('Visible','off');
    main_figure.Visible = 'on';
    main_figure.CloseRequestFcn = @my_closereq;

    emptyvec = nan(1, 100000);
    h1 = plot(emptyvec, emptyvec, emptyvec, emptyvec);
    ylim ([-10 10]);
    
    
    plot_index = 0;
    
    uicontrol('Style', 'pushbutton', 'String', 'Start',...
    'Position', [20 20 50 20],...
    'Callback', @start_mydaq);

    uicontrol('Style', 'pushbutton', 'String', 'Stop',...
    'Position', [20 60 50 20],...
    'Callback', @stop_mydaq);

    uicontrol('Style', 'pushbutton', 'String', 'test_1',...
    'Position', [20 100 50 20],...
    'Callback', @test_1);

     function start_mydaq (source, callbackdata)
        outputData(:,1) = linspace(0, 0, 10);
        s.queueOutputData (outputData);
        s.startBackground();
        h1(1).XData = nan(1, 100000);
        h1(2).XData = nan(1, 100000);
        h1(1).YData = nan(1, 100000);
        h1(2).YData = nan(1, 100000);
        plot_index = 0;
     end
 
     function stop_mydaq (source, callbackdata)
        s.stop();
     end

    function plot_data (src, event)
        plot_index = plot_index + 1;
        h1(1).XData(plot_index) = event.TimeStamps;
        h1(2).XData(plot_index) = event.TimeStamps;
        h1(1).YData(plot_index) = event.Data (1);
        h1(2).YData(plot_index) = event.Data (2);
    end
    
 
    function test_1 (source, callbackdata)
        disp('Test_1');
        outputData(:,1) = linspace(1, 1, 10);
        s.queueOutputData(outputData);
    end

    function queue_more_data (src,event)
        disp('more data');
        outputData(:,1) = linspace(0, 0, 10);
        s.queueOutputData(outputData);
    end

    function my_closereq (src,callbackdata)
        disp ('Close');
        s.stop;
        delete (main_figure);
        return;
    end

end