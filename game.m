%Initial function
function game()
    %Initial parameters
    fig = figure('Name', 'Ultimate Tic-Tac-Toe', ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
        'Resize', 'off', 'Position', [400 200 600 600]);
    board = repmat(' ', 3, 3, 3, 3);
    
    btnSize = [60 60];
    spaceSize = [10 10];
    gridSpaceSize = [15 15];

    buttons = gobjects(9, 9);
    for r = 1:9
        for c = 1:9
            xpos =
            ypos =  % invertovanie Y
            buttons(r,c) = uicontrol('Parent', fig, ...
                'Style', 'pushbutton', ...
                'String', '', ...
                'FontSize', 24, ...
                'FontWeight', 'bold', ...
                'Position', [xpos ypos btnSize], ...
                'Callback', @(src,~) openMiniGame(r,c));
        end
    end
end

