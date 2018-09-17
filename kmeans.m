% Same-sized k-means clustering algorithm
% Uses Hungarian algorithm
% First of all, you need to change the location of file "marksheet" below
clear all;

% data, this location 
A = load('<Your download location here>\Machine_Learning\marksheet.txt');  % 42 points, k=8, d=3    

% number of points
n = size(A,1);

% number of clusters
k = 8;

% minimum size of a cluster

minimum_size_of_a_cluster = floor(n/k);


% dimension

d = size(A,2);

MSE_best = 0;

number_of_iterations_distribution = zeros(100,1);

for repeats = 1:1      % 1:100

% initial centroids

for j = 1:k
pass = 0;
while pass == 0
    i = randi(n);
    pass = 1;
    for l = 1:j-1
       if A(i,:) == C(l,:) pass = 0;
       end
    end
end
C(j,:) = A(i,:);
end

group = 0;                 
group_precious = -1;       
group_changed = 1;

kmeans_iteration_number = 0;

while ((group_changed)&&(kmeans_iteration_number<100))% kmeans iterations
    
group_precious = group;

% kmeans assignment step

% setting cost matrix for Hungarian algorithm
costMat = zeros(n);
for i=1:n
    for j = 1:n
        costMat(i,j) = (A(j,:)-C(mod(i,k)+1,:))*(A(j,:)-C(mod(i,k)+1,:))';
    end
end

% Execute Hungarian algorithm
[assignment,cost] = hungarian(costMat);

% zero group
for i = 1:n
    group(i) = 0;
end

% find current group from hungarian algorithm result
for i = 1:n 
    if assignment(i) ~= 0
            group(assignment(i))=mod(i,k)+1;
    end
end

% kmeans update step

for j = 1:k
C(j,:) = mean(A(find(group==j),:));
end


kmeans_iteration_number = kmeans_iteration_number +1

group_changed = sum(group~=group_precious);

end  % kmeans iterations


MSE = 0;
for i = 1:n
    MSE = MSE + ((A(i,:)-C(group(i),:))*(A(i,:)-C(group(i),:))')/n;
end

if (MSE<MSE_best)||(repeats==1)
    MSE_best = MSE;
    C_best = C;
    partition_best = group;
end

MSE_repeats(repeats) = MSE;

number_of_iterations_distribution(kmeans_iteration_number) = number_of_iterations_distribution(kmeans_iteration_number)+1;

end % repeats
    

% new notation

C = C_best;
group = partition_best;
MSE = MSE_best;

number_of_iterations_distribution

MSE

mean_MSE_repeats = mean(MSE_repeats)
std_MSE_repeats = std(MSE_repeats)

figure   
plot3(A(find(group==1),1),A(find(group==1),2),A(find(group==1),3),'r+');
if k>1
    hold on
    plot3(A(find(group==2),1),A(find(group==2),2),A(find(group==2),3),'rO');
end
if k>2
    hold on
    plot3(A(find(group==3),1),A(find(group==3),2),A(find(group==3),3),'rx');
end
if k>3
    hold on
    plot3(A(find(group==4),1),A(find(group==4),2),A(find(group==4),3),'b+');
end
if k>4
    hold on
    plot3(A(find(group==5),1),A(find(group==5),2),A(find(group==5),3),'bO');
end
if k>5
    hold on
    plot3(A(find(group==6),1),A(find(group==6),2),A(find(group==6),3),'bx');
end
if k>6
    hold on
    plot3(A(find(group==7),1),A(find(group==7),2),A(find(group==7),3),'g+');
end
if k>7
    hold on
    plot3(A(find(group==8),1),A(find(group==8),2),A(find(group==8),3),'gO');
end
if k>8
    hold on
    plot(A(find(group==9),1),A(find(group==9),2),A(find(group==9),3),'gx');
end
view(3), axis vis3d, box on, rotate3d on
xlabel('Database'), ylabel('Signal'), zlabel('ADS')

       



