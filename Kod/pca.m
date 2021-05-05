allPersons = zeros(n*6, m*6);
count = 1;
for i = i:6
    for j = 1:6
        allPersons(1+(i-1)*n:i*n,1+(j-1)*m:j*m) =reshape(faces(:,1+sum(nfaces(1:count-1))),n,m);
        count = count + 1;
    end
end

imagesc(allPersons),colormap gray

%Koristimo prvih 36 ljudi za trening podatke
trainingFaces = faces(:,1:sum(nfaces(1:36)));
avgFace =mean(trainingFaces,2);% size n*m by 1;

%Ra?unamo "eigenfaces"
X = trainingFaces-avgFace*ones(1,size(trainingFaces,2));
[U,S,V] =svd(X,"econ");

imagesc(reshape(avgFace,n,m))
imagesc(reshape(U(:,1),n,m))

testFaceMS = testFace - avgFace;
for r=[25 50 100 200 400 800 1600]
    reconFace = avgFace + (U(:,1:r)*(U(:,1:r)*testFaceMS));
    imagesc(reshape(reconFace,n,m))
end

