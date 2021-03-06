%% Axially Magnetized Ring Magnet 3D Model
 % ---------------------------------------------------------------------
 % This code provide an implementation of a closed-form model to compute 
 % the magnetic flux density of an axially magnetized RING magnet.
 % The computation of the field requires the computation of the generalized
 % complete elliptic integrals (ref. Derby 2009). These are computed fastly
 % using the algorithm proposed by Burlisch, here implemented as an
 % auxiliary function, called GeneralizedEllipke.
 % The far field approximated equivalence with a Magnetic Dipole can be 
 % easily verifyied running "ModelTesting.m".
 %
 % Inputs:
 %    1) Rin    : internal radius of the magnet                   [number]
 %    2) Rout   : external radius of the magnet                   [number]
 %    3) L      : length of the magnet                            [number] 
 %    4) M      : magnetization of the magnet                     [number]
 %    5) MagPos : the first three elements are the cartesian coordinates 
 %                of the center of the magnet, while the the latter three
 %                express the pose of the magnet, magnetic moment
 %                expressed as a unit vector                      [6x1]
 %    6) Point  : cartesian coordinates of the point feeling the field 
 %                generated by the magnet                         [3x1]
 %
 % Outputs:
 %    1) Brho   : radial component of the magnetic field          [number]
 %    2) Bz     : axial component of the magnetic field           [number]
 %
 % ATTENTION: the code consider every input vector as a column vector!
 % ---------------------------------------------------------------------
 % OCtober 19th, 2019                           Author: Federico Masiero
 % ---------------------------------------------------------------------
 
 %                                         Last check: October 19th, 2019

function [Brho,Bz] = AxialRingModel(Rin,Rout,L,M,MagPos,Point)

[Brho2,Bz2] = AxialCylModelDerby(2*Rout,L,M,MagPos,Point);
[Brho1,Bz1] = AxialCylModelDerby(2*Rin,L,-M,MagPos,Point);

Brho = Brho2 + Brho1;
Bz   = Bz2 + Bz1;
