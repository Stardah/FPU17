.model flat, c

.stack
.data
.code

public add_up
public deduct
public multiply
public divide
public compare

add_up proc \
    a : PTR DWORD, \
    b : PTR DWORD, \
    len : DWORD, \
    dst : PTR DWORD

    mov eax, a
    mov ebx, b
    mov ecx, len
    mov edi, dst
    do:
        movq mm1, [eax]
        movq mm2, [ebx]
        paddd mm2, mm1
        movq [edi], mm2
        add eax, 8
        add ebx, 8
        add edi, 8
    loop do
    mov eax, dst
    ret
add_up endp

deduct proc \
    a : PTR DWORD, \
    b : PTR DWORD, \
    len : DWORD, \
    dst : PTR DWORD

    mov eax, a
    mov ebx, b
    mov ecx, len
    mov edi, dst
    do:
        movq mm1, [eax]
        movq mm2, [ebx]
        psubd mm1, mm2
        movq [edi], mm1
        add eax, 8
        add ebx, 8
        add edi, 8
    loop do
    mov eax, dst
    ret
deduct endp

multiply proc \
    a : PTR DWORD, \
    len : DWORD, \
    n : QWORD, \
    dst : PTR DWORD

    mov eax, a
    mov ecx, len
    mov edi, dst
    do:
        movq mm1, [eax]
        pslld mm1, n
        movq [edi], mm1
        add eax, 8
        add edi, 8
    loop do
    ret
multiply endp

divide proc \
    a : PTR DWORD, \
    len : DWORD, \
    n : QWORD, \
    dst : PTR DWORD

    mov eax, a
    mov ecx, len
    mov edi, dst
    do:
        movq mm1, [eax]
        psrld mm1, n
        movq [edi], mm1
        add eax, 8
        add edi, 8
    loop do
    ret
divide endp

compare proc \
    a : PTR DWORD, \
    b : PTR DWORD, \
    len : DWORD

    local result : QWORD

    mov eax, a
    mov ebx, b
    mov ecx, len
	mov edx, 0
    do:
        movq mm1, [eax]
        movq mm2, [ebx]
        pcmpeqd mm1, mm2
        movq result, mm1
        mov edx, dword ptr [result]
        cmp edx, 0
        je false 
        mov edx, dword ptr [result+1]
        cmp edx, 0
        je false 
        add eax, 8
        add ebx, 8
    loop do

    mov eax, 1
    ret

    false:
    mov eax, 0
    ret
compare endp

end