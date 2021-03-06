; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel -relocation-model=pic -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32_PIC

define i32 @mod4_0_to_11(i32 %a) {
; MIPS32-LABEL: mod4_0_to_11:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -32
; MIPS32-NEXT:    .cfi_def_cfa_offset 32
; MIPS32-NEXT:    ori $1, $zero, 7
; MIPS32-NEXT:    ori $2, $zero, 3
; MIPS32-NEXT:    ori $3, $zero, 2
; MIPS32-NEXT:    ori $5, $zero, 1
; MIPS32-NEXT:    ori $6, $zero, 0
; MIPS32-NEXT:    addiu $7, $zero, 65535
; MIPS32-NEXT:    ori $8, $zero, 0
; MIPS32-NEXT:    subu $8, $4, $8
; MIPS32-NEXT:    sltu $1, $1, $8
; MIPS32-NEXT:    and $1, $1, $5
; MIPS32-NEXT:    sw $4, 28($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $2, 24($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $3, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $6, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $7, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $8, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $1, $BB0_6
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_1: # %entry
; MIPS32-NEXT:    lui $1, %hi($JTI0_0)
; MIPS32-NEXT:    lw $2, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sll $3, $2, 2
; MIPS32-NEXT:    addu $1, $1, $3
; MIPS32-NEXT:    lw $1, %lo($JTI0_0)($1)
; MIPS32-NEXT:    jr $1
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_2: # %sw.bb
; MIPS32-NEXT:    lw $2, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_3: # %sw.bb1
; MIPS32-NEXT:    lw $2, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_4: # %sw.bb2
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_5: # %sw.bb3
; MIPS32-NEXT:    lw $2, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_6: # %sw.default
; MIPS32-NEXT:    .insn
; MIPS32-NEXT:  # %bb.7: # %sw.epilog
; MIPS32-NEXT:    ori $1, $zero, 8
; MIPS32-NEXT:    lw $2, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    subu $1, $2, $1
; MIPS32-NEXT:    lw $3, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sltu $4, $3, $1
; MIPS32-NEXT:    ori $5, $zero, 1
; MIPS32-NEXT:    and $4, $4, $5
; MIPS32-NEXT:    sw $1, 0($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $4, $BB0_13
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_8: # %sw.epilog
; MIPS32-NEXT:    lui $1, %hi($JTI0_1)
; MIPS32-NEXT:    lw $2, 0($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sll $3, $2, 2
; MIPS32-NEXT:    addu $1, $1, $3
; MIPS32-NEXT:    lw $1, %lo($JTI0_1)($1)
; MIPS32-NEXT:    jr $1
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_9: # %sw.bb4
; MIPS32-NEXT:    lw $2, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_10: # %sw.bb5
; MIPS32-NEXT:    lw $2, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_11: # %sw.bb6
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_12: # %sw.bb7
; MIPS32-NEXT:    lw $2, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_13: # %sw.default8
; MIPS32-NEXT:    lw $2, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 32
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32:       $JTI0_0:
; MIPS32-NEXT:   .4byte ($BB0_2)
; MIPS32-NEXT:   .4byte ($BB0_3)
; MIPS32-NEXT:   .4byte ($BB0_4)
; MIPS32-NEXT:   .4byte ($BB0_5)
; MIPS32-NEXT:   .4byte ($BB0_2)
; MIPS32-NEXT:   .4byte ($BB0_3)
; MIPS32-NEXT:   .4byte ($BB0_4)
; MIPS32-NEXT:   .4byte ($BB0_5)
; MIPS32-NEXT:   $JTI0_1:
; MIPS32-NEXT:   .4byte ($BB0_9)
; MIPS32-NEXT:   .4byte ($BB0_10)
; MIPS32-NEXT:   .4byte ($BB0_11)
; MIPS32-NEXT:   .4byte ($BB0_12)

;
; MIPS32_PIC-LABEL: mod4_0_to_11:
; MIPS32_PIC:       # %bb.0: # %entry
; MIPS32_PIC-NEXT:    lui $2, %hi(_gp_disp)
; MIPS32_PIC-NEXT:    addiu $2, $2, %lo(_gp_disp)
; MIPS32_PIC-NEXT:    addiu $sp, $sp, -40
; MIPS32_PIC-NEXT:    .cfi_def_cfa_offset 40
; MIPS32_PIC-NEXT:    addu $1, $2, $25
; MIPS32_PIC-NEXT:    ori $2, $zero, 7
; MIPS32_PIC-NEXT:    ori $3, $zero, 3
; MIPS32_PIC-NEXT:    ori $5, $zero, 2
; MIPS32_PIC-NEXT:    ori $6, $zero, 1
; MIPS32_PIC-NEXT:    ori $7, $zero, 0
; MIPS32_PIC-NEXT:    addiu $8, $zero, 65535
; MIPS32_PIC-NEXT:    ori $9, $zero, 0
; MIPS32_PIC-NEXT:    subu $9, $4, $9
; MIPS32_PIC-NEXT:    sltu $2, $2, $9
; MIPS32_PIC-NEXT:    and $2, $2, $6
; MIPS32_PIC-NEXT:    sw $1, 36($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $4, 32($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $3, 28($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $5, 24($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $6, 20($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $7, 16($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $8, 12($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    sw $9, 8($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    bnez $2, $BB0_6
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_1: # %entry
; MIPS32_PIC-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    lw $2, %got($JTI0_0)($1)
; MIPS32_PIC-NEXT:    lw $3, 8($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    sll $4, $3, 2
; MIPS32_PIC-NEXT:    addu $2, $2, $4
; MIPS32_PIC-NEXT:    lw $2, %lo($JTI0_0)($2)
; MIPS32_PIC-NEXT:    addu $2, $2, $1
; MIPS32_PIC-NEXT:    jr $2
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_2: # %sw.bb
; MIPS32_PIC-NEXT:    lw $2, 16($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_3: # %sw.bb1
; MIPS32_PIC-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_4: # %sw.bb2
; MIPS32_PIC-NEXT:    lw $2, 24($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_5: # %sw.bb3
; MIPS32_PIC-NEXT:    lw $2, 28($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_6: # %sw.default
; MIPS32_PIC-NEXT:    .insn
; MIPS32_PIC-NEXT:  # %bb.7: # %sw.epilog
; MIPS32_PIC-NEXT:    ori $1, $zero, 8
; MIPS32_PIC-NEXT:    lw $2, 32($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    subu $1, $2, $1
; MIPS32_PIC-NEXT:    lw $3, 28($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    sltu $4, $3, $1
; MIPS32_PIC-NEXT:    ori $5, $zero, 1
; MIPS32_PIC-NEXT:    and $4, $4, $5
; MIPS32_PIC-NEXT:    sw $1, 4($sp) # 4-byte Folded Spill
; MIPS32_PIC-NEXT:    bnez $4, $BB0_13
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_8: # %sw.epilog
; MIPS32_PIC-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    lw $2, %got($JTI0_1)($1)
; MIPS32_PIC-NEXT:    lw $3, 4($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    sll $4, $3, 2
; MIPS32_PIC-NEXT:    addu $2, $2, $4
; MIPS32_PIC-NEXT:    lw $2, %lo($JTI0_1)($2)
; MIPS32_PIC-NEXT:    addu $2, $2, $1
; MIPS32_PIC-NEXT:    jr $2
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_9: # %sw.bb4
; MIPS32_PIC-NEXT:    lw $2, 16($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_10: # %sw.bb5
; MIPS32_PIC-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_11: # %sw.bb6
; MIPS32_PIC-NEXT:    lw $2, 24($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_12: # %sw.bb7
; MIPS32_PIC-NEXT:    lw $2, 28($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC-NEXT:  $BB0_13: # %sw.default8
; MIPS32_PIC-NEXT:    lw $2, 12($sp) # 4-byte Folded Reload
; MIPS32_PIC-NEXT:    addiu $sp, $sp, 40
; MIPS32_PIC-NEXT:    jr $ra
; MIPS32_PIC-NEXT:    nop
; MIPS32_PIC:       $JTI0_0:
; MIPS32_PIC-NEXT:   .gpword ($BB0_2)
; MIPS32_PIC-NEXT:   .gpword ($BB0_3)
; MIPS32_PIC-NEXT:   .gpword ($BB0_4)
; MIPS32_PIC-NEXT:   .gpword ($BB0_5)
; MIPS32_PIC-NEXT:   .gpword ($BB0_2)
; MIPS32_PIC-NEXT:   .gpword ($BB0_3)
; MIPS32_PIC-NEXT:   .gpword ($BB0_4)
; MIPS32_PIC-NEXT:   .gpword ($BB0_5)
; MIPS32_PIC-NEXT:   $JTI0_1:
; MIPS32_PIC-NEXT:   .gpword ($BB0_9)
; MIPS32_PIC-NEXT:   .gpword ($BB0_10)
; MIPS32_PIC-NEXT:   .gpword ($BB0_11)
; MIPS32_PIC-NEXT:   .gpword ($BB0_12)

entry:
  switch i32 %a, label %sw.default [
    i32 0, label %sw.bb
    i32 4, label %sw.bb
    i32 1, label %sw.bb1
    i32 5, label %sw.bb1
    i32 2, label %sw.bb2
    i32 6, label %sw.bb2
    i32 3, label %sw.bb3
    i32 7, label %sw.bb3
  ]

sw.bb:                                            ; preds = %entry, %entry
  ret i32 0

sw.bb1:                                           ; preds = %entry, %entry
  ret i32 1

sw.bb2:                                           ; preds = %entry, %entry
  ret i32 2

sw.bb3:                                           ; preds = %entry, %entry
  ret i32 3

sw.default:                                       ; preds = %entry
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default
  switch i32 %a, label %sw.default8 [
    i32 8, label %sw.bb4
    i32 9, label %sw.bb5
    i32 10, label %sw.bb6
    i32 11, label %sw.bb7
  ]

sw.bb4:                                           ; preds = %sw.epilog
  ret i32 0

sw.bb5:                                           ; preds = %sw.epilog
  ret i32 1

sw.bb6:                                           ; preds = %sw.epilog
  ret i32 2

sw.bb7:                                           ; preds = %sw.epilog
  ret i32 3

sw.default8:                                      ; preds = %sw.epilog
  ret i32 -1

}
