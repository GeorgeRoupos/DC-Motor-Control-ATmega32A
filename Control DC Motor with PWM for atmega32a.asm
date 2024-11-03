; ATmega32A - Έλεγχος DC κινητήρα με PWM
.include "m32def.inc"

; Ορισμός Συχνοτήτων και Πιν
.equ F_CPU = 16000000           ; Συχνότητα ρολογιού στα 16 MHz
.equ DUTY_CYCLE = 128            ; Αρχικό Duty Cycle (50%) για τον έλεγχο της ταχύτητας

.org 0x00
rjmp RESET                       ; Αρχική τοποθεσία εκκίνησης

RESET:
    ldi r16, (1 << WGM00) | (1 << WGM01) | (1 << COM01) | (1 << CS01) ; Fast PWM, μη αντιστρέφουσα, προδιαιρετής 8
    out TCCR0, r16               ; Ρύθμιση Timer0 σε Fast PWM mode με προδιαιρετή 8

    ldi r16, DUTY_CYCLE          ; Ορισμός Duty Cycle στο 50%
    out OCR0, r16                ; Φόρτωση του Duty Cycle στο OCR0 (Output Compare Register 0)

    sbi DDRB, PB3                ; Ορισμός του PB3 (OC0) ως έξοδος

MAIN_LOOP:
    rjmp MAIN_LOOP               ; Ατέρμων βρόχος

; Υπορουτίνες για τον έλεγχο της ταχύτητας
SET_DUTY_CYCLE:
    ; Χρήση του register r16 για να ορίσεις το duty cycle
    out OCR0, r16                ; Ρύθμιση νέου Duty Cycle
    ret
