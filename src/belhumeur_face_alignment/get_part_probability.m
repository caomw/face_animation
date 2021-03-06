function local_prob = get_part_probability(im, local_filters, path)

    %
    addpath('../feature_representation/featureVector_edgeWeight_extraction/');
    
    %
    [filters] = model_components(local_filters);
    local_prob = cell(length(local_filters), 1);
    
    %
    feat = features(double(im), 1);
    resp = fconv(feat, filters, 1, length(filters));
    
    for i = 1:length(local_filters)
        part_resp = resp{i};
        part_resp = part_resp - (min(part_resp(:)));
        resp_sum  = sum(part_resp(:));
        part_resp = part_resp / resp_sum;
        local_prob{i} = part_resp;
        
        image_file_name = [path '/filter_responses/' num2str(i) '.jpg'];
        part_resp = mat2gray(part_resp);
        imwrite(part_resp, image_file_name)
       
    end

end

function [filters] = model_components(local_filters)
    filters = cell(length(local_filters),1);
    for i = 1:length(filters)
        filters{i} = local_filters{i}.w;
    end
end