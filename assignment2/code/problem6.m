%% Problem 6

%%% Loading fruit images %%%
images = [];
for i = 1:16
    img = imread('../data/data_fruit/image_'+string(i)+'.png');
    imgvec = cast(img(:),'double');
    images = [images imgvec];
end

mean = sum(images,2)/16
save("mean.mat","mean")

covariance = zeros(19200,19200,'double');
for i = 1:16
    covariance = covariance + (images(:,i)-mean)*(images(:,i)-mean).';
end
covariance = covariance/16;
save("covariance.mat","covariance");
%%
%%% PART1 %%%
[Q,D] = eigs(covariance,10);
d = diag(D)
plt = plot(d,'marker',"o");
ylabel("Eigenvalues");
xlabel("Component Number");
title("Top 10 eigenvalues of fruits");
saveas(plt,"eigenvalues","png");
save("eigenvalues.mat","d");

mean_image = reshape(mean,80,80,3);
mean_image = rescale(mean_image);

img1 = reshape(Q(:,1),80,80,3);
img1 = rescale(img1);

img2 = reshape(Q(:,2),80,80,3);
img2 = rescale(img2);

img3 = reshape(Q(:,3),80,80,3);
img3 = rescale(img3);

img4 = reshape(Q(:,4),80,80,3);
img4 = rescale(img4);

img = image([mean_image img1 img2 img3 img4])
daspect([1 1 1])
saveas(img,"fruits","png")
%%
%%% PART2 %%%
for i = 1:16
    img = imread('../data/data_fruit/image_'+string(i)+'.png');
    imgvec = cast(img(:),'double');
    imgvec = imgvec - mean;
    clst_img = (imgvec.'*Q(:,1)).*Q(:,1) + (imgvec.'*Q(:,2)).*Q(:,2) + (imgvec.'*Q(:,3)).*Q(:,3) + (imgvec.'*Q(:,4)).*Q(:,4) + mean;
    clst_img = reshape(clst_img,80,80,3);
    clst_img = rescale(clst_img);
    figure
    final_image = image([rescale(img) clst_img]);
    daspect([1 1 1]);
    drawnow
    saveas(final_image,'closest' + string(i),'png');
end
%%
%%% PART3 %%%
rng(0)
W  = randn(4,3);
A = Q(:,1:4)*diag(sqrt(d(1:4)));
X = A*W + mean;

new_fruit1 = reshape(X(:,1),80,80,3);
new_fruit1 = rescale(new_fruit1);

new_fruit2 = reshape(X(:,2),80,80,3);
new_fruit2 = rescale(new_fruit2);

new_fruit3 = reshape(X(:,3),80,80,3);
new_fruit3 = rescale(new_fruit3);

img2 = image([new_fruit1 new_fruit2 new_fruit3]);
daspect([1 1 1]);
saveas(img2,"new_fruits","png")