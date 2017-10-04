What is the effect of the assembler directive .global? Why is the directive particularly important in this assignment? The teachers will help you with this if necessary.

Other files will be able to access functions.

Directives are commands that are part of the assembler syntax but are not related to the x86 processor instruction set. All assembler directives begin with a period (.)

.align – causes the next data generated to be aligned modulo integer bytes. Integer must be a positive integer expression and must be a power of 2. If specified, pad is an integer byte value used for padding. The default value of pad for the Text section is 0x90 (nop); for other sections the default value of pad is zerio.
.ascii – The asci directive places the character in string into the object module at the current location but does not terminate the string with a null byte (\0). String mus be enclosed in double quotes (“). The asci directive is not valid for the .bss section
.bcd –  The bcd directive generates a packed decimal (80-bit) value into the current section .The bcd directive is not valid for the .bss section.
.bss  – The bss directive changes the current section to .bss
.bss  –  Define symbol in the bss section an add integer bytes to the value of the location counter for bss. When issued with arguments, the bss directive does not change the current section to bss integer must be positive.
 .byte –The byte directive generates initialized byte sinto the current section. The byte directo is not valid for the bss section. Each byte must be an 8-bit value.
4byte – long
.global –  global makes the symbol visivle to ld. If you define symbol in your partial program. Its value sis made available to other partial programs that are linked with it. Otherwise, symbol takes its attributes from a symbol of the same name from another file linked into the same program.
