

***********************************
* Design Parameter
***********************************
.param wp=0.5u
.param wn=0.5u

***********************************
* smallest circuit
***********************************
.subckt triINV IN CLK OUT
X1 CLK NCLK not
mp1 1 IN VDD VDD P_18_G2 l=0.18u w=wp
mp2 OUT NCLK 1 VDD P_18_G2 l=0.18u w=wp
mn1 OUT CLK 2 GND N_18_G2 l=0.18u w=wn
mn2 2 IN GND GND N_18_G2 l=0.18u w=wn
.ends

.subckt DFF CLK D  Q 
X1 CLK NCLK not
X11 D 1 not
mp1 2 CLK 1 VDD P_18_G2 l=0.18u w=wp
mn1 1 NCLK 2 GND N_18_G2 l=0.18u w=wn
X12 2 3 not
*X13 3 CLK 2 triINV
X13 3 NCLK CLK 2 tri
mn2 3 CLK 4 GND N_18_G2 l=0.18u w=wn
mp2 4 NCLK 3 VDD P_18_G2 l=0.18u w=wp
*X14 4 NQ not
X15 4 5 not
*X16 5 NCLK 4 triINV
X16 5 CLK NCLK 4 tri
X17 5 Q not
.ends


*dff
*.subckt dff clk d q 
*xinvclk clk nclk not 

*xtrans1 d x clk nclk tran
*xinv2   x 2 not_strong
** xinv4   2 x not
*xtri1   2 nclk clk x tri

*xtrans2 2 3 nclk clk tran
*xinv3   3 q not_strong
** xinv5   q 3 not
*xtri2   q clk nclk 3 tri
*.ends


**MUX
*.subckt MUX A B SEL Y
*xinv1 SEL nSEL not
*mp1 A SEL  Y P_18_G2 l=0.18u w=wp
*mp2 B nSEL Y P_18_G2 l=0.18u w=wp
*
*mn1 Y nSEL A N_18_G2 l=0.18u w=wn
*mn2 B SEL  Y N_18_G2 l=0.18u w=wn
*.ends

.subckt MUX A B SEL Y
xinv1 SEL NSEL not
X1 A NSEL 1 nand2
X2 B SEL 2 nand2
X3 1 2 Y nand2
.ends

*FA
.subckt FA a b c sum cout
mp1 1     a     vdd   vdd P_18_G2 l=0.18u w=wp 
mp2 ncout b     1     vdd P_18_G2 l=0.18u w=wp
mn1 ncout b     2     gnd N_18_G2 l=0.18u w=wn
mn2 2     a     gnd   gnd N_18_G2 l=0.18u w=wn 

mp3 3     a     vdd   vdd P_18_G2 l=0.18u w=8*wp 
mp4 3     b     vdd   vdd P_18_G2 l=0.18u w=8*wp
mp5 ncout c     3     vdd P_18_G2 l=0.18u w=8*wp
mn3 ncout c     4     gnd N_18_G2 l=0.18u w=4*wn
mn4 4     a     gnd   gnd N_18_G2 l=0.18u w=4*wn 
mn5 4     b     gnd   gnd N_18_G2 l=0.18u w=4*wn

mp6 5     c     vdd   vdd P_18_G2 l=0.18u w=wp 
mp7 5     a     vdd   vdd P_18_G2 l=0.18u w=wp
mp8 5     b     vdd   vdd P_18_G2 l=0.18u w=wp
mp9 nsum  ncout 5     vdd P_18_G2 l=0.18u w=wp
mn6 nsum  ncout 6     gnd N_18_G2 l=0.18u w=wn
mn7 6     c     gnd   gnd N_18_G2 l=0.18u w=wn 
mn8 6     a     gnd   gnd N_18_G2 l=0.18u w=wn
mn9 6     b     gnd   gnd N_18_G2 l=0.18u w=wn

mp10 7    a     vdd   vdd P_18_G2 l=0.18u w=wp 
mp11 8    b     7     vdd P_18_G2 l=0.18u w=wp
mp12 nsum c     8     vdd P_18_G2 l=0.18u w=wp
mn10 nsum c     9     gnd N_18_G2 l=0.18u w=wn 
mn11 9    b     10    gnd N_18_G2 l=0.18u w=wn
mn12 10   a     gnd   gnd N_18_G2 l=0.18u w=wn

mp13 sum nsum VDD VDD P_18_G2 l=0.18u w=wp
mn13 sum nsum GND GND N_18_G2 l=0.18u w=wn

mp14 cout ncout VDD VDD P_18_G2 l=0.18u w=wp 
mn14 cout ncout GND GND N_18_G2 l=0.18u w=wn
.ends


*subFA
*.subckt FA A B CIN SUM COUT
*M    D    G    S    B
*MP1   2    A   VDD  VDD  P_18_G2 l=0.18u w=WP
*MP2 NCOUT  B    2   VDD  P_18_G2 l=0.18u w= WP
*MP3   5    A   VDD  VDD  P_18_G2 l=0.18u w='8*WP'
*MP4   5    B   VDD  VDD  P_18_G2 l=0.18u w='8*WP'
*MP5 NCOUT CIN   5   VDD  P_18_G2 l=0.18u w='8*WP'
*MP6   7    A   VDD  VDD  P_18_G2 l=0.18u w=WP
*MP7   7    B   VDD  VDD  P_18_G2 l=0.18u w=WP
*MP8   7   CIN  VDD  VDD  P_18_G2 l=0.18u w=WP
*MP9  NSUM NCOUT  7   VDD  P_18_G2 l=0.18u w=WP
*MP10  10   A   VDD  VDD  P_18_G2 l=0.18u w=WP
*MP11  11   B    10  VDD  P_18_G2 l=0.18u w=WP
*MP12 NSUM CIN   11  VDD  P_18_G2 l=0.18u w=WP
*M    D    G    S    B
*MN1   4    A   GND  GND  N_18_G2 l=0.18u w=WN
*MN2 NCOUT  B    4   GND  N_18_G2 l=0.18u w=WN
*MN3   6    A   GND  GND  N_18_G2 l=0.18u w='4*WN'
*MN4   6    B   GND  GND  N_18_G2 l=0.18u w='4*WN'
*MN5 NCOUT CIN   6   GND  N_18_G2 l=0.18u w='4*WN'
*MN6   9    A   GND  GND  N_18_G2 l=0.18u w=WN
*MN7   9    B   GND  GND  N_18_G2 l=0.18u w=WN
*MN8   9   CIN  GND  GND  N_18_G2 l=0.18u w=WN
*MN9  NSUM NCOUT  9   GND  N_18_G2 l=0.18u w=WN
*MN10  13   A   GND  GND  N_18_G2 l=0.18u w=WN
*MN11  12   B   13   GND  N_18_G2 l=0.18u w=WN
*MN12 NSUM CIN  12   GND  N_18_G2 l=0.18u w=WN
*x1 NSUM SUM NOT
*X2 NCOUT COUT NOT
*.ends

*HA
.subckt HA a b sum cout
xxor a b sum  xor2
xand a b cout and2
.ends

*not_strong    
.subckt not_strong in out
mp1 out in vdd vdd P_18_G2 l=0.18u w=1.5*wp
mn1 out in gnd gnd N_18_G2 l=0.18u w=1.5*wn
.ends

*strong
.subckt not in out
mp1 out in vdd vdd P_18_G2 l=0.18u w=wp
mn1 out in gnd gnd N_18_G2 l=0.18u w=wn
.ends

*nand2
.subckt nand2 A B OUT
mp1 OUT A VDD VDD P_18_G2 l=0.18u w=wp
mp2 OUT B VDD VDD P_18_G2 l=0.18u w=wp
mn1 OUT B 1   GND N_18_G2 l=0.18u w=wn
mn2 1   A GND GND N_18_G2 l=0.18u w=wn
.ends

*nand3
.subckt nand3 a b c out
mp1 out a vdd vdd P_18_G2 l=0.18u w=wp 
mp2 out b vdd vdd P_18_G2 l=0.18u w=wp
mp3 out c vdd vdd P_18_G2 l=0.18u w=wp

mn1 out c 1   gnd N_18_G2 l=0.18u w=wn 
mn2 1   b 2   gnd N_18_G2 l=0.18u w=wn
mn3 2   a gnd gnd N_18_G2 l=0.18u w=wn
.ends

*nand4
.subckt nand4 a b c d out
mp1 out a vdd vdd P_18_G2 l=0.18u w=wp 
mp2 out b vdd vdd P_18_G2 l=0.18u w=wp
mp3 out c vdd vdd P_18_G2 l=0.18u w=wp
mp4 out d vdd vdd P_18_G2 l=0.18u w=wp

mn1 out d 1   gnd N_18_G2 l=0.18u w=wn 
mn2 1   c 2   gnd N_18_G2 l=0.18u w=wn
mn3 2   b 3   gnd N_18_G2 l=0.18u w=wn
mn4 3   a gnd gnd N_18_G2 l=0.18u w=wn
.ends


*xor2
.subckt xor2 A B OUT
mp1 1 A VDD VDD P_18_G2 l=0.18u w=wp  
mn1 1 A GND GND N_18_G2 l=0.18u w=wn

mp2 OUT B A VDD P_18_G2 l=0.18u w=wp
mn2 OUT B 1 GND N_18_G2 l=0.18u w=wn

mp3 OUT A B   VDD P_18_G2 l=0.18u w=wp
mn3 B   1 OUT GND N_18_G2 l=0.18u w=wn
.ends


*xor3
.subckt xor3 a b c out
xnot1  c c_n not
xtran1 x b c c_n   tran

mp1 x b c   vdd P_18_G2 l=0.18u w=wp
mn1 x b c_n gnd N_18_G2 l=0.18u w=wn    

xnot2  x   x_n not 
xtran2 out a x  x_n  tran

mp2 out a x   vdd P_18_G2 l=0.18u w=wp
mn2 out a x_n gnd N_18_G2 l=0.18u w=wn    
.ends 

*xor3
*.subckt xor3 a b c out
* D G S B
*MP1 1 A VDD VDD P_18_G2 l=0.18u w=wp
*X1 A NA NOT
*MP2 6 NA VDD VDD P_18_G2 l=0.18u w=wp
*MP3 2 B 1 VDD  P_18_G2 l=0.18u w=wp
*X2 B NB NOT
*MP4 2 NB 6 VDD  P_18_G2 l=0.18u w=wp
*X3 C NC NOT
*MP5 OUT NC 2 VDD  P_18_G2 l=0.18u w=wp
*MP6 7 A VDD VDD P_18_G2 l=0.18u w=wp
*MP7 8 NA VDD VDD P_18_G2 l=0.18u w=wp
*MP8 9 NB 7 VDD P_18_G2 l=0.18u w=wp
*MP9 9 B 8 VDD P_18_G2 l=0.18u w=wp
*MP10 OUT C 9 VDD P_18_G2 l=0.18u w=wp

*MN11 OUT NA 3 GND N_18_G2 l=0.18u w=wn   
*MN12 3 B 5 GND N_18_G2 l=0.18u w=wn   
*MN13 3 NB 4 GND N_18_G2 l=0.18u w=wn   
*MN14 5 C GND GND N_18_G2 l=0.18u w=wn   
*MN15 4 NC GND GND N_18_G2 l=0.18u w=wn   

*MN16 OUT A 10 GND N_18_G2 l=0.18u w=wn   
*MN17 10 B 11 GND N_18_G2 l=0.18u w=wn   
*MN18 10 NB 12 GND N_18_G2 l=0.18u w=wn   
*MN19 11 NC GND GND N_18_G2 l=0.18u w=wn   
*MN20 12 C GND GND N_18_G2 l=0.18u w=wn   
*.ends








*or2
.subckt or2 a b out
xor  a b out_n nor2
xinv out_n out not
.ends
*nor2
.subckt nor2 a b out 
mp1 1   a vdd vdd P_18_G2 l=0.18u w=wp 
mp2 out b 1   vdd P_18_G2 l=0.18u w=wp 
                                      
mn1 out b gnd gnd N_18_G2 l=0.18u w=wn
mn2 out a gnd gnd N_18_G2 l=0.18u w=wn
.ends
*and2
.subckt and2 a b out
xnand a b   out_n nand2
xinv  out_n out   not
.ends
*and4
.subckt and4 a b c d out
xnand a b c d out_n nand4
xinv  out_n out not
.ends

*buf
.subckt buf in out
xinv1 in 1   not 
xinv2 1  out not 
.ends

*transmission gate
.subckt tran in out p n  
mp1 in p out vdd P_18_G2 l=0.18u w=wp
mn1 in n out gnd N_18_G2 l=0.18u w=wn
.ends

*tristate
.subckt tri in p n out
mp1 1   in vdd vdd P_18_G2 l=0.18u w=wp 
mp2 out p  1   vdd P_18_G2 l=0.18u w=wp
mn1 out n  2   gnd N_18_G2 l=0.18u w=wn
mn2 2   in gnd gnd N_18_G2 l=0.18u w=wn 
.ends

*************************************
*************************************
            *midium subckt
*************************************
*************************************
*xfa a b c sum_fa cout_fa FA
*xha a b sum_ha cout_ha HA
*xmux a b c mux_out mux
*xnand2 a b nand2_out nand2
*xnand3 a b c nand3_out nand3
*xnand4 a b c d nand4_out nand4
*xxor2  a b xor2_out xor2
*xxor3  a b c xor3_out xor3
*xor2   a b or2_out or2
*xand2  a b and2_out and2
*xand3  a b c and3_out and3

*Wallace Tree 1
.subckt W_T1
+ PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
+ PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
+ PP3[4] PP3[5] PP3[6] PP3[7] PP3[8] PP3[9] PP3[10] PP3[11] PP3[12]  
+ SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
+ COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
XHA1 PP1[2] PP2[2] SUM[2] COUT[3] HA
XHA2 PP1[3] PP2[3] SUM[3] COUT[4] HA

*xfa a b c sum_fa cout_fa FA
XFA1 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA
XFA2 PP1[5] PP2[5] PP3[5] SUM[5] COUT[6] FA
XFA3 PP1[6] PP2[6] PP3[6] SUM[6] COUT[7] FA
XFA4 PP1[7] PP2[7] PP3[7] SUM[7] COUT[8] FA
XFA5 PP1[8] PP2[8] PP3[8] SUM[8] COUT[9] FA
XFA6 PP1[9] PP2[9] PP3[9] SUM[9] COUT[10] FA
XFA7 PP1[10] PP2[10] PP3[10] SUM[10] COUT[11] FA
XFA8 PP1[11] PP2[11] PP3[11] SUM[11] COUT[12] FA

*xxor3  a b c xor3_out xor3
XXOR3_1 PP1[12] PP2[12] PP3[12] SUM[12] xor3

*COUT[0] COUT[1] COUT[2] to GND
*PP1[0]=SUM[0] PP1[1]=SUM[1]
.ends

*Wallace Tree 1
*.subckt W_T1
*+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
*+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
*+ PP3[0] PP3[1] PP3[2] PP3[3] PP3[4] PP3[5] PP3[6] PP3[7] PP3[8] PP3[9] PP3[10] PP3[11] PP3[12]  
*+ SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
*+ COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
*XHA1 PP1[2] PP2[2] SUM[2] COUT[3] HA
*XHA2 PP1[3] PP2[3] SUM[3] COUT[4] HA

*xfa a b c sum_fa cout_fa FA
*XFA1 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA
*XFA2 PP1[5] PP2[5] PP3[5] SUM[5] COUT[6] FA
*XFA3 PP1[6] PP2[6] PP3[6] SUM[6] COUT[7] FA
*XFA4 PP1[7] PP2[7] PP3[7] SUM[7] COUT[8] FA
*XFA5 PP1[8] PP2[8] PP3[8] SUM[8] COUT[9] FA
*XFA6 PP1[9] PP2[9] PP3[9] SUM[9] COUT[10] FA
*XFA7 PP1[10] PP2[10] PP3[10] SUM[10] COUT[11] FA
*XFA8 PP1[11] PP2[11] PP3[11] SUM[11] COUT[12] FA

*xxor3  a b c xor3_out xor3
*XXOR3_1 PP1[12] PP2[12] PP3[12] SUM[12] xor3

*COUT[0] COUT[1] COUT[2] to GND
*PP1[0]=SUM[0] PP1[1]=SUM[1]
*.ends


*Wallace Tree 2
*.subckt W_T2
*+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
*+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
*+ PP3[0] PP3[1] PP3[2] PP3[3] PP3[4] PP3[5] PP3[6] PP3[7] PP3[8] PP3[9] PP3[10] PP3[11] PP3[12]  
*+ SUM[0] SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
*+ COUT[1] COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
*XHA1 PP1[0] PP3[0] SUM[0] COUT[1] HA
*XHA2 PP1[2] PP3[2] SUM[2] COUT[3] HA
*XHA3 PP1[3] PP2[3] SUM[3] COUT[4] HA

*xfa a b c sum_fa cout_fa FA
*XFA1 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA

*xha a b sum_ha cout_ha HA
*XHA4 PP1[5] PP2[5] SUM[5] COUT[6] HA
*XHA5 PP1[6] PP2[6] SUM[6] COUT[7] HA
*XHA6 PP1[7] PP2[7] SUM[7] COUT[8] HA
*XHA7 PP1[8] PP2[8] SUM[8] COUT[9] HA
*XHA8 PP1[9] PP2[9] SUM[9] COUT[10] HA
*XHA9 PP1[10] PP2[10] SUM[10] COUT[11] HA
*XHA10 PP1[11] PP2[11] SUM[11] COUT[12] HA

*xxor2  a b xor2_out xor2
*XXOR_1  PP1[12] PP2[12] SUM[12] xor2

*pp1[1]=sum[1]
*PP2[0] PP2[1] PP2[2] to GND
*COUT[0] COUT[2] to GND
*.ends

*Wallace Tree 2
.subckt W_T2
+ PP1[0] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
+ PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
+ PP3[0] PP3[2]  PP3[4]
+ SUM[0] SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
+ COUT[1] COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
XHA1 PP1[0] PP3[0] SUM[0] COUT[1] HA
XHA2 PP1[2] PP3[2] SUM[2] COUT[3] HA
XHA3 PP1[3] PP2[3] SUM[3] COUT[4] HA

*xfa a b c sum_fa cout_fa FA
XFA1 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA

*xha a b sum_ha cout_ha HA
XHA4 PP1[5] PP2[5] SUM[5] COUT[6] HA
XHA5 PP1[6] PP2[6] SUM[6] COUT[7] HA
XHA6 PP1[7] PP2[7] SUM[7] COUT[8] HA
XHA7 PP1[8] PP2[8] SUM[8] COUT[9] HA
XHA8 PP1[9] PP2[9] SUM[9] COUT[10] HA
XHA9 PP1[10] PP2[10] SUM[10] COUT[11] HA
XHA10 PP1[11] PP2[11] SUM[11] COUT[12] HA

*xxor2  a b xor2_out xor2
XXOR_1  PP1[12] PP2[12] SUM[12] xor2

*pp1[1]=sum[1]
*PP2[0] PP2[1] PP2[2] to GND
*COUT[0] COUT[2] to GND
.ends



*Wallace Tree 3
*.subckt W_T3
*+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
*+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
*+ PP3[0] PP3[1] PP3[2] PP3[3] PP3[4] PP3[5] PP3[6] PP3[7] PP3[8] PP3[9] PP3[10] PP3[11] PP3[12]  
*+ SUM[0] SUM[1] SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
*+ COUT[1] COUT[2] COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
*XHA1 PP1[0] PP3[0] SUM[0] COUT[1] HA 

*xfa a b c sum_fa cout_fa FA
*XFA1 PP1[1] PP2[1] PP3[1] SUM[1] COUT[2] FA

*xha a b sum_ha cout_ha HA
*XHA2 PP1[2] PP3[2] SUM[2] COUT[3] HA

*xfa a b c sum_fa cout_fa FA
*XFA2 PP1[3] PP2[3] PP3[3] SUM[3] COUT[4] FA
*XFA3 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA
*XFA4 PP1[5] PP2[5] PP3[5] SUM[5] COUT[6] FA
*XFA5 PP1[6] PP2[6] PP3[6] SUM[6] COUT[7] FA
*XFA6 PP1[7] PP2[7] PP3[7] SUM[7] COUT[8] FA
*XFA7 PP1[8] PP2[8] PP3[8] SUM[8] COUT[9] FA
*XFA8 PP1[9] PP2[9] PP3[9] SUM[9] COUT[10] FA
*XFA9 PP1[10] PP2[10] PP3[10] SUM[10] COUT[11] FA
*XFA10 PP1[11] PP2[11] PP3[11] SUM[11] COUT[12] FA

*xxor3  a b c xor3_out xor3
*XXOR3_1 PP1[12] PP2[12] PP3[12] SUM[12] xor3

*COUT[0] to GND
*PP2[0] PP2[2] to GND
*.ends

*Wallace Tree 3
.subckt W_T3
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6] PP1[7] PP1[8] PP1[9] PP1[10] PP1[11] PP1[12]
+  PP2[1] PP2[3] PP2[4] PP2[5] PP2[6] PP2[7] PP2[8] PP2[9] PP2[10] PP2[11] PP2[12] 
+ PP3[0] PP3[1] PP3[2] PP3[3] PP3[4] PP3[5] PP3[6] PP3[7] PP3[8] PP3[9] PP3[10] PP3[11] PP3[12]  
+ SUM[0] SUM[1] SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12] 
+ COUT[1] COUT[2] COUT[3] COUT[4] COUT[5] COUT[6] COUT[7] COUT[8] COUT[9] COUT[10] COUT[11] COUT[12] 

*xha a b sum_ha cout_ha HA
XHA1 PP1[0] PP3[0] SUM[0] COUT[1] HA 

*xfa a b c sum_fa cout_fa FA
XFA1 PP1[1] PP2[1] PP3[1] SUM[1] COUT[2] FA

*xha a b sum_ha cout_ha HA
XHA2 PP1[2] PP3[2] SUM[2] COUT[3] HA

*xfa a b c sum_fa cout_fa FA
XFA2 PP1[3] PP2[3] PP3[3] SUM[3] COUT[4] FA
XFA3 PP1[4] PP2[4] PP3[4] SUM[4] COUT[5] FA
XFA4 PP1[5] PP2[5] PP3[5] SUM[5] COUT[6] FA
XFA5 PP1[6] PP2[6] PP3[6] SUM[6] COUT[7] FA
XFA6 PP1[7] PP2[7] PP3[7] SUM[7] COUT[8] FA
XFA7 PP1[8] PP2[8] PP3[8] SUM[8] COUT[9] FA
XFA8 PP1[9] PP2[9] PP3[9] SUM[9] COUT[10] FA
XFA9 PP1[10] PP2[10] PP3[10] SUM[10] COUT[11] FA
XFA10 PP1[11] PP2[11] PP3[11] SUM[11] COUT[12] FA

*xxor3  a b c xor3_out xor3
XXOR3_1 PP1[12] PP2[12] PP3[12] SUM[12] xor3

*COUT[0] to GND
*PP2[0] PP2[2] to GND
.ends


*FOR_PG_12
.subckt FOR_PG_12
+ A[0] A[1] A[2] A[3] A[4] A[5] A[6] A[7] A[8] A[9] A[10] A[11] 
+ B[0] B[1] B[2] B[3] B[4] B[5] B[6] B[7] B[8] B[9] B[10] B[11] 
+ P[0] P[1] P[2] P[3] P[4] P[5] P[6] P[7] P[8] P[9] P[10] P[11]   
+ G[0] G[1] G[2] G[3] G[4] G[5] G[6] G[7] G[8] G[9] G[10] G[11]  

*Propagate P
*xor2   a b or2_out or2
X_OR2_1 A[0] B[0] P[0] or2
X_OR2_2 A[1] B[1] P[1] or2
X_OR2_3 A[2] B[2] P[2] or2
X_OR2_4 A[3] B[3] P[3] or2
X_OR2_5 A[4] B[4] P[4] or2
X_OR2_6 A[5] B[5] P[5] or2
X_OR2_7 A[6] B[6] P[6] or2
X_OR2_8 A[7] B[7] P[7] or2
X_OR2_9 A[8] B[8] P[8] or2
X_OR2_10 A[9] B[9] P[9] or2
X_OR2_11 A[10] B[10] P[10] or2
X_OR2_12 A[11] B[11] P[11] or2

*Generate G
*xand2  a b and2_out and2
XAND2_1 A[0] B[0] G[0] and2
XAND2_2 A[1] B[1] G[1] and2
XAND2_3 A[2] B[2] G[2] and2
XAND2_4 A[3] B[3] G[3] and2
XAND2_5 A[4] B[4] G[4] and2
XAND2_6 A[5] B[5] G[5] and2
XAND2_7 A[6] B[6] G[6] and2
XAND2_8 A[7] B[7] G[7] and2
XAND2_9 A[8] B[8] G[8] and2
XAND2_10 A[9] B[9] G[9] and2
XAND2_11 A[10] B[10] G[10] and2
XAND2_12 A[11] B[11] G[11] and2
.ends


*COMP1_13
.subckt COMP1_13
+ IN[0] IN[1] IN[2] IN[3] IN[4] IN[5] IN[6] IN[7] IN[8] IN[9] IN[10] IN[11] 
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] OUT[7] OUT[8] OUT[9] OUT[10] OUT[11]  

*.subckt not in out
XNOT1 IN[0] OUT[0] not
XNOT2 IN[1] OUT[1] not
XNOT3 IN[2] OUT[2] not
XNOT4 IN[3] OUT[3] not
XNOT5 IN[4] OUT[4] not
XNOT6 IN[5] OUT[5] not
XNOT7 IN[6] OUT[6] not
XNOT8 IN[7] OUT[7] not
XNOT9 IN[8] OUT[8] not
XNOT10 IN[9] OUT[9] not
XNOT11 IN[10] OUT[10] not
XNOT12 IN[11] OUT[11] not

.ends

*XOR_13
.subckt XOR_13
+ X[0] X[1] X[2] X[3] X[4] X[5] X[6] X[7] X[8] X[9] X[10] X[11] X[12]
+ Y[0] Y[1] Y[2] Y[3] Y[4] Y[5] Y[6] Y[7] Y[8] Y[9] Y[10] Y[11] Y[12]
+ CIN[0] CIN[1] CIN[2] CIN[3] CIN[4] CIN[5] CIN[6] CIN[7] CIN[8] CIN[9] CIN[10] CIN[11] CIN[12]
+ SUM[0] SUM[1] SUM[2] SUM[3] SUM[4] SUM[5] SUM[6] SUM[7] SUM[8] SUM[9] SUM[10] SUM[11] SUM[12]

*xxor3  a b c xor3_out xor3
XXOR3_1 X[0] Y[0] CIN[0] SUM[0] xor3
XXOR3_2 X[1] Y[1] CIN[1] SUM[1] xor3
XXOR3_3 X[2] Y[2] CIN[2] SUM[2] xor3
XXOR3_4 X[3] Y[3] CIN[3] SUM[3] xor3
XXOR3_5 X[4] Y[4] CIN[4] SUM[4] xor3
XXOR3_6 X[5] Y[5] CIN[5] SUM[5] xor3
XXOR3_7 X[6] Y[6] CIN[6] SUM[6] xor3
XXOR3_8 X[7] Y[7] CIN[7] SUM[7] xor3
XXOR3_9 X[8] Y[8] CIN[8] SUM[8] xor3
XXOR3_10 X[9] Y[9] CIN[9] SUM[9] xor3
XXOR3_11 X[10] Y[10] CIN[10] SUM[10] xor3
XXOR3_12 X[11] Y[11] CIN[11] SUM[11] xor3
XXOR3_13 X[12] Y[12] CIN[12] SUM[12] xor3
.ends

.subckt Booth_En x0 x1 x2 yi[5] yi[4] yi[3] yi[2] yi[1] yi[0] yo[6] yo[5] yo[4] yo[3] yo[2] yo[1] yo[0]
XNOT1 x0 nw0 not
XNOT2 x1 nw1 not
XNOT3 x2 nw2 not

XXOR21 x0 x1 nw3 xor2
XNAND31 x0 x1 nw2 nw4 nand3
XNAND32 nw0 nw1 x2 nw5 nand3
XNAND21 nw4 nw5 nw6 nand2

XB1 yi[0] GND nw3 nw6 x2 yo[0] Booth_Se
XB2 yi[1] yi[0] nw3 nw6 x2 yo[1] Booth_Se
XB3 yi[2] yi[1] nw3 nw6 x2 yo[2] Booth_Se
XB4 yi[3] yi[2] nw3 nw6 x2 yo[3] Booth_Se
XB5 yi[4] yi[3] nw3 nw6 x2 yo[4] Booth_Se
XB6 yi[5] yi[4] nw3 nw6 x2 yo[5] Booth_Se
XB7 yi[5] yi[5] nw3 nw6 x2 yo[6] Booth_Se
.ends

.subckt Booth_Se y1 y2 ws wd wn pp
X1 y1 ws nw1 nand2
X2 y2 wd nw2 nand2
X3 nw1 nw2 nw3 nand2
X4 nw3 wn pp xor2
.ends

.subckt CLA_4unit P1 G1 P2 G2 P3 G3 P4 G4 C_1 C1 C2 C3 C4 BP BG
X1 C_1 P1 nw1 nand2
X2 G1 nw2 not
X3 C_1 P1 P2 nw3 nand3
X4 G1 P2 nw4 nand2
X5 G2 nw5 not 
X6 C_1 P1 P2 P3 nw6 nand4
X7 G1 P2 P3 nw7 nand3
X8 G2 P3 nw8 nand2
X9 G3 nw9 not
X10 G1 P2 P3 P4 nw10 nand4
X11 G2 P3 P4 nw11 nand3
X12 G3 P4 nw12 nand2
X13 G4 nw13 not
X14 nw1 nw2 C1 nand2
X15 nw3 nw4 nw5 C2 nand3
X16 nw6 nw7 nw8 nw9 C3 nand4
X17 nw10 nw11 nw12 nw13 BG nand4
X18 P1 P2 P3 P4 BP and4
X19 C_1 BP nw14 and2
X20 nw14 BG C4 or2
.ends

.subckt CLA_2unit_UP2 P1 G1 P2 G2 C_1 C1 C2
X1 C_1 P1 nw1 nand2
X2 G1 nw2 not
X3 C_1 P1 P2 nw3 nand3
X4 G1 P2 nw4 nand2
X5 G2 nw5 not
X6 nw1 nw2 C1 nand2
X7 nw3 nw4 nw5 C2 nand3
.ends

.subckt CLA_3unit P1 G1 P2 G2 P3 G3 C_1 C1 C2 C3
X1 C_1 P1 nw1 nand2
X2 G1 nw2 not
X3 C_1 P1 P2 nw3 nand3
X4 G1 P2 nw4 nand2
X5 G2 nw5 not
X6 C_1 P1 P2 P3 nw6 nand4
X7 G1 P2 P3 nw7 nand3
X8 G2 P3 nw8 nand2
X9 G3 nw9 not
X10 nw1 nw2 C1 nand2
X11 nw3 nw4 nw5 C2 nand3
X12 nw6 nw7 nw8 nw9 C3 nand4
.ends

.subckt CLA_13 x[12] x[11] x[10] x[9] x[8] x[7] x[6] x[5] x[4] x[3] x[2] x[1] x[0] y[12]
+ y[11] y[10] y[9] y[8] y[7] y[6] y[5] y[4] y[3] y[2] y[1] y[0] CIN 
+ out[12] out[11] out[10] out[9] out[8] out[7] out[6] out[5] out[4] out[3] out[2] out[1]
+ out[0]

X1 x[0] x[1] x[2] x[3] x[4] x[5] x[6] x[7] x[8] x[9] x[10] x[11]
+ y[0] y[1] y[2] y[3] y[4] y[5] y[6] y[7] y[8] y[9] y[10] y[11]
+ p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 g0 g1 g2 g3 g4 g5 g6 g7 g8 g9 g10 g11 FOR_PG_12

XCLA1 p0 g0 p1 g1 p2 g2 p3 g3 CIN C0_0 C0_1 C0_2 C0_3 BP_0 BG_0 CLA_4unit
XCLA2 p4 g4 p5 g5 p6 g6 p7 g7 wc C1_0 C1_1 C1_2 C1_3 BP_1 BG_1 CLA_4unit
XCLA3 BP_0 BG_0 BP_1 BG_1 CIN wc wc2 CLA_2unit_UP2
XCLA4 p8 g8 p9 g9 p10 g10 p11 g11 wc2 C2_0 C2_1 C2_2 C2_3 BP_2 BG_2 CLA_4unit
X2 x[0] x[1] x[2] x[3] x[4] x[5] x[6] x[7] x[8] x[9] x[10] x[11] x[12] y[0] y[1] y[2] y[3] 
+ y[4] y[5] y[6] y[7] y[8] y[9] y[10] y[11] y[12] CIN C0_0 C0_1 C0_2 C0_3 C1_0 C1_1
+ C1_2 C1_3 C2_0 C2_1 C2_2 C2_3 out[0] out[1] out[2] out[3] out[4] out[5] out[6]
+ out[7] out[8] out[9] out[10] out[11] out[12] XOR_13
.ends


.subckt DFF_13
+ X[0] X[1] X[2] X[3] X[4] X[5] X[6] X[7] X[8] X[9] X[10] X[11] X[12]
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] OUT[7] OUT[8] OUT[9] OUT[10] OUT[11] OUT[12]

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
XDFF_4 Clk X[3]  OUT[3] dff
XDFF_5 Clk X[4]  OUT[4] dff
XDFF_6 Clk X[5]  OUT[5] dff
XDFF_7 Clk X[6]  OUT[6] dff
XDFF_8 Clk X[7]  OUT[7] dff
XDFF_9 Clk X[8]  OUT[8] dff
XDFF_10 Clk X[9]  OUT[9] dff
XDFF_11 Clk X[10]  OUT[10] dff
XDFF_12 Clk X[11]  OUT[11] dff
XDFF_13 Clk X[12]  OUT[12] dff
.ends

.subckt DFF_12
+ X[0] X[1] X[2] X[3] X[4] X[5] X[6] X[7] X[8] X[9] X[10] X[11] 
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] OUT[7] OUT[8] OUT[9] OUT[10] OUT[11] 

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
XDFF_4 Clk X[3]  OUT[3] dff
XDFF_5 Clk X[4]  OUT[4] dff
XDFF_6 Clk X[5]  OUT[5] dff
XDFF_7 Clk X[6]  OUT[6] dff
XDFF_8 Clk X[7]  OUT[7] dff
XDFF_9 Clk X[8]  OUT[8] dff
XDFF_10 Clk X[9]  OUT[9] dff
XDFF_11 Clk X[10]  OUT[10] dff
XDFF_12 Clk X[11]  OUT[11] dff
.ends


.subckt DFF_11
+ X[0] X[1] X[2] X[3] X[4] X[5] X[6] X[7] X[8] X[9] X[10] 
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] OUT[7] OUT[8] OUT[9] OUT[10] 

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
XDFF_4 Clk X[3]  OUT[3] dff
XDFF_5 Clk X[4]  OUT[4] dff
XDFF_6 Clk X[5]  OUT[5] dff
XDFF_7 Clk X[6]  OUT[6] dff
XDFF_8 Clk X[7]  OUT[7] dff
XDFF_9 Clk X[8]  OUT[8] dff
XDFF_10 Clk X[9]  OUT[9] dff
XDFF_11 Clk X[10]  OUT[10] dff
.ends


.subckt DFF_6
+ X[0] X[1] X[2] X[3] X[4] X[5] 
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] 

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
XDFF_4 Clk X[3]  OUT[3] dff
XDFF_5 Clk X[4]  OUT[4] dff
XDFF_6 Clk X[5]  OUT[5] dff
.ends


.subckt DFF_7
+ X[0] X[1] X[2] X[3] X[4] X[5] X[6] 
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] 

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
XDFF_4 Clk X[3]  OUT[3] dff
XDFF_5 Clk X[4]  OUT[4] dff
XDFF_6 Clk X[5]  OUT[5] dff
XDFF_7 Clk X[6]  OUT[6] dff
.ends


.subckt DFF_3
+ X[0] X[1] X[2]
+ CLK
+ OUT[0] OUT[1] OUT[2]

*.subckt dff clk d q 
XDFF_1 Clk X[0]  OUT[0] dff
XDFF_2 Clk X[1]  OUT[1] dff
XDFF_3 Clk X[2]  OUT[2] dff
.ends

*************************************
*************************************
           * large subckt
*************************************
*************************************
.subckt MAC6 CLK A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0] 
+ MODE
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0] 


* x0 x1 x2 yi[5] yi[4] yi[3] yi[2] yi[1] yi[0] yo[6] yo[5] yo[4] yo[3] yo[2] yo[1] yo[0] Booth_En
XBooth_En1 GND  B[0] B[1] A[5] A[4] A[3] A[2] A[1] A[0] PP1[6] PP1[5] PP1[4] PP1[3] PP1[2] PP1[1] PP1[0] Booth_En
XBooth_En2 B[1] B[2] B[3] A[5] A[4] A[3] A[2] A[1] A[0] PP2[6] PP2[5] PP2[4] PP2[3] PP2[2] PP2[1] PP2[0] Booth_En
XBooth_En3 B[3] B[4] B[5] A[5] A[4] A[3] A[2] A[1] A[0] PP3[6] PP3[5] PP3[4] PP3[3] PP3[2] PP3[1] PP3[0] Booth_En 


*PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5]  PP1[6]
XDFF_7_1
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5]  PP1[6]
+ CLK
+ PP1_Q[0] PP1_Q[1] PP1_Q[2] PP1_Q[3] PP1_Q[4] PP1_Q[5]  PP1_Q[6] DFF_7

XDFF_7_2
+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5]  PP2[6]
+ CLK
+ PP2_Q[0] PP2_Q[1] PP2_Q[2] PP2_Q[3] PP2_Q[4] PP2_Q[5]  PP2_Q[6] DFF_7

XDFF_7_3
+ PP3[0] PP3[1] PP3[2] PP3[3] PP3[4] PP3[5]  PP3[6]
+ CLK
+ PP3_Q[0] PP3_Q[1] PP3_Q[2] PP3_Q[3] PP3_Q[4] PP3_Q[5]  PP3_Q[6] DFF_7

XDFF_3_1
+ B[1] B[3] B[5] 
+ CLK
+ B_D[1] B_D[3] B_D[5] DFF_3

XDFF_12
+ ACC[0] ACC[1] ACC[2] ACC[3] ACC[4] ACC[5] ACC[6] ACC[7] ACC[8] ACC[9] ACC[10] ACC[11] 
+ CLK
+ ACC_Q[0] ACC_Q[1] ACC_Q[2] ACC_Q[3] ACC_Q[4] ACC_Q[5] ACC_Q[6] ACC_Q[7] ACC_Q[8] ACC_Q[9] ACC_Q[10] ACC_Q[11]  DFF_12


Xdff CLK MODE MODE_D dff

*extend msb
*XW_T1_1 
*+ PP1_Q[0] PP1_Q[1] PP1_Q[2] PP1_Q[3] PP1_Q[4] PP1_Q[5] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6]
*+ gnd gnd PP2_Q[0] PP2_Q[1] PP2_Q[2] PP2_Q[3] PP2_Q[4] PP2_Q[5] PP2_Q[6] PP2_Q[6] PP2_Q[6] PP2_Q[6] PP2_Q[6]
*+ gnd gnd gnd gnd PP3_Q[0] PP3_Q[1] PP3_Q[2] PP3_Q[3] PP3_Q[4] PP3_Q[5] PP3_Q[6] PP3_Q[6] PP3_Q[6]  
*+ SUM1[2] SUM1[3] SUM1[4] SUM1[5] SUM1[6] SUM1[7] SUM1[8] SUM1[9] SUM1[10] SUM1[11] SUM1[12] 
*+ COUT1[3] COUT1[4] COUT1[5] COUT1[6] COUT1[7] COUT1[8] COUT1[9] COUT1[10] COUT1[11] COUT1[12] W_T1

*extend msb
XW_T1_1 
+  PP1_Q[2] PP1_Q[3] PP1_Q[4] PP1_Q[5] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6] PP1_Q[6]
+  PP2_Q[0] PP2_Q[1] PP2_Q[2] PP2_Q[3] PP2_Q[4] PP2_Q[5] PP2_Q[6] PP2_Q[6] PP2_Q[6] PP2_Q[6] PP2_Q[6]
+  PP3_Q[0] PP3_Q[1] PP3_Q[2] PP3_Q[3] PP3_Q[4] PP3_Q[5] PP3_Q[6] PP3_Q[6] PP3_Q[6]  
+ SUM1[2] SUM1[3] SUM1[4] SUM1[5] SUM1[6] SUM1[7] SUM1[8] SUM1[9] SUM1[10] SUM1[11] SUM1[12] 
+ COUT1[3] COUT1[4] COUT1[5] COUT1[6] COUT1[7] COUT1[8] COUT1[9] COUT1[10] COUT1[11] COUT1[12] W_T1



*XW_T2_1 
*+ PP1_Q[0] PP1_Q[1] SUM1[2] SUM1[3] SUM1[4] SUM1[5] SUM1[6] SUM1[7] SUM1[8] SUM1[9] SUM1[10] SUM1[11] SUM1[12]
*+ gnd gnd gnd COUT1[3] COUT1[4] COUT1[5] COUT1[6] COUT1[7] COUT1[8] COUT1[9] COUT1[10] COUT1[11] COUT1[12] 
*+ B_D[1] GND B_D[3] GND B_D[5] GND GND GND GND GND GND GND GND 
*+ SUM2[0] SUM2[2] SUM2[3] SUM2[4] SUM2[5] SUM2[6] SUM2[7] SUM2[8] SUM2[9] SUM2[10] SUM2[11] SUM2[12] 
*+ COUT2[1] COUT2[3] COUT2[4] COUT2[5] COUT2[6] COUT2[7] COUT2[8] COUT2[9] COUT2[10] COUT2[11] COUT2[12] W_T2

XW_T2_1 
+ PP1_Q[0]  SUM1[2] SUM1[3] SUM1[4] SUM1[5] SUM1[6] SUM1[7] SUM1[8] SUM1[9] SUM1[10] SUM1[11] SUM1[12]
+  COUT1[3] COUT1[4] COUT1[5] COUT1[6] COUT1[7] COUT1[8] COUT1[9] COUT1[10] COUT1[11] COUT1[12] 
+ B_D[1]  B_D[3] B_D[5] 
+ SUM2[0] SUM2[2] SUM2[3] SUM2[4] SUM2[5] SUM2[6] SUM2[7] SUM2[8] SUM2[9] SUM2[10] SUM2[11] SUM2[12] 
+ COUT2[1] COUT2[3] COUT2[4] COUT2[5] COUT2[6] COUT2[7] COUT2[8] COUT2[9] COUT2[10] COUT2[11] COUT2[12] W_T2


XCOMP1_13_1 
+ ACC_Q[0] ACC_Q[1] ACC_Q[2] ACC_Q[3] ACC_Q[4] ACC_Q[5] ACC_Q[6] ACC_Q[7] ACC_Q[8] ACC_Q[9] ACC_Q[10] ACC_Q[11] 
+ IACC[0] IACC[1] IACC[2] IACC[3] IACC[4] IACC[5] IACC[6] IACC[7] IACC[8] IACC[9] IACC[10] IACC[11] COMP1_13


*.subckt MUX A B SEL Y
XMUX_1 ACC_Q[0] IACC[0] MODE_D ACC_OUT[0] MUX
XMUX_2 ACC_Q[1] IACC[1] MODE_D ACC_OUT[1] MUX
XMUX_3 ACC_Q[2] IACC[2] MODE_D ACC_OUT[2] MUX
XMUX_4 ACC_Q[3] IACC[3] MODE_D ACC_OUT[3] MUX
XMUX_5 ACC_Q[4] IACC[4] MODE_D ACC_OUT[4] MUX
XMUX_6 ACC_Q[5] IACC[5] MODE_D ACC_OUT[5] MUX
XMUX_7 ACC_Q[6] IACC[6] MODE_D ACC_OUT[6] MUX
XMUX_8 ACC_Q[7] IACC[7] MODE_D ACC_OUT[7] MUX
XMUX_9 ACC_Q[8] IACC[8] MODE_D ACC_OUT[8] MUX
XMUX_10 ACC_Q[9] IACC[9] MODE_D ACC_OUT[9] MUX
XMUX_11 ACC_Q[10] IACC[10] MODE_D ACC_OUT[10] MUX
XMUX_12 ACC_Q[11] IACC[11] MODE_D ACC_OUT[11] MUX
*XMUX_13 ACC_Q[11] IACC[11] MODE_D ACC_OUT[12] MUX


Xdff1 CLK MODE_D MODE_Q  dff

xDFF_13_5
+ ACC_OUT[0] ACC_OUT[1] ACC_OUT[2] ACC_OUT[3] ACC_OUT[4] ACC_OUT[5] ACC_OUT[6] ACC_OUT[7] ACC_OUT[8] ACC_OUT[9] ACC_OUT[10] ACC_OUT[11]
+ CLK
+ ACC_Q1[0] ACC_Q1[1] ACC_Q1[2] ACC_Q1[3] ACC_Q1[4] ACC_Q1[5] ACC_Q1[6] ACC_Q1[7] ACC_Q1[8] ACC_Q1[9] ACC_Q1[10] ACC_Q1[11]  DFF_12

xDFF_13_1
+SUM2[0] PP1_Q[1] SUM2[2] SUM2[3] SUM2[4] SUM2[5] SUM2[6] SUM2[7] SUM2[8] SUM2[9] SUM2[10] SUM2[11] SUM2[12]
+ CLK
+SUM2_Q[0] PP1_Q1[1] SUM2_Q[2] SUM2_Q[3] SUM2_Q[4] SUM2_Q[5] SUM2_Q[6] SUM2_Q[7] SUM2_Q[8] SUM2_Q[9] SUM2_Q[10] SUM2_Q[11] SUM2_Q[12] DFF_13

**xDFF_13_2
**+gnd COUT2[1] gnd COUT2[3] COUT2[4] COUT2[5] COUT2[6] COUT2[7] COUT2[8] COUT2[9] COUT2[10] COUT2[11] COUT2[12] 
**+ CLK
**+gnd COUT2_Q[1] gnd COUT2_Q[3] COUT2_Q[4] COUT2_Q[5] COUT2_Q[6] COUT2_Q[7] COUT2_Q[8] COUT2_Q[9] COUT2_Q[10] COUT2_Q[11] COUT2_Q[12]  DFF_13
xDFF_13_2
+ COUT2[1] COUT2[3] COUT2[4] COUT2[5] COUT2[6] COUT2[7] COUT2[8] COUT2[9] COUT2[10] COUT2[11] COUT2[12] 
+ CLK
+ COUT2_Q[1] COUT2_Q[3] COUT2_Q[4] COUT2_Q[5] COUT2_Q[6] COUT2_Q[7] COUT2_Q[8] COUT2_Q[9] COUT2_Q[10] COUT2_Q[11] COUT2_Q[12]  DFF_11




*Wallace Tree 3
XW_T3_1 
+ SUM2_Q[0] PP1_Q1[1] SUM2_Q[2] SUM2_Q[3] SUM2_Q[4] SUM2_Q[5] SUM2_Q[6] SUM2_Q[7] SUM2_Q[8] SUM2_Q[9] SUM2_Q[10] SUM2_Q[11] SUM2_Q[12]
+ COUT2_Q[1] COUT2_Q[3] COUT2_Q[4] COUT2_Q[5] COUT2_Q[6] COUT2_Q[7] COUT2_Q[8] COUT2_Q[9] COUT2_Q[10] COUT2_Q[11] COUT2_Q[12] 
+ ACC_Q1[0] ACC_Q1[1] ACC_Q1[2] ACC_Q1[3] ACC_Q1[4] ACC_Q1[5] ACC_Q1[6] ACC_Q1[7] ACC_Q1[8] ACC_Q1[9] ACC_Q1[10] ACC_Q1[11] ACC_Q1[11]  
+ SUM4[0] SUM4[1] SUM4[2] SUM4[3] SUM4[4] SUM4[5] SUM4[6] SUM4[7] SUM4[8] SUM4[9] SUM4[10] SUM4[11] SUM4[12] 
+ COUT4[1] COUT4[2] COUT4[3] COUT4[4] COUT4[5] COUT4[6] COUT4[7] COUT4[8] COUT4[9] COUT4[10] COUT4[11] COUT4[12] W_T3


*Wallace Tree 3
*XW_T3_1 
*+ SUM2_Q[0] PP1_Q1[1] SUM2_Q[2] SUM2_Q[3] SUM2_Q[4] SUM2_Q[5] SUM2_Q[6] SUM2_Q[7] SUM2_Q[8] SUM2_Q[9] SUM2_Q[10] SUM2_Q[11] SUM2_Q[12]
*+ gnd COUT2_Q[1] gnd COUT2_Q[3] COUT2_Q[4] COUT2_Q[5] COUT2_Q[6] COUT2_Q[7] COUT2_Q[8] COUT2_Q[9] COUT2_Q[10] COUT2_Q[11] COUT2_Q[12] 
*+ ACC_Q1[0] ACC_Q1[1] ACC_Q1[2] ACC_Q1[3] ACC_Q1[4] ACC_Q1[5] ACC_Q1[6] ACC_Q1[7] ACC_Q1[8] ACC_Q1[9] ACC_Q1[10] ACC_Q1[11] ACC_Q1[11]  
*+ SUM4[0] SUM4[1] SUM4[2] SUM4[3] SUM4[4] SUM4[5] SUM4[6] SUM4[7] SUM4[8] SUM4[9] SUM4[10] SUM4[11] SUM4[12] 
*+ COUT4[1] COUT4[2] COUT4[3] COUT4[4] COUT4[5] COUT4[6] COUT4[7] COUT4[8] COUT4[9] COUT4[10] COUT4[11] COUT4[12] W_T3

*Wallace Tree 3
*XW_T3_1 
*+ SUM2[0] PP1[1] SUM2[2] SUM2[3] SUM2[4] SUM2[5] SUM2[6] SUM2[7] SUM2[8] SUM2[9] SUM2[10] SUM2[11] SUM2[12] 
*+ gnd COUT2[1] gnd COUT2[3] COUT2[4] COUT2[5] COUT2[6] COUT2[7] COUT2[8] COUT2[9] COUT2[10] COUT2[11] COUT2[12] 
*+ ACC_OUT[0] ACC_OUT[1] ACC_OUT[2] ACC_OUT[3] ACC_OUT[4] ACC_OUT[5] ACC_OUT[6] ACC_OUT[7] ACC_OUT[8] ACC_OUT[9] ACC_OUT[10] ACC_OUT[11] ACC_OUT[12]  
*+ SUM4[0] SUM4[1] SUM4[2] SUM4[3] SUM4[4] SUM4[5] SUM4[6] SUM4[7] SUM4[8] SUM4[9] SUM4[10] SUM4[11] SUM4[12] 
*+ COUT4[1] COUT4[2] COUT4[3] COUT4[4] COUT4[5] COUT4[6] COUT4[7] COUT4[8] COUT4[9] COUT4[10] COUT4[11] COUT4[12] W_T3

*xDFF_13_5
*+SUM4[12] SUM4[11] SUM4[10] SUM4[9] SUM4[8] SUM4[7] SUM4[6] SUM4[5] SUM4[4] SUM4[3] SUM4[2] SUM4[1] SUM4[0]
*+ CLK
*+SUM4_Q[12] SUM4_Q[11] SUM4_Q[10] SUM4_Q[9] SUM4_Q[8] SUM4_Q[7] SUM4_Q[6] SUM4_Q[5] SUM4_Q[4] SUM4_Q[3] SUM4_Q[2] SUM4_Q[1] SUM4_Q[0] DFF_13

*xDFF_13_4
*+ COUT4[12] COUT4[11] COUT4[10] COUT4[9] COUT4[8] COUT4[7] COUT4[6] COUT4[5] COUT4[4] COUT4[3] COUT4[2] COUT4[1] MODE_D
*+ CLK
*+ COUT4_Q[12] COUT4_Q[11] COUT4_Q[10] COUT4_Q[9] COUT4_Q[8] COUT4_Q[7] COUT4_Q[6] COUT4_Q[5] COUT4_Q[4] COUT4_Q[3] COUT4_Q[2] COUT4_Q[1] MODE_Q DFF_13


XCLA_13 
+ SUM4[12] SUM4[11] SUM4[10] SUM4[9] SUM4[8] SUM4[7] SUM4[6] SUM4[5] SUM4[4] SUM4[3] SUM4[2] SUM4[1] SUM4[0] COUT4[12]
+ COUT4[11] COUT4[10] COUT4[9] COUT4[8] COUT4[7] COUT4[6] COUT4[5] COUT4[4] COUT4[3] COUT4[2] COUT4[1] gnd MODE_Q
+ OUT_D[12] OUT_D[11] OUT_D[10] OUT_D[9] OUT_D[8] OUT_D[7] OUT_D[6] OUT_D[5] OUT_D[4] OUT_D[3] OUT_D[2] OUT_D[1]
+ OUT_D[0] CLA_13


XDFF_13_3
+ OUT_D[0] OUT_D[1] OUT_D[2] OUT_D[3] OUT_D[4] OUT_D[5] OUT_D[6] OUT_D[7] OUT_D[8] OUT_D[9] OUT_D[10] OUT_D[11] OUT_D[12]
+ CLK
+ OUT[0] OUT[1] OUT[2] OUT[3] OUT[4] OUT[5] OUT[6] OUT[7] OUT[8] OUT[9] OUT[10] OUT[11] OUT[12] DFF_13

.ends









