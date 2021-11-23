%% Problem 4

%%% Loading 60000 training set and labels %%%
data = load('../data/mnist.mat');
images = getfield(data,'digits_train');
float_images = cast(images,'double');
labels = getfield(data,'labels_train');

%%% Visuallisation of image %%%
% imagesc(float_images(:,:,1))
% daspect([1 1 1]);
%%
for i = 0:9
    ind_i = find(labels==i);
    images_i = float_images(:,:,ind_i);
    imgvec_i = reshape(images_i,28*28,[]);
    freq = size(imgvec_i,2);
    
    %%% PART 1 %%%%
    % (i)
    % mean calulation:   E[X]
    mean_i = sum(imgvec_i,2)/freq
%     save("mean_" + string(i) + ".mat","mean_i");
    
    % (ii)
    % covariance calculation:  E[XX^T] - E[X](E[X])^T
    C_i = zeros(28*28,28*28);
    for j = 1:freq
        C_i = C_i + (imgvec_i(:,j)-mean_i)*(imgvec_i(:,j)-mean_i).';
    end
    C_i = C_i./freq
%     save("covariance_" + string(i) + ".mat","C_i");    
    
%     (ii)
%     Principal mode of variation
    [Q,D] = eig(C_i);
    [d,ind] = sort(diag(D),'descend');
    lambda = d(1)
    v = Q(:,ind(1))
%     save("lambda1_" + string(i) + ".mat","lambda");
%     save("v1_" + string(i) + ".mat","v");
    
    figure
    %%%% PART 2 %%%
    plot(d,'Marker',"o");
    hold on;
    y = lambda/100.*ones(784,1);
    x = 1:784;
    plt = plot(x,y,'LineWidth',1,'LineStyle',"--");
    hold off;
%     set(gca, 'YScale', 'log')
    xlim([0,100]);
    xlabel('Dimension of Image Vector')
    ylabel('Eigenvalues of the cov. matrix of digit ' + string(i))
    drawnow;
    saveas(plt,'plot' + string(i),'jpg');

    significant_mode_of_var =  sum(d>lambda/100)
    
    %%% PART 3 %%%
    % (i)
    img1 = reshape(mean_i - sqrt(lambda).*v,28,28);
    
    % (ii)
    img2 = reshape(mean_i,28,28);

    % (iii)
    img3 = reshape(mean_i + sqrt(lambda).*v,28,28);
    
    figure;
    img = imagesc([img1 img2 img3]);
    drawnow;
    daspect([1 1 1]);
    saveas(img,string(i),'jpg');
end
%% 