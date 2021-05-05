%Yale baza podataka
load allFaces.mat

%Tu spremimo sve ljude, njih 36, jer njih koristimo za trening podatke. Dohvacamo prvo lice za svaku osobu
allPersons = zeros(n*6,m*6);
count = 1;
for i=1:6
    for j=1:6
        allPersons(1+(i-1)*n:i*n,1+(j-1)*m:j*m) = reshape(faces(:,1+sum(nfaces(1:count-1))),n,m);
        count = count + 1;
    end
end
figure(1), axes ('position', [0 0 1 1]), axis off
imagesc(allPersons), colormap gray

%%

%64 su kuta osvijetljenja, stoga radimo matricu svih ekspresija 1 osobe
for person = 1:length(nfaces)
    subset = faces(:,1+sum(nfaces(1:person-1)):sum(nfaces(1:person)));
    allFaces = zeros(n*8,m*8);
    count = 1;
    for i=1:8
        for j=1:8
            if(count<=nfaces(person)) 
                allFaces(1+(i-1)*n:i*n,1+(j-1)*m:j*m) = reshape(subset(:,count),n,m);
                count = count + 1;
            end
        end
    end
    figure(2), axes ('position', [0 0 1 1]), axis off
    imagesc(allFaces), colormap gray    
end

%%

%Racunamo srednje vrijednosti svih stupaca matrice X; avgFace je velicine n*m 1
%Racunamo "eigenfaces".
%Econ jer ne zelimo cijelu 32000 * 32000 matricu, nego zelimo prvih 2410 stupaca koji odgovaraju ne-nul singularnim vrijednostima
%Prvih 64 eigenfaces, tj. prva 64 stupca matrice U, svaki stupac preoblikovali u sliku
%Svaka osoba, odnosno svaki vektor stupac matrice X je linearna kombinacija ovih eigenfaces. Average face je kombinacija svih ovih 
trainingFaces = faces(:,1:sum(nfaces(1:36)));
avgFace = mean(trainingFaces,2);  % size n*m by 1;
X = trainingFaces-avgFace*ones(1,size(trainingFaces,2));
[U,S,V] = svd(X,'econ');

figure(3), axes ('position', [0 0 1 1]), axis off
imagesc(reshape(avgFace,n,m)), colormap gray 
 
%%

%Prvih 50 Eigenfaces
for i=1:50  
    pause(0.1);  
    figure(4), axes ('position', [0 0 1 1]), axis off
    imagesc(reshape(U(:,i),n,m)); colormap gray;
end

%%

%Testiramo 37. osobu (prvo lice osobe 37 i dani eigenface)
testFace = faces(:,1+sum(nfaces(1:36))); 
figure(5), axes ('position', [0 0 1 1]), axis off
imagesc(reshape(testFace,n,m)), colormap gray
testFaceMS = testFace - avgFace;
for r=25:25:2275
    reconFace = avgFace + (U(:,1:r)*(U(:,1:r)'*testFaceMS));
    figure(6),imagesc(reshape(reconFace,n,m)), colormap gray
    title(['r=',num2str(r,'%d')]);
    pause(0.1)
end

