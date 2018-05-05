clear all;

%%
% Image_1
figure;
load Lena.mat
image(lena)
for i = 1:128
    a(1,i)=4;
end
L = mat2cell(lena, a,a);
for i=1:128
    for j=1:128
        L{i,j}=reshape(L{i,j},[1,16]);
    end
end
L = L';
L = reshape(L, [1,16384]);
L = vertcat(L{:});
L = L';

%%
% Image_2
figure;
load Boat.mat
image(boat)
for i = 1:128
    a(1,i)=4;
end
H = mat2cell(boat, a,a);
for i=1:128
    for j=1:128
        H{i,j}=reshape(H{i,j},[1,16]);
    end
end
H = H';
H = reshape(H, [1,16384]);
H = vertcat(H{:});
H = H';

%%
% Image_3
figure;
load BABOON.mat
image(baboon)
for i = 1:128
    a(1,i)=4;
end
B = mat2cell(baboon, a,a);
for i=1:128
    for j=1:128
        B{i,j}=reshape(B{i,j},[1,16]);
    end
end
B = B';
B = reshape(B, [1,16384]);
B = vertcat(B{:});
B = B';

%%
%Designing a SOM

net = selforgmap([8 8],320);

%% 
net = train(net,L);
view(net)
%%
for i = 1:4:512
    y = net(B);
end
classes = vec2ind(y);
% 
%% reconstruct image 
W = net.iw{1,1};
im = zeros(512,512);
k = 0;

for i = 1:4:512
    for j = 1: 4: 512
      k = k+1;
      winner = classes(1,k);
      im(i:i+3,j:j+3) = reshape(W(winner,:),[4,4]);
    end
end
%%
figure;
imagesc(im)
colormap(gray)

%%
boat=reshape(boat,[1,262144]);
im=reshape(im,[1,262144]);
var1 = var(boat);
var2 = var(im);
dr = 10*log10(var2/var1)


