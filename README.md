# Grace-Rl06 Inversion
## Writter：WanxinLuo from china university of geosince,wuhan
### **[cnm,snm] = Grace20042010()**  
This function can be used to return the average 90x90 spherical harmonic coefficient from 2004 to 2010，the Database from “data-CSR-2004-2010.rar”  
### **[cnm, snm, GM, R] = readgracerl06(filename)**  
*Inuput:*  
***filename:*** the name of Grace file.   
*Output:*  
***cnm,snm:*** Spherical harmonic coefficient  
***GM,R:*** Radiul of the earth  
### **wn = filterCoefficientsGaussian(radius, maxDegree)**  
*Input:*  
***radius:*** half-with radius parameter in km.
***maxDegree:*** maximum degree to compute.
*Output:*  
***wn:*** (n + 1) x 1 vector with n = maxDegree.
### **Pnm = legendreFunctions(theta, maxDegree)**  
*Input:*  
***theta:*** co-latitude in radian.  
***maxDegree:*** maximum degree and order to compute.  
*Output:*  
***Pnm:*** matrix containing the 4pi-normalized Legendre functions.
## Example  
~~~
clear all
[cnm,snm]=Grace20042010()

l=60;
[cnm7,snm7] = readgracerl06( 'kfilter_DDK5_GSM-2_2020122-2020152_GRFO_UTCSR_BA01_0600.txt' );%May
[cnm8,snm8] = readgracerl06( 'kfilter_DDK5_GSM-2_2020153-2020182_GRFO_UTCSR_BA01_0600.txt' );%June
[cnm9,snm9,GM,R] = readgracerl06( 'kfilter_DDK5_GSM-2_2020183-2020213_GRFO_UTCSR_BA01_0600.txt' );%July
[cnm10,snm10] = readgracerl06( 'kfilter_DDK5_GSM-2_2020214-2020244_GRFO_UTCSR_BA01_0600.txt' );%August
[cnm11,snm11] = readgracerl06( 'kfilter_DDK5_GSM-2_2020245-2020274_GRFO_UTCSR_BA01_0600.txt' );%September
maxDegree = 60;% choose the maxdegree
cnm = cnm(1:maxDegree+1, 1:maxDegree+1);
snm = snm(1:maxDegree+1, 1:maxDegree+1);
%choose the month which you need
dcnm=cnm11-cnm;
dsnm=snm11-snm;

wn = filterCoefficientsGaussian(500, l);
for n=0:1:l
  dcnm(n+1,:) = wn(n+1) * dcnm(n+1,:); % filter all orders of one degree
  dsnm(n+1,:) = wn(n+1) * dsnm(n+1,:);
end
lambda = pi/180 * [-180:0.1:180]';
theta  = pi/180 * [180:-0.1:0]';


kn = load('loadLove.txt');
rho=1;

G = 6.673e-11; % gravitational constant
rho_e = GM/G/(4/3*pi*R^3); % mean density of the Earth

factor = zeros(1,l+1);
for n=1:1:l
  factor(n+1) = R*rho_e/(3*rho)*(2*n+1)/(1+kn(n+1));
end
cosm = cos([0:1:l]'*lambda');
sinm = sin([0:1:l]'*lambda');
tws = zeros(size(theta,1), size(lambda,1));
for i=1:size(theta,1) % loop over all thetas
  Pnm = legendreFunctions(theta(i),l);  % all Legendre Functions for one theta
  % compute result for all lambdas (one row) in one step (as matrix multiplications)
  tws(i,:) = factor * ((dcnm.*Pnm) * cosm + (dsnm.*Pnm) * sinm);
showGrid(lambda, theta, tws9, 'b')
end
~~~
