

main:
mov ah, 0x0e
mov al, 'A'
int 0x10

mov ah, 0x0e
mov al, 65
int 0x10

mov ah, 0x0e
mov al, 0x41
int 0x10

mov ah, 0x0e
mov al, 0b1000001
int 0x10
times 510-($-$$) db 0
db 0x55, 0xaa