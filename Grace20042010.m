function [cnm,snm]=Grace20042010()
maindir = 'D:\MATLAB\bin\Grace_GAX_products'
filename = dir(maindir)
filename = filename(3:86,:)
cnmsum=0;
snmsum=0;
for i = 1:84
    [cnm,snm] = readgracerl06( filename(i).name );
    cnmsum = cnmsum+cnm;
    snmsum = snmsum+snm;
end
cnm = cnmsum/84;
snm = snmsum/84;
end
