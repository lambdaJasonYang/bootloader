org 0x7C00 ;this puts 0x7C at 00000024 if you open the bin
bits 16 ;BIOS boots the bootloader into 16 bit realmode

%define ENDL 0x0D, 0x0A

start:
    jmp main

puts:
    ;save register we will modify
    push si
    push ax
    push bx

.loop:
    lodsb ; loads a byte in the al register, then increments si
    or al, al 
    jz .done 
    

    mov ah, 0x0e
    mov bh, 0
    int 0x10

    jmp .loop 

.done:
    pop bx
    pop ax 
    pop si
    ret

main:
;;GoodToKnow: segment registers are  cs, ss, ds, es, fs, gs
;;cs = currently running code segment
;;ds = data segment
;;es,fs,gs = (extra) data segment
;;ss = stack segment

    ;setup data segment
    mov ax, 0
    mov ds, ax ;;segment register ds
    mov es, ax ;;segment register es

    ;setup stack segment
    mov ss, ax ;;segment register ss
    mov sp, 0x7C00 ;;pointer register sp

    ;print message
    mov si, msg_hello
    call puts

    hlt

msg_hello: db "hello World", ENDL, 0

;bootloader is the first 512 bytes and 
;the last 0x55 0xaa tells the BIOS it is the bootloader 
times 510-($-$$) db 0
db 0x55, 0xaa