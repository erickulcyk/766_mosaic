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
        mask7 = padarray(mask,[4,4],'symmetric');
        mask7 = mask7(1:size(mask,1),9:size(mask7,2));
        mask8 = padarray(mask,[4,4],'symmetric');
        mask8 = mask8(9:size(mask8,1),1:size(mask,2));
        mask9 = padarray(mask,[5,5],'symmetric');
        mask9 = mask9(1:size(mask,1),11:size(mask9,2));
        mask10 = padarray(mask,[5,5],'symmetric');
        mask10 = mask10(11:size(mask10,1),1:size(mask,2));
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
        mask7 = padarray(mask,[4,4],'symmetric');
        mask7 = mask7(1:size(mask,1),1:size(mask,2));
        mask8 = padarray(mask,[4,4],'symmetric');
        mask8 = mask8(9:size(mask8,1),9:size(mask8,2));
        mask9 = padarray(mask,[5,5],'symmetric');
        mask9 = mask9(1:size(mask,1),1:size(mask,2));
        mask10 = padarray(mask,[5,5],'symmetric');
        mask10 = mask10(11:size(mask10,1),11:size(mask10,2));
    end
    
    blurred = (10*mask +9*(mask1+mask2)+6*(mask3+mask4)+3*(mask5+mask6)+mask7+mask8+mask9+mask10)/50;
mend
