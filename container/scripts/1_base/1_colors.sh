# Escape ANSI sequence for colors

_cb='\033[' # 'b'egin
_ce='m' # 'e'nd

#### Graphics Mode

_c_r='0'          # 'r'eset all modes (styles and colors)
_c_D='1';_c_rD='22' # set;reset bol'D'
_c_F='2';_c_rF='22' # set;reset 'F'aint
_c_I='3';_c_rI='23' # set;reset 'I'talic
_c_U='4';_c_UU='21';_c_rU='24' # set;double;reset 'U'nderline
_c_O='53';_c_rO='55' # set;double;reset 'O'verline
_c_l='5';_c_L='6';_c_rl='25' # set;;reset slowly b'l'inking or rapidly b'L'inking
_c_V='7';_c_rV='27' # set;reset In'V'ert foreground and background
_c_h='8';_c_rh='28' # set;reset 'h'idden
_c_k='9';_c_rk='29' # stri'k'ethrough

#### Text Color 

## standard
_c_f='3' # 'f'oreground
_c_b='4' # 'b'ackground
_c_Hf='9' # 'H'igh intensity
_c_Hb='10' # 'H'igh intensity 'b'ackground
# concat with standard color:
_c_K='0' # blac'K'
_c_R='1' # 'R'ed
_c_G='2' # 'G'reen
_c_Y='3' # 'Y'ellow
_c_B='4' # 'B'lue
_c_M='5' # 'M'agenta
_c_C='6' # 'C'yan
_c_W='7' # 'W'hite
_c_fd='39' # 'f'oreground 'd'efault
_c_bd='49' # 'b'ackground 'd'efault
_c_Ud='59' # 'U'nderline 'd'efault

## 256 color

_c_f256='38;5' # 'f'oreground '256' colors
_c_b256='48;5' # 'b'ackground '256' colors
_c_U256='58;5' # 'U'derline '256' color
# concat with ;id: 0-7 standard, 8-15 high, 16-231 BGR variations, 232-255 grey scale

## truecolor

_c_frgb='38;5' # 'f'oreground 'rgb' colors
_c_brgb='48;5' # 'b'ackground 'rgb' colors
_c_Urgb='48;5' # 'U'nderline 'rgb' colors
# concat with ;r;g;b values

# Colors used in this project

N="$_cb$_c_r$_ce" # Reset to 'N'ormal color and mode
NC="$_cb$_c_fd;$c_bd$_ce" # Reset to 'N'ormal color

B="$_cb$_c_D$_ce" # 'B'old
rB="$_cb$_c_rD$_ce" # 'B'old
U="$_cb$_c_U$_ce" # 'B'old
rU="$_cb$_c_rU$_ce" # 'B'old
I="$_cb$_c_I$_ce" # 'I'talic

EC="$_cb$_c_Hf$_c_R$_ce" # 'E'rror 'C'olor
SC="$_cb$_c_f$_c_B$_ce" # 'S'ource 'C'olor
OC="$_cb$_c_f$_c_G$_ce" # 'O'kay 'C'olor
CC="$_cb$_c_f$_c_Y$_ce" # 'C'ontainer 'C'olor
HC="$_cb$_c_I;$_c_f$_c_M$_ce" # 'H'ost 'C'olor
DC="$_cb$_c_Hf$_c_K$_ce" # 'D'ebug 'C'olor
