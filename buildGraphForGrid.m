function [ V, E3, node1, node2, node3, node4 ] = buildGraphForGrid( dims, weights, coords1, coords2, coords3, coords4)
    i=1;
    V = zeros(dims(1)*dims(2),2);
    E3 = zeros(8+6*(dims(1)+dims(2)-4)+4*(dims(1)-2)*(dims(2)-2),3);
    for x=1:(dims(2)-1)
        for y=1:(dims(1)-1)
            %set up the node coordinate matrices and the edge connections
            n = (x-1)*dims(1)+y;
            E3(i,:) = [n,n+dims(1),weights(y,x+1)];
            E3(i+1,:) = [n+dims(1),n,weights(y,x)];
            E3(i+2,:) = [n,n+1,weights(y+1,x)];
            E3(i+3,:) = [n+1,n,weights(y,x)];
            i=i+4; 
        end
        %handle edge of grid separately
        n = x*dims(1);
        n2 = (x+1)*dims(1);
        E3(i,:) = [n,n2,weights(dims(1),x+1)];
        E3(i+1,:) = [n2,n,weights(dims(1),x)];
        i=i+2;
    end
    %handle edge of grid separately
    for y=1:(dims(1)-1)
        n = dims(1)*(dims(2)-1)+y;
        E3(i,:) = [n,n+1,weights(y+1,dims(2))];
        E3(i+1,:) = [n+1,n,weights(y,dims(2))];
        i=i+2;
    end
    n=1;
    node1=0;
    node2=0;
    node3=0;
    node4=0;
    for x=1:dims(2)
        for y=1:dims(1)
            V(n,:) = [y,x];
            
            %make sure we have the indexes to the four nodes
            if x==coords1(2)
                if y==coords1(1)
                    node1 = n;
                end
            end
            if x==coords2(2)
                if y==coords2(1)
                    node2 = n;
                end
            end
            if x==coords3(2)
                if y==coords3(1)
                    node3 = n;
                end
            end
            if x==coords4(2)
                if y==coords4(1)
                    node4 = n;
                end
            end
            n = n+1;
        end
    end
end

