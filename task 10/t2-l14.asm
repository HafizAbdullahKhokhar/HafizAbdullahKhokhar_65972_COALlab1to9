mov al,13h
mov ah,0
int 10h

mov al,1010b
mov cx,100
mov dx,70
mov ah,0ch
int 10h  
mov bl,75       
line1:
int 10h
inc cx
dec bl
jnz line1

mov al,1100b
mov bl,50 
mov cx,100
mov dx,70
line2:
int 10h 
dec dx
dec bl 
jnz line2  
     
mov al,1000b
mov bl,75 
line3:
int 10h 
inc cx
dec bl 
jnz line3 

mov al,1010b
mov bl,50
line4:
int 10h 
inc dx
dec bl 
jnz line4   

mov al,1100b
mov bl,40 
mov cx,110
mov dx,70
line5:
int 10h 
dec dx
dec bl 
jnz line5  
     
mov al,1000b
mov bl,55 
line6:
int 10h 
inc cx
dec bl 
jnz line6

mov al,1010b
mov bl,40
line7:
int 10h 
inc dx
dec bl 
jnz line7   

mov al,1100b
mov bl,30 
mov cx,120
mov dx,70
line8:
int 10h 
dec dx
dec bl 
jnz line8
     
mov al,1000b
mov bl,35 
line9:
int 10h 
inc cx
dec bl 
jnz line9

mov al,1010b
mov bl,30
line10:
int 10h 
inc dx
dec bl 
jnz line10   


mov al,1100b
mov bl,20 
mov cx,130
mov dx,70
line11:
int 10h 
dec dx
dec bl 
jnz line11  
     
mov al,1000b
mov bl,15 
line12:
int 10h 
inc cx
dec bl 
jnz line12

mov al,1010b
mov bl,20
line13:
int 10h 
inc dx
dec bl 
jnz line13    


mov al,1010b
mov cx,100
mov dx,70
mov ah,0ch
int 10h  
mov bl,60       
line14:
int 10h 
dec cx 
inc dx
dec bl
jnz line14


mov al,1010b
mov cx,175
mov dx,70
mov ah,0ch
int 10h  
mov bl,60       
line15:
int 10h 
dec cx 
inc dx
dec bl
jnz line15


mov al,1010b
mov cx,40
mov dx,130
mov ah,0ch
int 10h  
mov bl,75       
line16:
int 10h 
inc cx 
dec bl
jnz line16   


mov al,1010b
mov cx,40
mov dx,130
mov ah,0ch
int 10h  
mov bl,40      
line17:
int 10h  
inc dx
dec bl
jnz line17 
  
mov al,1010b
mov bl,10      
line18:
int 10h  
inc cx
dec bl
jnz line18  


mov al,1010b
mov bl,40      
line19:
int 10h  
dec dx
dec bl
jnz line19


mov al,1010b
mov cx,115
mov dx,130
mov ah,0ch
int 10h  
mov bl,40      
line21:
int 10h  
inc dx
dec bl
jnz line21 
  
mov al,1010b
mov bl,10      
line22:
int 10h  
inc cx
dec bl
jnz line22  


mov al,1010b
mov bl,48      
line23:
int 10h  
dec dx
dec bl
jnz line23

                    
                    
mov al,1010b
mov cx,175
mov dx,70
mov ah,0ch
int 10h  
mov bl,50      
line24:
int 10h  
inc dx
dec bl
jnz line24 
  
mov al,1010b
mov bl,10      
line25:
int 10h  
dec cx
dec bl
jnz line25  


mov al,1010b
mov bl,40      
line26:
int 10h  
dec dx
dec bl
jnz line26