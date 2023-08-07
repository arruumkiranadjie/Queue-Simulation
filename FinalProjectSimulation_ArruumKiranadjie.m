%%SIMULASI
%%ARRUUM PRATISTHA KIRANADJIE (081911233063)
    
disp('===============================================================================================')
disp('===============================================================================================')
disp('SIMULASI ANTRIAN DENGAN MEKANISME PELAYANAN SINGLE SERVER SINGLE STAGE PADA RESTORAN DONAT JCO ')
disp('                                 KOTA TANGERANG SELATAN                                        ')
disp('===============================================================================================')
disp('===============================================================================================')

n=input('Masukkan Banyaknya Pelanggan = '); 
disp('Masukkan Distribusi Waktu Antar Kedatangan dan Lama Pelayanan')
disp('1. Distribusi WAK Normal - Distribusi LP Normal')
disp('2. Distribsi WAK Eksponensial - Distribusi LP Eksponensial')
pilih=input('1 / 2 = ')

switch pilih 
    case 1 %DISTRIBUSI NORMAL - DISTRIBUSI NORMAL
        %Input mu dan sigma WAK dan LP (detik)
        a=input('Masukkan Rata-rata WAK = ');
        b=input('Masukkan Standar Deviasi WAK = ');
        c=input('Masukkan Rata-rata LP = ');
        d=input('Masukkan Standar Deviasi LP = ');
        
        %%Membangkitkan data WAK dan LP
        
        %Waktu Antar Kedatangan
        WaktuAntarKedatangan(:,1)=abs(normrnd(a,b,[n,1]));
        tabel(:,1)=[1:1:n];
        tabel(:,2)=WaktuAntarKedatangan;
        tabel(1,2)=0; 
        
        %Lama Pelayanan
        LamaPelayanan(:,1)=abs(normrnd(c,d,[n,1]));
        tabel(:,3)=LamaPelayanan;
        
    case 2 %DISTRIBUSI EKSPONENSIAL - DISTRIBUSI EKSPONENSIAL
        %Input mu dan sigma WAK dan LP (detik)
        e=input('Masukkan Rata-rata WAK = '); 
        f=input('Masukkan Rata-rata LP = ');
        
        %%Membangkitkan data WAK dan LP
        
        %Waktu Antar Kedatangan
        WaktuAntarKedatangan(:,1)=abs(exprnd(e,[n,1]));
        tabel(:,1)=[1:1:n];
        tabel(:,2)=WaktuAntarKedatangan;
        tabel(1,2)=0; 
        
        %Lama Pelayanan
        LamaPelayanan(:,1)=abs(exprnd(f,[n,1]));
        tabel(:,3)=LamaPelayanan;

disp('===============================================================================================')
disp('============== DATA HASIL PEMBANGKITAN WAKTU ANTAR KEDATANGAN DAN LAMA PELAYANAN ==============')
disp('===============================================================================================')
disp('   Pelanggan ke-    WAK    LP')
ceil(tabel)
simulasi(:,1)=tabel(:,1);
simulasi(:,2)=tabel(:,2);
simulasi(:,3)=tabel(:,3);
simulasi(1,4)=simulasi(1,2);

%%TABEL PENGOLAHAN DATA

%Waktu Pelanggan Masuk Antrian (WMA)
for i=1:n-1
    simulasi(i+1,4)=simulasi(i,4)+tabel(i+1,2);
end

%Waktu Pelanggan Mulai Dilayani (WML)
simulasi(1,5)=0;
simulasi(1,6)=simulasi(1,3);

for i=1:n-1
    if simulasi(i+1,4)>simulasi(i,6)
        simulasi(i+1,5)=simulasi(i+1,4);
    else
        simulasi(i+1,5)=simulasi(i,6);
    end
    %Waktu Pelanggan Selesai Dilayani (WSL)
    simulasi(i+1,6)=simulasi(i+1,3)+simulasi(i+1,5);
end

%Waktu Lamanya Pelanggan Mengantri (WLA)
for i=1:n
    simulasi(i,7)=simulasi(i,5)-simulasi(i,4);
end

%Waktu Lamanya Pelanggan Berada Dalam Sistem (WS)
for i=1:n
    simulasi(i,8)=simulasi(i,3)+simulasi(i,7);
end

%Rata-rata WAK dan LP
meanWAK=mean(simulasi(:,2));
meanLP=mean(simulasi(:,3));
meanWS=mean(simulasi(:,8));

disp('===============================================================================================')
disp('========================== HASIL SIMULASI ANTRIAN RESTORAN JCO DONAT ==========================')
disp('===============================================================================================')
disp('   Pelanggan ke-      WAK       LP           WMA         WML         WSL         WLA         WS')
ceil(simulasi)
disp('Waktu Antar Kedatangan(WAK')
disp('Lama Pelayanan (LP)')
disp('Waktu Pelanggan Masuk Antrian (WMA)')
disp('Waktu Pelanggan Mulai Dilayani (WML)')
disp('Waktu Pelanggan Selesai Dilayani (WSL)')
disp('Waktu Lamanya Pelanggan Mengantri (WLA)')
disp('Waktu Lamanya Pelanggan Berada Dalam Sistem Antrian (WS)')
disp(' ') 

disp('Rata-rata Waktu Antar Kedatangan Berdasarkan Simulasi = ')  
meanWAK
disp('Rata-rata Lama Pelayanan Berdasarkan Simulasi = ')  
meanLP
disp('Rata-rata Waktu Lamanya Pelanggan Berada Dalam Sistem Berdasarkan Simulasi = ')  
meanWS

%HASIL MATLAB

%Customer Arrival Rate (lambda)
lambda=1/meanWAK;
disp('Customer Arrival rate (lambda) per detik =')
lambda

%%Service Rate per server (mu)
mu=1/meanLP;
disp('Service Rate per server (mu) per detik =')
mu 

%%Overall system utilization (Tingkat Kesibukan Server)
rho=lambda/mu;
disp('Overall System Utilization atau Tingkat Kesibukan Server sebesar =')
rho

%Jumlah Rata-rata Pelanggan Dalam Sistem (L)
l=lambda*meanWS;
disp('Jumlah Rata-rata Pelanggan Dalam Sistem sebesar =')
l

%Rata-rata Waktu Yang Dihabiskan Pelanggan Dalam Antrian (Wq)
wq=meanWS-(1/mu);

%Jumlah Rata-rata Pelanggan Dalam Antrian (Lq)
lq=lambda*wq;
disp('Jumlah Rata-rata Pelanggan Dalam Antrian sebesar =')
lq

%Rata-rata Waktu Yang Dihabiskan Pelanggan Dalam Sistem
disp('Rata-rata Waktu Yang Dihabiskan Pelanggan Dalam Sistem  = ')  
meanWS

%Rata-rata Waktu Yang Dihabiskan Pelanggan Dalam Antrian (Wq)
disp('Rata-rata Waktu Yang Dihabiskan Pelanggan Dalam Antrian =')
wq

%Probabilitas Semua Server Menganggur (Po)
p0=1-rho;
disp('Probabilitas Semua Server Menganggur sebesar =')
p0 

    otherwise
        disp('Pilihan Anda Salah!')
end

 
