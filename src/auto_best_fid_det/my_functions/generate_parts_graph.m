function h_m_p = generate_parts_graph(mean_err_1, mean_err_2 )
    h_m_p = figure;
    subplot(4,5,1);
    generate_bar_graph(mean_err_1(1, :), mean_err_2(1, :), 'Right eyebrow right corner'); 
    subplot(4,5,2);
    generate_bar_graph(mean_err_1(2, :), mean_err_2(2, :), 'Right eyebrow center'); 
    subplot(4,5,3);
    generate_bar_graph(mean_err_1(3, :), mean_err_2(3, :), 'Right eyebrow left corner'); 
    subplot(4,5,4);
    generate_bar_graph(mean_err_1(4, :), mean_err_2(4, :), 'Left eyebrow right corner'); 
    subplot(4,5,5);
    generate_bar_graph(mean_err_1(5, :), mean_err_2(5, :), 'Left eyebrow center'); 
    subplot(4,5,6);
    generate_bar_graph(mean_err_1(6, :), mean_err_2(6, :), 'Left eyebrow left corner'); 
    subplot(4,5,7);
    generate_bar_graph(mean_err_1(7, :), mean_err_2(7, :), 'Nose tip top'); 
    subplot(4,5,8);
    generate_bar_graph(mean_err_1(8, :), mean_err_2(8, :), 'Nose tip right'); 
    subplot(4,5,9);
    generate_bar_graph(mean_err_1(9, :), mean_err_2(9, :), 'Nose tip bottom'); 
    subplot(4,5,10);
    generate_bar_graph(mean_err_1(10, :), mean_err_2(10, :), 'Nose tip left'); 
    subplot(4,5,11);
    generate_bar_graph(mean_err_1(11, :), mean_err_2(11, :), 'Right eye right corner'); 
    subplot(4,5,12);
    generate_bar_graph(mean_err_1(12, :), mean_err_2(12, :), 'Right eye left corner'); 
    subplot(4,5,13);
    generate_bar_graph(mean_err_1(13, :), mean_err_2(13, :), 'Left eye right corner'); 
    subplot(4,5,14);
    generate_bar_graph(mean_err_1(14, :), mean_err_2(14, :), 'Left eye left corner'); 
    subplot(4,5,15);
    generate_bar_graph(mean_err_1(15, :), mean_err_2(15, :), 'Lip right extreme corner'); 
    subplot(4,5,16);
    generate_bar_graph(mean_err_1(16, :), mean_err_2(16, :), 'Upper lip top'); 
    subplot(4,5,17);
    generate_bar_graph(mean_err_1(17, :), mean_err_2(17, :), 'Lip left extreme corner'); 
    subplot(4,5,18);
    generate_bar_graph(mean_err_1(18, :), mean_err_2(18, :), 'Lower lip bottom'); 
    subplot(4,5,19);
    generate_bar_graph(mean_err_1(19, :), mean_err_2(19, :), 'Lower lip top'); 
    subplot(4,5,20);
    generate_bar_graph(mean_err_1(20, :), mean_err_2(20, :), 'Lower lip bottom'); 
end
