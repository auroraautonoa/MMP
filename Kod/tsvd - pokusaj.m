podaci = 'Yale_64x64' ; 

load Yale_64x64.mat
A  = fea' ; 
np = 15 ; ne = 11 ; 
n = 64 ; m = 64 ; 
no_rows_A = n*m ; 
T = zeros(ni,ne,np) ; 
%
i = 0 ; 
for p = 1 : np
  for e = 1 : ne
     i = i + 1 ;  
     T(:,e,p) = A(:,i) ;  
  end
end
%
for p = 4 : 7
  figure(p)
  for e = 1 : 11
      L = reshape(T(:,e,p),[n,m]); 
      subplot(4,3,e), imagesc(L), colormap(gray);
  end
end

mean_matrix = mean(T, 2);
t = bsxfun(@minus, T, mean_matrix);
%s = cov(T');
s=permute(T, [2 1 3])
[V, D] = eig(s);
eigval = diag(D);
eigval = eigval(end: - 1:1);
V = fliplr(V);
figure, subplot(4, 4, 1)
imagesc(reshape(mean_matrix, [h, w]))
colormap gray
for i = 1:15
    subplot(4, 4, i + 1)
    imagesc(reshape(V(:, i), h, w))
end
