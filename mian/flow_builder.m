% run flow
clear all
% read the images
addpath('.\npy-matlab-master')
addpath('.\Full_Flow')

flow_mean = zeros(64,64);
ffull = [];
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
 
    for k=1:nimage-1
        string1 = [face_folder,folder_content(k,1).name];
        string2 = [face_folder,folder_content(k+1,1).name];
        frame1 = imread(string1);
        frame2 = imread(string2);
        frame1 = double(frame1);
        frame2 = double(frame2);
        forward=fullflow(frame1,frame2,ratio,maxDisp,opt);
        backward=fullflow(frame2,frame1,ratio,maxDisp,opt);
        mkdir('debug');
        removeOcclusion(forward,backward,ratio,'debug/match.txt');
        flow=runEpicflow(frame1,frame2,'debug/match.txt',opt.setting);
        flow_mean = flow_mean + flow;
    end
    flow_mean = flow_mean./nimage-1;
    
    for i=6:67
        for j=6:67
            A = flow_mean(i-5:i+5,j-5:j+5);
            A = reshape(A,1,121);
            B{i-5,j-5} = A;
        end
    end
    [m,n] = size(B);
    C = reshape(B,(m*n),1);

    for p=1:(m*n);
        D(p,:) = C{p,1};
    end
    
    
    ffull = [ffull;D];
end


writeNPY(ffull, 'flow.npy');

