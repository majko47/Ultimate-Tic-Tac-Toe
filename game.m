%Initial function
function Game()
    %Global values
    playerXColor = [1,0,0];
    playerOColor = [0,0,1];
    lastPosition = [0 0];
    %Initial parameters
    fig = figure('Name', 'Ultimate Tic-Tac-Toe', ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
        'Resize', 'off', 'Position', [400 200 700 700]);
    board = repmat(' ', 3, 3, 3, 3);
    btnSize = [60 60];
    spaceSize = [5 5];
    gridSpaceSize = [10 10];
    playerActive = 'X';
    colorActive = playerXColor;

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
        if(isequal(lastPosition,[0, 0]))
        else
            if(mod(row,3)==0)
                y=3;
            else
                y=mod(row,3);
            end
            if(mod(column,3)==0)
                x=3;
            else
                x=mod(column,3);
            end
            set(buttons(3*y-2:3*y,3*x-2:3*x),'BackgroundColor',colorActive);
        end 
        set(buttons(row,column), 'String', playerActive,'Enable','off');
        switchPlayer()
        set(statusText, 'String', sprintf('Hráč %s je na rade', playerActive));
        lastPosition = [row, column]
    end
    function switchPlayer()
        if playerActive == 'X'
            playerActive = 'O';
            colorActive = playerOColor;
        else
            playerActive = 'X';
            colorActive = playerXColor;
        end
    end
    function res = valueBBoard(val)
        if(mod(val,3)==0)
            res=3;
        else
            res=mod(val,3);
        end
    end
    function res = inGrid(grid,val)
        gridX = grid(2);
        gridY = grid(1);
        valX = val(2);
        valY = val(1);
        if(valX <= gridX*3 && valX >= (gridX*3-2))&&(valY <= gridY*3 && valY >= (gridY*3-2))
            res = true;
        else 
            res = false;
        end
    end
end

