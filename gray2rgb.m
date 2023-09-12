for number = 1: 5
    %% 讀檔
    if number == 1
        RGB=imread('Lighthouse_CFA.bmp');
        name='Lighthouse_RGB'
    elseif number == 2
        RGB=imread('Flower_CFA.bmp');
        name='Flower_RGB'
    elseif number == 3
        RGB=imread('Fall_CFA.bmp');
        name='Fall_RGB'
    elseif number == 4
        RGB=imread('Child_CFA.bmp');
        name='Child_RGB'
    elseif number == 5
        RGB=imread('Ballon_CFA.bmp');  
        name='Ballon_RGB'
    end
    gray = imread('GrayCard_CFA.bmp');
    %% 去馬賽克
    RGB1 = demosaic(RGB,'bggr');
    %% 圖片的RGB
    R = RGB1(:,:,1);
    G = RGB1(:,:,2);
    B = RGB1(:,:,3);
    %% 灰卡的RGB都除255
    gray_B = double(gray(1,1))/255;
    gray_G = double(gray(2,1))/255;
    gray_R = double(gray(2,2))/255;
    %% 灰卡的RGB乘三個係數等於1
    B_coe = 1/gray_B;
    G_coe = 1/gray_G;
    R_coe = 1/gray_R;
    %% unit8 轉成Double
    R1 = double(R);
    G1 = double(G);
    B1 = double(B);
    %% 算白平衡的RGB
    R_w = (R1*R_coe)/255;
    G_w = (G1*G_coe)/255;
    B_w = (B1*B_coe)/255;
    %% RGB轉XYZ
    X = R_w*0.6595 + G_w*0.292 + B_w*0.1469;
    Y = R_w*0.2720 + G_w*0.797 + B_w*0.0516;
    Z = R_w*0 + G_w*0.0390 + B_w*0.9232;
    %% XYZ轉linearRGB
    lR = 3.06*X + -1.4*Y + -0.4759*Z;  
    lG = -0.9695*X + 1.8763*Y + 0.0415*Z; 
    lB = 0.0588*X + -0.2115*Y + 1.07*Z; 
    %% linearRGB轉nonlinearRGB
    nlR=255*lR.^(1/2.2);
    nlB=255*lB.^(1/2.2);
    nlG=255*lG.^(1/2.2);
    lRGB = cat(3, uint8(nlR), uint8(nlG), uint8(nlB));
    figure(number)
    imshow(lRGB)
    print('-dbmp',name)
end
