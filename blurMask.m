function [ blurred ] = blurMask( mask, pos )

    if(pos)
        mask1 = padarray(mask,[1,1],'symmetric');
        mask1 = mask1(1:size(mask,1),3:size(mask1,2));
        mask2 = padarray(mask,[1,1],'symmetric');
        mask2 = mask2(3:size(mask2,1),1:size(mask,2));
        mask3 = padarray(mask,[2,2],'symmetric');
        mask3 = mask3(1:size(mask,1),5:size(mask3,2));
        mask4 = padarray(mask,[2,2],'symmetric');
        mask4 = mask4(5:size(mask4,1),1:size(mask,2));
        mask5 = padarray(mask,[3,3],'symmetric');
        mask5 = mask5(1:size(mask,1),7:size(mask5,2));
        mask6 = padarray(mask,[3,3],'symmetric');
        mask6 = mask6(7:size(mask6,1),1:size(mask,2));
    else
        mask1 = padarray(mask,[1,1],'symmetric');
        mask1 = mask1(1:size(mask,1),1:size(mask,2));
        mask2 = padarray(mask,[1,1],'symmetric');
        mask2 = mask2(3:size(mask2,1),3:size(mask2,2));
        mask3 = padarray(mask,[2,2],'symmetric');
        mask3 = mask3(1:size(mask,1),1:size(mask,2));
        mask4 = padarray(mask,[2,2],'symmetric');
        mask4 = mask4(5:size(mask4,1),5:size(mask4,2));
        mask5 = padarray(mask,[3,3],'symmetric');
        mask5 = mask5(1:size(mask,1),1:size(mask,2));
        mask6 = padarray(mask,[3,3],'symmetric');
        mask6 = mask6(7:size(mask6,1),7:size(mask6,2));
    end
    
    blurred = (4*mask+2*(mask1+mask2)+mask3+mask4+mask5+mask6)/12;
end

