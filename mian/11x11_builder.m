% run flow
clear all
% read the images
%addpath('.\npy-matlab-master')
data = [];
for f=1:nfiles
    face_folder = ['F:\corp' num2str(f) '/'];
    file_ext = '.jpg';
    out_max = 1;    
    out_min = 0;   
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fprintf ('Loading images ');
    folder_content = dir ([face_folder,'*',file_ext]);
    nimage = size (folder_content,1);
    A = [];
    B = {};
    C = {};
    D = [];
    E = [];

    for k=1:nimage
        string1 = [face_folder,folder_content(k,1).name];
        frame1 = imread(string1);
        frame1 = double(rgb2gray(frame1));
        frame1 = padarray(frame1,[4 4],0,'both');
        for i=6:67
            for j=6:67
                A = frame1(i-5:i+5,j-5:j+5);
                A = reshape(A,1,121);
                B{i-5,j-5} = A;
            end
        end
        [m,n] = size(B);
        C = reshape(B,(m*n),1);

        for p=1:(m*n);
            D(p,:) = C{p,1};
        end
        E = [E,D];    
    end

data = [data;E];

end

writeNPY(data, '11x11.npy');

