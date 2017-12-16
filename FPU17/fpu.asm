.model flat, c

.stack
.data
.code

public fn
public fe

;	float res = 0;
;	float p = 1;
;	float fac = 1;
;	float fcount = 0;
;	for (int i = 0; i < n; i++)
;	{
;		res += p / fac;
;		p *= x*x;
;		fac *= ++fcount;
;		fac *= ++fcount;
;	}

fn proc \
    x : DWORD, \
    n : DWORD

    finit
    fld1 ; just 1
    fldz ; fcount
    fld1 ; (x^2)^n, st0 = 1
    fld1 ; fac
    fldz ; for p/fac
    ; st-/0 = 
    ; st0/1 = res
    ; st1/2 = fac
    ; st2/3 = p
    ; st3/4 = fcount
    ; st4/5 = 1
    mov ecx, n
    calc:
        ; + (n+1)
        fld st(2) ; st0 = p
        fdiv st(0), st(2) ; p/fac
        fadd st(0), st(1) 
        fstp st(1)
        ; p*x^2
        fld st(2) ; st0 = p
        fmul x
        fmul x
        fstp st(3) ; st3 = p 
        ; fac * 2n * (2n-1)
        fld st(3) ; st0 = fcount
        fadd st(0), st(5) ; ++fcount
        fmul st(2), st(0) ; fac * fcount
        fadd st(0), st(5) ; ++fcount
        fmul st(2), st(0) ; fac * fcount
        fstp st(4) ; st4 = fcount
    loop calc

    ret
fn endp

fe proc \
    x : DWORD, \
    eps : DWORD

    finit
    fldz ; sn
    fld1 ; just 1
    fldz ; fcount
    fld1 ; (x^2)^n, st0 = 1
    fld1 ; fac
    fldz ; for p/fac
    ; st-/0 = 
    ; st0/1 = res
    ; st1/2 = fac
    ; st2/3 = p
    ; st3/4 = fcount
    ; st4/5 = 1
    ; st5/6 = Sn

    calc:
        ; вичисление очередного элемента ряда
        fld st(2) ; st0 = p
        fdiv st(0), st(2) ; p/fac

        ; st0 = Sn+1
        ; st2 = Sn
        fld st(6) ; st0 = Sn
        fsub st(0), st(1) ;   Sn - Sn+1
        fabs
        fcomp eps ; pop
        fstsw AX

        fst st(6) ; Sn = Sn+1
        fadd st(0), st(1) 
        
        test AX, 0100h
        jnz exit

        fstp st(1) ; pop

        ; p*x^2
        fld st(2) ; st0 = p
        fmul x
        fmul x
        fstp st(3) ; st3 = p
        ; fac * 2n * (2n-1)
        fld st(3) ; st0 = fcount
        fadd st(0), st(5) ; ++fcount
        fmul st(2), st(0) ; fac * fcount
        fadd st(0), st(5) ; ++fcount
        fmul st(2), st(0) ; fac * fcount
        fstp st(4) ; st4 = fcount
    jmp calc
    exit:

    ret
fe endp

end