ASM=nasm
NASM_FLAGS := -f bin -o

PARTS := part1 part2 part3 
SRC_DIR := src
BUILD_DIR := build

PART1_SRC := part1/$(SRC_DIR)/boot.asm
PART2_SRC := part2/$(SRC_DIR)/boot.asm
PART3_SRC := part3/$(SRC_DIR)/boot.asm

PART1_BIN := part1/$(BUILD_DIR)/boot.bin
PART2_BIN := part2/$(BUILD_DIR)/boot.bin
PART3_BIN := part3/$(BUILD_DIR)/boot.bin




# all: $(BUILD_DIR)/main_floppy.img

# $(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/boot.bin
# 	cp $(BUILD_DIR)/boot.bin $(BUILD_DIR)/main_floppy.img
# 	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

# $(BUILD_DIR)/boot.bin: $(SRC_DIR)/boot.asm 
# 	$(ASM) $(SRC_DIR)/boot.asm -f bin -o $(BUILD_DIR)/boot.bin

all: $(PART1_BIN)

$(PART1_BIN) : $(PART1_SRC)
	$(ASM) $< $(NASM_FLAGS) $@

$(PART2_BIN) : $(PART2_SRC)
	$(ASM) $< $(NASM_FLAGS) $@

demo: $(BUILD_DIR)/demo.bin

$(BUILD_DIR)/demo.bin: $(SRC_DIR)/demo.asm 
	$(ASM) $(SRC_DIR)/demo.asm -f bin -o $(BUILD_DIR)/demo.bin
	



run:
	qemu-system-x86_64 -nographic $(BUILD_DIR)/boot.bin

runf: 
	qemu-system-x86_64 -nographic -fda $(BUILD_DIR)/main_floppy.img