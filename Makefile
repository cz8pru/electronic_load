MAIN=main.c
SRC=system.c systemtimer.c strings.c flash.c uart.c displays.c button.c encoder.c encoderbutton.c beep.c fan.c load.c adc.c ringbuffer.c
RELS=$(SRC:.c=.rel)

all: bin

bin: $(MAIN) $(RELS)
	@mkdir -p bin
	sdcc  --opt-code-size -mstm8 -lstm8 $(MAIN) $(wildcard bin/*.rel) -o bin/

.c.rel:
	@mkdir -p bin
	sdcc -c  --opt-code-size -mstm8 -lstm8 $< -o bin/

clean:
	@rm -rf bin

flash: bin
	/home/dev/local/stm8flash/stm8flash -c stlinkv2 -p stm8s105k4 -w bin/main.ihx

.SUFFIXES: .c .rel

.PHONY: clean flash

