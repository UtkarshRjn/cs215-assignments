%% Problem 5

%%% Loading 60000 training set and labels %%%
data = load('../data/mnist.mat');
images = getfield(data,'digits_train');
float_images = cast(images,'double');
labels = getfield(data,'labels_train');

%%% Visuallisation of images %%%
% imshow(float_images(:,:,1));
% isfloat(float_images);
%%
for i = 0:9
    image_indices = find(labels==i);
    images = float_images(:,:,image_indices);
    
    %%% PART1 %%%
    [ndim_images,U,mean] = pca_transform(images,84);
%     save("84dim_basis_digit_" + string(i) + ".mat" , "ndim_images")
    
    %%% PART2 %%%
    pca_images = reconstruct(ndim_images,U,mean);
    
    figure
    img = imagesc([images(:,:,1) pca_images(:,:,1)]);
    drawnow
    daspect([1 1 1])
    saveas(img,string(i),'jpg');
end
%% 
% Algorithmn for regenerating/reconstructing the image

function y = reconstruct(images,U,mean)
    dim = size(images);
    freq = dim(2);
    Y = U*images + mean;
    y = reshape(Y,28,28,freq);
end
%% 
% Function to compute 84-dimensional basis

function [y,U,mean] = pca_transform(images,n)
    dim = size(images);
    freq = dim(3);
    imgvec = reshape(images,dim(1)*dim(1),freq);
    
    mean = sum(imgvec,2)/freq;
    imgvec_centered = (imgvec - mean);
    
    covariance = zeros(28*28,28*28);
    for j = 1:freq
        covariance = covariance + imgvec_centered(:,j)*imgvec_centered(:,j).';
    end
    covariance = covariance./freq;
    
    [Q,D] = eig(covariance);
    [~,ind] = sort(diag(D),'descend');
    ind = ind(1:n);
    U = Q(:,ind);
    
    y = U.'*imgvec_centered
end