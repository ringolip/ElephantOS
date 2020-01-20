; 主引导程序

; 初始化段寄存器
SECTION MBR vstart=0x7c00   ; 程序起始地址编译为0x7c00
mov ax, cs
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; 调用BIOS0x10号中断，0x06号功能，清屏

mov ah, 0x06    ; 向上滚屏
mov al, 0x00    ; 清屏
mov bx, 0x0700  ; 空白区域缺省属性
mov ch, 0x00    ; 窗口左上角位置，Y坐标
mov cl, 0x00    ; X坐标
mov dh, 0x18		; 窗口右下角位置，Y坐标
mov dl ,0x4f		; X坐标
int 0x10

; 获取光标位置, 功能0x13的参数
mov ah, 0x03    ; 调用0x03号功能
mov bh, 0x00    ; 页号
int 0x10


; 在光标处显示字符
mov ax, message
mov bp, ax      ; 字符串地址

mov ah, 0x13		; 功能号
mov bh, 0			  ; 页号
mov bl, 0x02    ; 字符属性
mov cx, [message_lenth]
mov al, 0x01    ; 光标随字符串移动

int 0x10

jmp $           ; 程序停留在此处

message db "MBR_1"
message_lenth db $-message

times 510-($-$$) db 0		; 填满mbr的其余空间
      db 0x55, 0xaa    ; mbr魔数
