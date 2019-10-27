maps=[0 0 0 0 0];

[air,air_label]=transform_prob_matrix(probs_libsvm,test_y,1);
maps(1)=calc_mean_avg_prec(air,air_label,SAMPLE_SIZE_TEST);

[bird,bird_label]=transform_prob_matrix(probs_libsvm,test_y,2);
maps(2)=calc_mean_avg_prec(bird,bird_label,SAMPLE_SIZE_TEST);

[car,car_label]=transform_prob_matrix(probs_libsvm,test_y,3);
maps(3)=calc_mean_avg_prec(car,car_label,SAMPLE_SIZE_TEST);

[horse,horse_label]=transform_prob_matrix(probs_libsvm,test_y,4);
maps(4)=calc_mean_avg_prec(horse,horse_label,SAMPLE_SIZE_TEST);

[ship,ship_label]=transform_prob_matrix(probs_libsvm,test_y,5);
maps(5)=calc_mean_avg_prec(ship,ship_label,SAMPLE_SIZE_TEST);





