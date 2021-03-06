function [p,pRT, err_measure, regModel] = test_main()

    %
    load('/home/mallikarjun/projects/face_animation/src/feature_representation/featureVector_edgeWeight_extraction/face_p99.mat');
    load('/home/mallikarjun/data/face_animation/Faces5000/intermediate_results/bounding_boxes.mat');
    load('/home/mallikarjun/data/face_animation/Faces5000/intermediate_results/facemap.mat');
    addpath('/home/mallikarjun/projects/face_animation/src/feature_representation/featureVector_edgeWeight_extraction/');
    
   
    
    %
    [IM, BB, IsT, bboxes, posemap] = get_test_file();

    %
%     testFile = './face_animation_data/face_animation_test.mat';
%     load(testFile,'IsT','bboxes');

    %% LOAD PRE-TRAINED RCPR model
    load('models/rcpr_COFW.mat','regModel','regPrm','prunePrm');
    nfids=87/3;
    
    %% TEST
    
    %Initialize randomly using RT1 shapes drawn from training
    RT1=5;
    p=shapeGt('initTest',IsT,bboxes,regModel.model,...
        regModel.pStar,regModel.pGtN,RT1);
    %Create test struct
    testPrm = struct('RT1',RT1,'pInit',bboxes,...
        'regPrm',regPrm,'initData',p,'prunePrm',prunePrm,...
        'verbose',1);
    %Test
    t=clock;[p,pRT] = rcprTest(IsT,regModel,testPrm);t=etime(clock,t);


    % Use threshold computed during training to 
    % binarize occlusion
    
    p(:,1:nfids*2)=round(p(:,1:nfids*2));
    occl=p(:,(nfids*2)+1:end);
    occl(occl>=regModel.th)=1;occl(occl<regModel.th)=0;
    p(:,(nfids*2)+1:end)=occl;
    %Compute loss
    fprintf('--------------DONE\n');
    
    
    %% VISUALIZE Example results on a test image
%     figure(3),clf,
%     n = size(p, 1);
%     %Ground-truth
%     subplot(1,2,1),
%     shapeGt('draw',regModel.model,IsT{nimage},phisT(nimage,:),{'lw',20});
%     title('Ground Truth');
    %Prediction
    
    n = size(p, 1);
    fig_h = figure;
    err_measure = [];
    for i=1:n
        err_measure = [err_measure; get_error(p(i,:), BB{i})];
        
        subplot(1,2,1);
        h =shapeGt('draw',regModel.model,IsT{i},p(i,:),{'lw',20});
        subplot(1,2,2);
        showboxes(IM{i}, BB{i}, posemap);
        
        image_file_name =  ['/home/mallikarjun/data/face_animation/rcpr_data/fitting_comp_results/' num2str(i) '.jpg'];
        saveas(fig_h, image_file_name);
        
        pause;
       clf;
    end
    
    hist(err_measure, 10);
    
end

function err_measure = get_error(p, BB)

    %
    fid = fopen('/home/mallikarjun/data/face_animation/rcpr_data/rcpr_true_common_fids.txt', 'r');
    ind=textscan(fid, '%u %u', 'HeaderLines', 1);
    burgos = ind{1};
    deva = ind{2};
    
    t1 = [ [(BB.xy(deva,1)+BB.xy(deva,3))/2]' [(BB.xy(deva,2)+BB.xy(deva,4))/2]' ];
    t2 = [ p(1,burgos) p(1,burgos) ];
    t = [t1; t2];
    
    %
    err_measure = pdist(t)/size(t1,2);

end



function [IM, BB, IsT, bboxes, posemap] = get_test_file()

    %
    load('/home/mallikarjun/projects/face_animation/src/feature_representation/featureVector_edgeWeight_extraction/face_p99.mat');
    load('/home/mallikarjun/data/face_animation/Faces5000/intermediate_results/bounding_boxes.mat');
    load('/home/mallikarjun/data/face_animation/Faces5000/intermediate_results/facemap.mat');
    
    %
    number_of_samples = 20;
    posemap = 90:-15:-90;
    
    eye_glass_list =  [802; 2316; 2096; 4083; 469; 2960; 649; 335; 3798; 2378; 3689; 1509];
    number_of_samples = size(eye_glass_list,1);
    
    %
    IM = cell(number_of_samples,1);
    BB = cell(number_of_samples,1);
    IsT = cell(number_of_samples,1);
    bboxes = zeros(number_of_samples,4);
    
    j=1;
    for i=1:number_of_samples
        
        if(isempty(bounding_boxes{j}) == 1)
            continue
        end
        
        j = eye_glass_list(i,1);

        if(j==469)
            disp('asdfasd');
        end
        IM{i,1}         = imread(facemap{j});
        IsT{i,1}         = imread(facemap{j});
        BB{i,1}         = bounding_boxes{j};
        x1 = min(bounding_boxes{j}.xy(:,1));
        y1 = min(bounding_boxes{j}.xy(:,2));
        x2 = max(bounding_boxes{j}.xy(:,3));
        y2 = max(bounding_boxes{j}.xy(:,4));
        bboxes(i,:)     = [x1 y1 (x2-x1) (y2-y1)];  
        j = j + 1;
        
%         IM{j,1}         = imread(facemap{j});
%         IsT{j,1}         = imread(facemap{j});
%         BB{j,1}         = bounding_boxes{j};
%         x1 = min(bounding_boxes{j}.xy(:,1));
%         y1 = min(bounding_boxes{j}.xy(:,2));
%         x2 = max(bounding_boxes{j}.xy(:,3));
%         y2 = max(bounding_boxes{j}.xy(:,4));
%         bboxes(j,:)     = [x1 y1 (x2-x1) (y2-y1)];  
%         j = j + 1;
    end
    

end
