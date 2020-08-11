	;; Program ex1.asm
	;; nasm -f elf32 ex1.asm -o ex1.o
	;; ld -m elf_i386 ex1.o -o ex1
	 
	
        global _start
        global main
        global write
        
        section .data
        p1 db 0x48, 0x65, 0x6c
        p2 db 0x6c, 0x6f, 0xa
	
        section .text

_start:
        call main
        mov ebx, eax            
        mov eax, 1              
        int 0x80                

main:
        push ebp                
        mov ebp, esp
        push 6                 
        push p1
        push 1
        call write
        add esp, 8
        mov eax, 0              
        mov esp, ebp            
        pop ebp
        ret                  

write:
        push ebp                
        mov ebp, esp
        mov ebx, [esp+8]                 
        mov ecx, [esp+12]                 
        mov edx, [esp+16]                 
        mov eax, 4              
        int 0x80                
        mov esp, ebp            
        pop ebp
        ret
