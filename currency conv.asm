.model small
.stack 100h

.data
    msg1 db 10, 13, "Enter USD: $"
    msg2 db 10, 13, "BDT is: $"
    input db ?
    result dw ? 

.code
main proc
    mov ax, @data
    mov ds, ax

    ; enter a number
    mov ah, 09h
    lea dx, msg1
    int 21h

   
    mov ah, 01h
    int 21h
    sub al, 30h         
    mov input, al

    ; USD Conversion
    mov bl, input       
    mov ax, 85 ; input Conversion rate
    mul bl              

    ; Store the result
    mov result, ax     

    ; Display the result
    mov ah, 09h
    lea dx, msg2
    int 21h

   
    mov ax, result     
    call print_word    

    mov ah, 4Ch        
    int 21h

print_word proc
    push bx            
    mov bx, 10          
    mov cx, 0           
convert_loop:
    xor dx, dx          
    div bx              
    add dl, '0'         
    push dx             
    inc cx              
    test ax, ax         
    jnz convert_loop    
print_loop:
    pop dx              
    mov ah, 02h         
    int 21h             
    dec cx              
    jnz print_loop      
    pop bx              
    ret
print_word endp

end main
