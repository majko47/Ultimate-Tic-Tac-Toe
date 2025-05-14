%Initial function
function Game()
    %Initial parameters
    fig = figure('Name', 'Ultimate Tic-Tac-Toe', ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
        'Resize', 'off', 'Position', [400 200 700 700]);
    board = repmat(' ', 3, 3, 3, 3);
    btnSize = [60 60];
    spaceSize = [5 5];
    gridSpaceSize = [10 10];
    playerActive = 'X';

    %Generating Board
    buttons = gobjects(9, 9);
    for r = 0:8
        for c = 0:8
            xpos = 50 + c*btnSize(1) + c*spaceSize(1) + floor(c/3)*gridSpaceSize(1);
            ypos = 640- (r*btnSize(2) + r*spaceSize(2) + floor(r/3)*gridSpaceSize(2));
            buttons(r+1,c+1) = uicontrol('Parent', fig, ...
                'Style', 'pushbutton', ...
                'String', '', ...
                'FontSize', 24, ...
                'FontWeight', 'bold', ...
                'Position', [xpos ypos btnSize], ...
                'Callback', @(src,~) Action(r+1,c+1));
        end
    end
    %Active Player text
    statusText = uicontrol('Parent', fig, 'Style', 'text', ...
        'String', sprintf('Hráč %s je na rade', playerActive), ...
        'FontSize', 14, ...
        'Position', [200 20 300 30]);
    %Player clicked button
    function Action(row,column)
    end
end

