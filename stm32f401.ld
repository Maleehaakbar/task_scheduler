ENTRY(Reset_handler)

MEMORY 
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    SRAM(rwx)  : ORIGIN = 0x20000000 ,LENGTH = 64K
}

SECTIONS
{
    .text :
    {
        *(.isr_section)
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
        _etext = . ;
    } > FLASH

    _la_data = LOADADDR(.data);
    .data :
    {   _sdata = . ;
        *(.data)
        *(.data.*)
        . = ALIGN(4);
        _edata = . ;
    } > SRAM AT > FLASH

    .bss :
    {   _sbss = . ;
        __bss_start__ = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = . ;
        __bss_end__ = .;
        end = .;
    } >SRAM
}