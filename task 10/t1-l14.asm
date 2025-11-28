mov al,13h
mov ah,0
int 10h

      ;1 Parallelogram
      
mov al,1100b
mov cx,120
mov dx,10
mov ah,0ch
int 10h  

mov bl,120       ;line1
firstline:
int 10h
inc cx
dec bl
jnz firstline 

mov al,1000b
mov bl,100
secondline:      ;line2
int 10h
inc dx
dec cx
dec bl
jnz secondline

mov al,1011b
mov bl,120
thirdline:      ;line3
int 10h
dec cx
dec bl
jnz thirdline

mov al,1010b
mov bl,100         ;line4
fourthline:
int 10h
dec dx
inc cx
dec bl
jnz fourthline

         ;1.1 Parallelogram 

mov cx,240
mov dx,10
mov bl,8       ;line1
line1:
int 10h
inc cx
dec bl
jnz line1

mov al,1000b
mov bl,110
line2:         ;line2
int 10h
inc dx
dec cx
dec bl
jnz line2

mov al,1011b
mov bl,118
line3:      ;line3
int 10h
dec cx
dec bl
jnz line3

mov al,1010b
mov bl,8         ;line4
line4:
int 10h
dec dx
dec bl
jnz line4
              
              ;1 leg
              
mov al,1010b
mov bl,50         ;line4
line17:
int 10h
inc dx
dec bl
jnz line17

mov al,1000b
mov bl,7
line18:         ;line2
int 10h
inc dx
inc cx
dec bl
jnz line18

mov al,1000b
mov bl,7
line19:         ;line2
int 10h
dec dx
inc cx
dec bl
jnz line19

mov al,1000b
mov bl,44
line20:         ;line2
int 10h
dec dx
dec bl
jnz line20 
              
              ;2 leg

mov cx,236
mov dx,23
mov al,1010b
mov bl,55         ;line4
line21:
int 10h
inc dx
dec bl
jnz line21

mov al,1000b
mov bl,7
line22:         ;line2
int 10h
inc dx
inc cx
dec bl
jnz line22

mov al,1000b
mov bl,7
line23:         ;line2
int 10h
dec dx
inc cx
dec bl
jnz line23

mov al,1000b
mov bl,66
line24:          
int 10h
dec dx
dec bl
jnz line24

              ;3 leg
mov cx,140
mov dx,110
mov al,1010b
mov bl,55         ;line4
line25:
int 10h
inc dx
dec bl
jnz line25

mov al,1000b
mov bl,7
line26:         ;line2
int 10h
inc dx
inc cx
dec bl
jnz line26

mov al,1000b
mov bl,7
line27:         ;line2
int 10h
dec dx
inc cx
dec bl
jnz line27

mov al,1000b
mov bl,62
line28:          
int 10h
dec dx
dec bl
jnz line28
           
                         ;4 leg
mov cx,75
mov dx,120
mov al,1010b
mov bl,45         ;line4
line29:
int 10h
inc dx
dec bl
jnz line29

mov al,1000b
mov bl,7
line30:         ;line2
int 10h
inc dx
inc cx
dec bl
jnz line30

mov al,1000b
mov bl,7
line31:         ;line2
int 10h
dec dx
inc cx
dec bl
jnz line31

mov al,1000b
mov bl,45
line32:          
int 10h
dec dx
dec bl
jnz line32
    
     ;2 Parallelogram
     
mov cx,130
mov dx,25
mov bl,75       ;line1
line5:
int 10h
inc cx
dec bl
jnz line5 

mov al,1000b
mov bl,75
line6:      ;line2
int 10h
inc dx
dec cx
dec bl
jnz line6

mov al,1011b
mov bl,75
line7:      ;line3
int 10h
dec cx
dec bl
jnz  line7

mov al,1010b
mov bl,75         ;line4
line8:
int 10h
dec dx
inc cx
dec bl
jnz line8

    ;3 Parallelogram
    
mov cx,140
mov dx,40
mov bl,40       ;line1
line9:
int 10h
inc cx
dec bl
jnz line9 

mov al,1000b
mov bl,50
line10:      ;line2
int 10h
inc dx
dec cx
dec bl
jnz line10

mov al,1011b
mov bl,40
line11:      ;line3
int 10h
dec cx
dec bl
jnz  line11

mov al,1010b
mov bl,50         ;line4
line12:
int 10h
dec dx
inc cx
dec bl
jnz line12

         ;4 Parallelogram

mov cx,145
mov dx,45
mov bl,20       ;line1
line13:
int 10h
inc cx
dec bl
jnz line13 

mov al,1000b
mov bl,30
line14:      ;line2
int 10h
inc dx
dec cx
dec bl
jnz line14

mov al,1011b
mov bl,20
line15:      ;line3
int 10h
dec cx
dec bl
jnz  line15

mov al,1010b
mov bl,30         ;line4
line16:
int 10h
dec dx
inc cx
dec bl
jnz line16