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
    boardBig = repmat(' ', 3, 3);
    boardAvailible = ones(3);
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
        %Position on Big Board Row Next Move
        y = valueBBoard(row);
        %Position on Big Board Column Next Move
        x = valueBBoard(column);
        if(isequal(lastPosition,[0, 0]))
            %set(buttons(3*y-2:3*y,3*x-2:3*x),'BackgroundColor',colorActive);
            set(buttons(row,column), 'String', playerActive,'Enable','off');
            board(ceil(row/3),ceil(column/3), y, x) = playerActive;
            switchPlayer()
            colorGrid([y,x],colorActive);
            set(statusText, 'String', sprintf('Hráč %s je na rade', playerActive));
            lastPosition = [row, column];
            return;
        end
        %Check if move is legal
        if(inGrid([valueBBoard(lastPosition(1)),valueBBoard(lastPosition(2))],[row,column]))
            set(buttons(row,column), 'String', playerActive,'Enable','off');
        else
            if(boardAvailible(valueBBoard(lastPosition(1)),valueBBoard(lastPosition(2)))==0)
        set(buttons(row,column), 'String', playerActive,'Enable','off');
            else
                msgbox('Hras v zlom poli!');
            return;
            end
        end
        board(ceil(row/3),ceil(column/3), y, x) = playerActive;
        endSGrid(row,column);
        switchPlayer()
        %Highlight availible grids to~do
        if(boardAvailible(y,x)==0)
            
        else
            colorClear();
            colorGrid([y,x],colorActive);
        end
        set(statusText, 'String', sprintf('Hráč %s je na rade', playerActive));
        lastPosition = [row, column];
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
    function endSGrid(row,column)
        bigR = ceil(row/3);
        bigC = ceil(column/3);
        % Check win in Small Grid
        if checkWinSGrid(squeeze(board(bigR,bigC,:,:)), playerActive)
            boardBig(bigR, bigC) = playerActive;
            lockDraw([bigR,bigC],playerActive);
            boardAvailible(bigR,bigC) = 0;
        % Check draw in Small Grid
        elseif all(board(bigR, bigC, :, :) ~= ' ', 'all')
            boardBig(bigR, bigC) = '=';
            lockDraw([bigR,bigC],"=");
            boardAvailible(bigR,bigC) = 0;
        end
    end
    function won = checkWinSGrid(board, symbol)
        won = false;
        for i = 1:3
            if all(board(i,:) == symbol) || all(board(:,i) == symbol)
                won = true; return;
            end
        end
        if board(1,1) == symbol && board(2,2) == symbol && board(3,3) == symbol
            won = true; return;
        end
        if board(1,3) == symbol && board(2,2) == symbol && board(3,1) == symbol
            won = true; return;
        end
    end
    function lockDraw(grid,symbol)
    gridX = grid(2);
    gridY = grid(1);
    set(buttons(3*gridY-2:3*gridY,3*gridX-2:3*gridX),'BackgroundColor',"white","Enable","Off","ForegroundColor","none");
    switch(symbol)
        case "X"
            set(buttons(gridY*3-1,gridX*3-2),'BackgroundColor',"none");
            set(buttons(gridY*3-1,gridX*3),'BackgroundColor',"none");
            set(buttons(gridY*3-2,gridX*3-1),'BackgroundColor',"none");
            set(buttons(gridY*3,gridX*3-1),'BackgroundColor',"none");
        case "O"
            set(buttons(gridY*3-1,gridX*3-1),'BackgroundColor',"black");
        case "="
            set(buttons(gridY*3-1,gridX*3-2:gridX*3),'BackgroundColor',"black");
    end
    end
    function colorGrid(grid,color)
        gridX = grid(2);
        gridY = grid(1);
        set(buttons(3*gridY-2:3*gridY,3*gridX-2:3*gridX),'BackgroundColor',color);
    end
    function colorClear()
        for r = 1:9
            for c = 1:9
                if(isequal(buttons(r,c).BackgroundColor,playerXColor)||isequal(buttons(r,c).BackgroundColor,playerOColor))
                    set(buttons(r,c),'BackgroundColor',"black");
                end
            end 
        end
    end
end



%%==================================================================
function piskvorky()

    fig = figure('Name', 'Piskvorky ', ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
        'Resize', 'off', 'Position', [500 300 350 400]);
    
    % Initialize data
    board = repmat(' ',3,3);
    player = 'X';
    
    % Panel na gombiky
    panel = uipanel('Parent', fig, 'Position', [0.05 0.25 0.9 0.7]);
    
    % Vytvoerenie gombikov 3x3
    btnHandles = gobjects(3,3);
    btnSize = [80 80];
    spacing = 10;
    startX = 20;
    startY = 10;
    
    for r = 1:3
        for c = 1:3
            xpos = startX + (c-1)*(btnSize(1)+spacing);
            ypos = startY + (3-r)*(btnSize(2)+spacing);
            btnHandles(r,c) = uicontrol('Parent', panel, ...
                'Style', 'pushbutton', ...
                'String', '', ...
                'FontSize', 36, ...
                'FontWeight', 'bold', ...
                'Position', [xpos ypos btnSize], ...
                'Callback', @(src,~) buttonPressed(r,c));
        end
    end
    
    % Status hry
    statusText = uicontrol('Parent', fig, 'Style', 'text', ...
        'String', sprintf('Hráč %s'' je na rade', player), ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'Position', [50 50 250 40]);
    
    % Reset 
    uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Restart', ...
        'FontSize', 14, 'Position', [130 10 80 30], ...
        'Callback', @restartGame);
    
    
    function buttonPressed(r,c)
        if board(r,c) == ' '
            board(r,c) = player;
            set(btnHandles(r,c), 'String', player, 'Enable', 'off');
            if checkWin(player)
                set(statusText, 'String', sprintf('Hráč %s vyhral!', player));
                disableAllButtons();
                msgbox(sprintf('Hráč %s vyhral! Gratulujem!', player), 'Koniec hry');
            elseif all(board(:) ~= ' ')
                set(statusText, 'String', 'Nastala remíza!');
                msgbox('Nastala remíza!', 'Remíza');
            else
                switchPlayer();
                set(statusText, 'String', sprintf('Hráč  %s je na rade', player));
            end
        end
    end

    function switchPlayer()
        if player == 'X'
            player = 'O';
        else
            player = 'X';
        end
    end

    function disableAllButtons()
        for rr = 1:3
            for cc = 1:3
                set(btnHandles(rr,cc), 'Enable', 'off');
            end
        end
    end

    function enableAllButtons()
        for rr = 1:3
            for cc = 1:3
                set(btnHandles(rr,cc), 'Enable', 'on', 'String', '');
            end
        end
    end

    function restartGame(~,~)
        board(:) = ' ';
        player = 'X';
        enableAllButtons();
        set(statusText, 'String', sprintf('Hráč %s je na rade', player));
    end

    function won = checkWin(sym)
        
        won = false;
        for i = 1:3
            if all(board(i,:) == sym) || all(board(:,i) == sym)
                won = true;
                return
            end
        end
        if board(1,1) == sym && board(2,2) == sym && board(3,3) == sym
            won = true;
            return
        end
        if board(1,3) == sym && board(2,2) == sym && board(3,1) == sym
            won = true;
            return
        end
    end

end


