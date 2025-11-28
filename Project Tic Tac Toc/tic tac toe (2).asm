.model small
.stack 100h

.data
    ; Game variables
    board_size db 3      ; Default 3x3
    win_condition db 3   ; Hardcoded 3 in a row
    board db 81 dup(?)   ; Max 9x9 board
    
    ; Messages
    msg_welcome db 'Customizable Tic Tac Toe Game!',13,10,'$'
    msg_choose_size db 13,10,'Choose board size (3-9): $'
    ; msg_choose_win removed
    msg_invalid_size db 13,10,'Invalid size! Must be 3-9.$'
    ; msg_invalid_win removed
    msg_player1 db 13,10,'Player 1 (X) - Enter position: $'
    msg_player2 db 13,10,'Player 2 (O) - Enter position: $'
    msg_invalid db 13,10,'Invalid move! Try again.$'
    msg_win1 db 13,10,'Player 1 (X) wins!$'
    msg_win2 db 13,10,'Player 2 (O) wins!$'
    msg_draw db 13,10,'Game draw!$'
    msg_newline db 13,10,'$'
    msg_space db ' $'
    ; msg_dash and msg_pipe are used in display_board and remain
    msg_dash db '-'
    msg_pipe db '|'
    
    ; Current player (0=Player1, 1=Player2)
    current_player db 0
    
    ; Move counter
    moves db 0
    
    ; Temporary buffers
    temp db 0
    temp_char db 0

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Display welcome message
    mov ah, 09h
    lea dx, msg_welcome
    int 21h
    
    ; Get board size from user
    call get_board_size
    
    ; *** Removed call to get_win_condition ***
    
    ; Initialize board
    call initialize_board
    
    ; Start game
    jmp game_loop

game_loop:
    ; Display board
    call display_board
    
    ; Get player move
    call get_move
    
    ; Check for win
    call check_win
    cmp al, 1
    je game_over
    
    ; Check for draw
    mov al, board_size
    mul al          ; Total cells = size * size
    cmp moves, al
    je game_draw      ; If moves == total cells, it's a draw
    
    ; Switch player
    call switch_player
    jmp game_loop

game_draw:
    ; Display draw message
    call display_board ; Display final board
    mov ah, 09h
    lea dx, msg_draw
    int 21h
    jmp exit_game

game_over:
    ; Display winner message (includes final board display)
    call display_winner

exit_game:
    mov ah, 4ch
    int 21h
main endp

; Get board size from user (3-9)
get_board_size proc
input_size:
    mov ah, 09h
    lea dx, msg_choose_size
    int 21h
    
    ; Get input
    mov ah, 01h
    int 21h
    
    ; Convert ASCII to number
    sub al, '0'
    cmp al, 3
    jl invalid_size
    cmp al, 9
    jg invalid_size
    
    ; Valid size
    mov board_size, al
    ret
    
invalid_size:
    mov ah, 09h
    lea dx, msg_invalid_size
    int 21h
    jmp input_size
get_board_size endp

; *** Removed get_win_condition proc ***

; Initialize board with numbers
initialize_board proc
    mov cx, 0
    mov al, board_size
    mul al          ; Calculate total cells (size * size)
    mov cx, ax
    
    mov si, 0
    mov bl, '1'     ; Start with character '1'
    
init_loop:
    mov board[si], bl
    inc bl
    inc si
    loop init_loop
    ret
initialize_board endp

; Display the game board
display_board proc
    mov ah, 09h
    lea dx, msg_newline
    int 21h
    
    mov ch, 0         ; Row counter
    mov cl, board_size
    mov si, 0         ; board index
    
row_loop:
    push cx
    
    ; Display row separator (except first row)
    cmp ch, 0
    je no_separator
    
    mov ah, 09h
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    mov cl, board_size
    mov bl, 0
separator_loop:
    mov ah, 02h
    mov dl, '-'
    int 21h
    mov dl, '-'
    int 21h
    mov dl, '-'
    int 21h
    
    dec cl
    cmp cl, 0
    je separator_done
    
    mov dl, '+'
    int 21h
    
    jmp separator_loop
    
separator_done:
    mov ah, 09h
    lea dx, msg_newline
    int 21h

no_separator:
    mov cl, board_size
    mov bl, 0
    
col_loop:
    ; Display cell with proper formatting
    mov ah, 02h
    mov dl, ' '
    int 21h
    
    mov dl, board[si]
    int 21h
    
    mov dl, ' '
    int 21h
    
    ; Display column separator (except last column)
    inc bl
    cmp bl, board_size
    je no_pipe
    
    mov dl, '|'
    int 21h
    
no_pipe:
    inc si
    dec cl
    jnz col_loop
    
    ; New line
    mov ah, 09h
    lea dx, msg_newline
    int 21h
    
    inc ch
    pop cx
    dec cx
    jnz row_loop
    
    ret
display_board endp

; Get player move
get_move proc
get_input:
    ; Display appropriate player message
    mov ah, 09h
    cmp current_player, 0
    jne player2_msg
    lea dx, msg_player1
    jmp display_msg
player2_msg:
    lea dx, msg_player2
display_msg:
    int 21h
    
    ; Get input
    mov ah, 01h
    int 21h
    
    ; Save input character
    mov temp_char, al
    
    ; Convert ASCII to 0-based index (e.g., '1' -> 0)
    sub al, '1'
    mov bl, al ; bl now holds the 0-based index
    
    ; Check if index is within bounds [0, size*size - 1]
    mov al, board_size
    mul al          ; al = size * size
    dec al          ; al = max index
    
    cmp bl, al
    jg invalid_move ; Index is too high
    
    ; Restore original input to check for '1' or less
    mov al, temp_char
    cmp al, '1'
    jl invalid_move
    
    ; Check if position is empty (contains a number, not 'X' or 'O')
    mov bh, 0
    mov al, board[bx] ; Get content of the cell (bx is the 0-based index)
    
    ; Is it an 'X' or 'O'? If so, it's an invalid move.
    cmp al, 'X'
    je invalid_move
    cmp al, 'O'
    je invalid_move
    
    ; Is the content the same as the user's input character?
    ; This is redundant if it's not 'X' or 'O', because the board
    ; is initialized with '1', '2', '3', etc.
    ; But for safety against unprintable chars, we check it's >= '1'
    cmp al, '1'
    jl invalid_move ; The cell must contain at least '1'
    
valid_move:
    ; Valid move - update board
    mov al, current_player
    cmp al, 0
    jne place_o
    mov board[bx], 'X' ; bx is the 0-based index from '1' - '1'
    jmp move_done
place_o:
    mov board[bx], 'O'
    
move_done:
    inc moves
    ret
    
invalid_move:
    mov ah, 09h
    lea dx, msg_invalid
    int 21h
    jmp get_input
get_move endp

; Switch between players
switch_player proc
    xor current_player, 1
    ret
switch_player endp

; Check for win condition
check_win proc
    ; Check rows
    call check_rows
    cmp al, 1
    je win_found
    
    ; Check columns
    call check_columns
    cmp al, 1
    je win_found
    
    ; Check diagonals
    call check_diagonals
    cmp al, 1
    je win_found
    
    mov al, 0
    ret
    
win_found:
    mov al, 1
    ret
check_win endp

; Check all rows for win
check_rows proc
    mov ch, 0             ; Row counter
    
row_check_loop:
    mov cl, 0             ; Column counter (0-based)
    mov bl, 0             ; Consecutive counter for current player
    
row_inner_loop:
    ; Calculate position = row * size + column
    mov al, ch
    mov dl, board_size
    mul dl                ; ax = row * size
    add al, cl            ; al = index
    mov si, ax            ; si = index
    
    ; Get cell value
    mov dl, board[si]
    
    ; Determine target symbol ('X' or 'O')
    mov ah, 'X'           ; Assume 'X'
    cmp current_player, 0
    je player_symbol_row
    mov ah, 'O'           ; If not player 1, it's 'O'
player_symbol_row:

    ; Check if current cell matches the target symbol
    cmp dl, ah
    je found_match_row
    jmp reset_count_row
    
found_match_row:
    ; Found matching symbol - increment counter
    inc bl                ; Use bl for consecutive count
    cmp bl, win_condition
    jge row_win_found
    jmp next_row_cell
    
reset_count_row:
    ; Reset counter when symbol doesn't match
    mov bl, 0
    jmp next_row_cell
    
next_row_cell:
    inc cl
    cmp cl, board_size
    jl row_inner_loop
    
    ; Next row
    inc ch
    cmp ch, board_size
    jl row_check_loop
    
    mov al, 0             ; No win found
    ret
    
row_win_found:
    mov al, 1             ; Win found
    ret
check_rows endp

; Check all columns for win
check_columns proc
    mov cl, 0             ; Column counter (0-based)
    
col_check_loop:
    mov ch, 0             ; Row counter (0-based)
    mov bl, 0             ; Consecutive counter for current player
    
col_inner_loop:
    ; Calculate position = row * size + column
    mov al, ch
    mov dl, board_size
    mul dl                ; ax = row * size
    add al, cl            ; al = index
    mov si, ax            ; si = index
    
    ; Get cell value
    mov dl, board[si]
    
    ; Determine target symbol ('X' or 'O')
    mov ah, 'X'           ; Assume 'X'
    cmp current_player, 0
    je player_symbol_col
    mov ah, 'O'           ; If not player 1, it's 'O'
player_symbol_col:

    ; Check if current cell matches the target symbol
    cmp dl, ah
    je found_match_col
    jmp reset_count_col
    
found_match_col:
    ; Found matching symbol - increment counter
    inc bl                ; Use bl for consecutive count
    cmp bl, win_condition
    jge col_win_found
    jmp next_col_cell
    
reset_count_col:
    ; Reset counter when symbol doesn't match
    mov bl, 0
    jmp next_col_cell
    
next_col_cell:
    inc ch
    cmp ch, board_size
    jl col_inner_loop
    
    ; Next column
    inc cl
    cmp cl, board_size
    jl col_check_loop
    
    mov al, 0             ; No win found
    ret
    
col_win_found:
    mov al, 1             ; Win found
    ret
check_columns endp

; Check diagonals for win
check_diagonals proc
    ; Check main diagonal (\)
    call check_main_diagonal
    cmp al, 1
    je diagonal_win
    
    ; Check anti-diagonal (/)
    call check_anti_diagonal
    cmp al, 1
    je diagonal_win
    
    mov al, 0
    ret
    
diagonal_win:
    mov al, 1
    ret
check_diagonals endp

; Check main diagonal (\)
; This procedure checks for a win only on the main diagonal itself.
; For a customizable size, the check should be generalized to all diagonals.
; However, for a 3-in-a-row condition, we'll keep the simple main diagonal check as per the original code's structure.
check_main_diagonal proc
    mov ch, 0             ; Row counter
    mov bl, 0             ; Consecutive counter for current player
    
main_diag_loop:
    ; Calculate position = row * size + row
    mov al, ch
    mov dl, board_size
    mul dl                ; ax = row * size
    add al, ch            ; al = index
    mov si, ax            ; si = index
    
    mov dl, board[si]
    
    ; Determine target symbol ('X' or 'O')
    mov ah, 'X'
    cmp current_player, 0
    je player_symbol_main
    mov ah, 'O'
player_symbol_main:
    
    ; Check if current cell matches the target symbol
    cmp dl, ah
    je found_match_main
    jmp reset_count_main
    
found_match_main:
    inc bl
    cmp bl, win_condition
    jge main_diag_win
    jmp next_main_diag
    
reset_count_main:
    mov bl, 0
    jmp next_main_diag
    
next_main_diag:
    inc ch
    cmp ch, board_size
    jl main_diag_loop
    
    mov al, 0
    ret
    
main_diag_win:
    mov al, 1
    ret
check_main_diagonal endp

; Check anti-diagonal (/)
; This procedure checks for a win only on the anti-diagonal itself.
check_anti_diagonal proc
    mov ch, 0             ; Row counter
    mov bl, 0             ; Consecutive counter for current player
    
anti_diag_loop:
    ; Calculate position = row * size + (size - 1 - row)
    mov al, ch
    mov dl, board_size
    mul dl                ; ax = row * size
    
    mov dl, board_size    ; dl = size
    dec dl                ; dl = size - 1
    sub dl, ch            ; dl = size - 1 - row (the column index)
    add al, dl            ; al = index
    mov si, ax            ; si = index
    
    mov dl, board[si]
    
    ; Determine target symbol ('X' or 'O')
    mov ah, 'X'
    cmp current_player, 0
    je player_symbol_anti
    mov ah, 'O'
player_symbol_anti:
    
    ; Check if current cell matches the target symbol
    cmp dl, ah
    je found_match_anti
    jmp reset_count_anti
    
found_match_anti:
    inc bl
    cmp bl, win_condition
    jge anti_diag_win
    jmp next_anti_diag
    
reset_count_anti:
    mov bl, 0
    jmp next_anti_diag
    
next_anti_diag:
    inc ch
    cmp ch, board_size
    jl anti_diag_loop
    
    mov al, 0
    ret
    
anti_diag_win:
    mov al, 1
    ret
check_anti_diagonal endp

; Display winner message
display_winner proc
    call display_board
    mov ah, 09h
    cmp current_player, 0
    jne player2_wins
    lea dx, msg_win1
    jmp show_winner
player2_wins:
    lea dx, msg_win2
show_winner:
    int 21h
    ret
display_winner endp

end main