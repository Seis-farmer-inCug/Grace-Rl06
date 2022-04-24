# Grace-Rl06
## Writter：WanxinLuo from china university of geosince,wuhan
### **[cnm,snm] = Grace20042010()**  
This function can be used to return the average 90x90 spherical harmonic coefficient from 2004 to 2010，the Database from “Grace_GAX_products”  
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
