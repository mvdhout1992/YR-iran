[org 0x00B93000]

; variables and definitions
%include "src/def.asm"
%include "src/var.asm"
%include "src/data.inc"

; macro
%include "src/macros/INIclass_macros.asm"
%include "src/macros/spawner_macros.asm"

;%include "src/loading.asm"

; spawner
%include "src/spawner/spawner.asm"
%include "src/spawner/tunnel.asm"
%include "src/spawner/nethack.asm"
%include "src/spawner/selectable_countries.asm"
%include "src/spawner/selectable_handicaps.asm"
%include "src/spawner/selectable_colors.asm"
%include "src/spawner/selectable_spawns.asm"
%include "src/spawner/predetermined_alliances.asm"
%include "src/spawner/spectators.asm"

; misc
;%include "src/copy_protection.asm"
;%include "src/no-cd.asm"
;%include "src/graphics_patch.asm"

