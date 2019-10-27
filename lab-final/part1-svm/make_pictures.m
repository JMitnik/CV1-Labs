for i=1:5
        subplot(5,11,i)
        I=reshape(test_X(air_idx(i),:),96,96,3);
        imshow(I)
    end 

for i=1:5
    subplot(5,11,6+i)
    I=reshape(test_X(air_idx(size(air_idx,1)+1-i),:),96,96,3);
    imshow(I)
end




for i=1:5
        subplot(5,11,11+i)
        I=reshape(test_X(bird_idx(i),:),96,96,3);
        imshow(I)
    end 

for i=1:5
    subplot(5,11,17+i)
    I=reshape(test_X(bird_idx(size(bird_idx,1)+1-i),:),96,96,3);
    imshow(I)
end



for i=1:5
        subplot(5,11,22+i)
        I=reshape(test_X(car_idx(i),:),96,96,3);
        imshow(I)
    end 

for i=1:5
    subplot(5,11,28+i)
    I=reshape(test_X(air_idx(size(car_idx,1)+1-i),:),96,96,3);
    imshow(I)
end



for i=1:5
        subplot(5,11,33+i)
        I=reshape(test_X(horse_idx(i),:),96,96,3);
        imshow(I)
    end 

for i=1:5
    subplot(5,11,39+i)
    I=reshape(test_X(horse_idx(size(horse_idx,1)+1-i),:),96,96,3);
    imshow(I)
end




for i=1:5
        subplot(5,11,44+i)
        I=reshape(test_X(ship_idx(i),:),96,96,3);
        imshow(I)
    end 

for i=1:5
    subplot(5,11,50+i)
    I=reshape(test_X(ship_idx(size(ship_idx,1)+1-i),:),96,96,3);
    imshow(I)
end

sgtitle('')