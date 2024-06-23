% Y matrix Calculation

function Y = Y_Mat_Calc(SIZE,L_data)

    Y = zeros(SIZE);
    
    for i = 1:SIZE          % Diagonal elements
        for j = 1:SIZE
            if i==j
                for k = 1:SIZE
                    if complex(L_data(i,1,k),L_data(i,2,k)) ~= 0
                        Y(i,j) = Y(i,j) + 1/complex(L_data(i,1,k),L_data(i,2,k));
                    end
                    Y(i,j) = Y(i,j) + complex(L_data(i,3,k),L_data(i,4,k))/2;
                end
    
            else          % Off-diagonal elements
                if complex(L_data(i,1,j),L_data(i,2,j)) ~= 0
                    Y(i,j) = -(1/complex(L_data(i,1,j),L_data(i,2,j)));
                else
                    Y(i,j) = 0;
                end
            end
        end
    end
end


