close all; clear all; clc;

%% ============================BACA DATA NC============================ %%
dirData    = 'D:\Tutorial_Matlab_PKL_2017\MATLAB';
ncFileName3 = 'H08_B03_Indonesia_20150908.Z0500.nc';
ncFileName4 = 'H08_B04_Indonesia_20150908.Z0500.nc';

fileName3   = [dirData,'\',ncFileName3];
fileName4   = [dirData,'\',ncFileName4];

ncid3       = netcdf.open(fileName3,'NC_NOWRITE');
ncid4       = netcdf.open(fileName4,'NC_NOWRITE');

%% =======================PENGATURAN DATA SATELIT====================== %%
%lon1 = netcdf.getVar(ncid1,2,0,3296);
%lat1 = netcdf.getVar(ncid1,1,0,2196);
c3 = netcdf.getVar(ncid3,4,[0 0 0],[3296 2196 1]);
c4 = netcdf.getVar(ncid4,4,[0 0 0],[3296 2196 1]);

%%======================================================================%%
channel=c3;
[tinggi,lebar]=size(channel);
sddarat=zeros(tinggi,lebar);

for i=1:tinggi
    for j=1:lebar
        
        n=0;
        for mxi=-1:1
            for myj=-1:1
                if i+mxi>=1 && i+mxi<=tinggi && j+myj>=1 && j+myj<=lebar
                    n=n+1;
                    area3x3(n)=channel(i+mxi,j+myj);
                end
            end
        end 
        sddarat(i,j)=std(area3x3);
    end
end
%fprintf('done\n');

channel=c4;
[tinggi,lebar]=size(channel);
sdlaut=zeros(tinggi,lebar);

for i=1:tinggi
    for j=1:lebar
        %fprintf('hitung grid ke (%d,%d)\n',i,j);
        
        n=0;
        for mxi=-1:1
            for myj=-1:1
                if i+mxi>=1 && i+mxi<=tinggi && j+myj>=1 && j+myj<=lebar
                    n=n+1;
                    area3x3(n)=channel(i+mxi,j+myj);
                end
            end
        end 
        sdlaut(i,j)=std(area3x3);
    end
end
%fprintf('done\n');

%% ============================BACA DATA NC============================ %%
dirData    = 'D:\Tutorial_Matlab_PKL_2017\MATLAB';
ncFileName1 = 'H08_B01_Indonesia_20150908.Z0500.nc';
ncFileName3 = 'H08_B03_Indonesia_20150908.Z0500.nc';
ncFileName4 = 'H08_B04_Indonesia_20150908.Z0500.nc';
ncFileName5 = 'H08_B05_Indonesia_20150908.Z0500.nc';
ncFileName6 = 'H08_B06_Indonesia_20150908.Z0500.nc';
ncFileName7 = 'H08_B07_Indonesia_20150908.Z0500.nc';
ncFileName14 = 'H08_B14_Indonesia_20150908.Z0500.nc';
ncFileName15 = 'H08_B15_Indonesia_20150908.Z0500.nc';

fileName1   = [dirData,'\',ncFileName1];
fileName3   = [dirData,'\',ncFileName3];
fileName4   = [dirData,'\',ncFileName4];
fileName5   = [dirData,'\',ncFileName5];
fileName6   = [dirData,'\',ncFileName6];
fileName7   = [dirData,'\',ncFileName7];
fileName14  = [dirData,'\',ncFileName14];
fileName15  = [dirData,'\',ncFileName15];

ncid1       = netcdf.open(fileName1,'NC_NOWRITE');
ncid3       = netcdf.open(fileName3,'NC_NOWRITE');
ncid4       = netcdf.open(fileName4,'NC_NOWRITE');
ncid5       = netcdf.open(fileName5,'NC_NOWRITE');
ncid6       = netcdf.open(fileName6,'NC_NOWRITE');
ncid7       = netcdf.open(fileName7,'NC_NOWRITE');
ncid14      = netcdf.open(fileName14,'NC_NOWRITE');
ncid15      = netcdf.open(fileName15,'NC_NOWRITE');

%%======================================================================%%

%% =======================PENGATURAN DATA SATELIT====================== %%
%lon1 = netcdf.getVar(ncid1,2,0,3296);
%lat1 = netcdf.getVar(ncid1,1,0,2196);
c1 = netcdf.getVar(ncid1,4,[0 0 0],[3296 2196 1]);
c3 = netcdf.getVar(ncid3,4,[0 0 0],[3296 2196 1]);
c4 = netcdf.getVar(ncid4,4,[0 0 0],[3296 2196 1]);
c5 = netcdf.getVar(ncid5,4,[0 0 0],[3296 2196 1]);
c6 = netcdf.getVar(ncid6,4,[0 0 0],[3296 2196 1]);
c7 = netcdf.getVar(ncid7,4,[0 0 0],[3296 2196 1]);
c14 = netcdf.getVar(ncid14,4,[0 0 0],[3296 2196 1]);
c15 = netcdf.getVar(ncid15,4,[0 0 0],[3296 2196 1]);

%%======================================================================%%

%% ========================MEMBALIKKAN GRID DATA======================= %%

%% ==============================ALGORITMA============================= %%

%% Smoke Over Land
suhu=c7;
[m,n]=size(suhu);
for i=1:m;
    for j=1:n;
        if suhu(i,j)>290;
           suhu(i,j) = 1;
        else
           suhu(i,j) = NaN;
        end
    end
end

btdsuhu=c7-c14;
[m,n]=size(btdsuhu);
for i=1:m;
    for j=1:n;
        if btdsuhu(i,j)>=10;
           btdsuhu(i,j) = 1;
        else
           btdsuhu(i,j) = NaN;
        end
    end
end

enam=c6;
[m,n]=size(enam);
for i=1:m;
    for j=1:n;
        if enam(i,j)<0.2;
           enam(i,j) = 1;
        else
           enam(i,j) = NaN;
        end
    end
end

rumus=(0.06+c6);
tiga=c3>rumus;
[m,n]=size(tiga);
for i=1:m;
    for j=1:n;
        if tiga(i,j)==1;
           tigax(i,j) = 1;
        else
           tigax(i,j) = NaN;
        end
    end
end

rasio1=c1./c3;
[m,n]=size(rasio1);
for i=1:m;
    for j=1:n;
        if rasio1(i,j)>=0.85;
           rasio1(i,j) = 1;
        else
           rasio1(i,j) = NaN;
        end
    end
end

rasio2=c4./c3;
[m,n]=size(rasio2);
for i=1:m;
    for j=1:n;
        if rasio2(i,j)>=1.1;
           rasio2(i,j) = 1;
        else
           rasio2(i,j) = NaN;
        end
    end
end

load sddarat.mat;
[m,n]=size(sddarat);
for i=1:m;
    for j=1:n;
        if sddarat(i,j)<=0.04;
           sddarat(i,j) = 1;
        else
           sddarat(i,j) = NaN;
        end
    end
end

asapdarat=suhu+btdsuhu+enam+tigax+rasio1+rasio2+sddarat;
[m,n]=size(asapdarat);
for i=1:m;
    for j=1:n;
        if asapdarat(i,j)==7;
           asapdarat(i,j) = 1.5;
        else
            asapdarat(i,j)=NaN;
        end
    end
end

satu=c1;
[m,n]=size(satu);
for i=1:m;
    for j=1:n;
        if satu(i,j)>0.12;
           satu(i,j) = 1;
        else
           satu(i,j) = NaN;
        end
    end
end

empat=c4;
[m,n]=size(empat);
for i=1:m;
    for j=1:n;
        if empat(i,j)>0.055;
           empat(i,j) = 1;
        else
           empat(i,j) = NaN;
        end
    end
end

lima=c5;
[m,n]=size(lima);
for i=1:m;
    for j=1:n;
        if (lima(i,j)<0.05 && lima(i,j)>0.022);
           lima(i,j) = 1;
        else
           lima(i,j) = NaN;
        end
    end
end

load sdlaut.mat;
[m,n]=size(sdlaut);
for i=1:m;
    for j=1:n;
        if sdlaut(i,j)<=0.003;
           sdlaut(i,j) = 1;
        else
           sdlaut(i,j) = NaN;
        end
    end
end

rasio3=c1./c5;
[m,n]=size(rasio3);
for i=1:m;
    for j=1:n;
        if rasio3(i,j)>=5;
           rasio3(i,j) = 1;
        else
           rasio3(i,j) = NaN;
        end
    end
end

rasio4=c6./c5;
[m,n]=size(rasio4);
for i=1:m;
    for j=1:n;
        if rasio4(i,j)<1.0;
           rasio4(i,j) = 1;
        else
           rasio4(i,j) = NaN;
        end
    end
end

asaplaut=satu+empat+lima+rasio3+rasio4+sdlaut;
[m,n]=size(asaplaut);
for i=1:m;
    for j=1:n;
        if asaplaut(i,j)==6;
           asaplaut(i,j) = 1.5;
        else
            asaplaut(i,j)=NaN;
        end
    end
end

%% Smoke
load ('D:\Tutorial_Matlab_PKL_2017\MATLAB\6491.dat');
lon=89.9819:0.0181:149.628;
lat=-19.776:0.0181:19.9638;
figure;hold off;
m_proj('mercator','long',[89.9819 149.628],'lat',[-19.776 19.9638]);
m_line(X6491(:,1),X6491(:,2),'color','k','linewidth',1.2);
m_grid('linest','none','linewidth',1.5,'tickdir','out','xaxisloc','bottom','yaxisloc','left')
[X,Y] = m_ll2xy(lon,lat,'clip','off');
hold on
%pcolor(X,Y,c3');
pcolor(X,Y,asapdarat');
pcolor(X,Y,asaplaut');
%cmapY = gray;
cmapZ = flipud (hsv(1));
cmap = [cmapZ];
colormap(cmap);
shading('interp');
h=colorbar('eastoutside');
%set(get(h,'ylabel'),'String','Brightness Temperature (deg C)');
title('Sebaran Asap 8 Sept 2015 05UTC','fontweight','bold','fontsize',20);
%saveas(hf,'E:\Smoke\script\hasil','jpg');