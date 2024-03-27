% Y matrix Calculation

function Y = Y_Mat_Calc(SIZE,TL_data,TR_data)

    Y = zeros(SIZE);
    
    for i = 1:SIZE          % Diagonal elements
        for j = 1:SIZE
            if i==j
                for k = 1:SIZE
                    if complex(TL_data(i,1,k),TL_data(i,2,k)) ~= 0
                        Y(i,j) = Y(i,j) + 1/complex(TL_data(i,1,k),TL_data(i,2,k));
    
                    elseif complex(TR_data(i,1,k),TR_data(i,2,k)) ~= 0
                        Y(i,j) = Y(i,j) + 1/complex(TR_data(i,1,k),TR_data(i,2,k));
    
                    elseif complex(TL_data(i,1,k),TL_data(i,2,k)) ~= 0 && complex(TR_data(i,1,k),TR_data(i,2,k)) ~= 0
                        Y(i,j) = Y(i,j) + 1/complex(TL_data(i,1,k),TL_data(i,2,k)) + 1/complex(TR_data(i,1,k),TR_data(i,2,k));
                    end
                    Y(i,j) = Y(i,j) + complex(TL_data(i,3,k),TL_data(i,4,k))/2;
                end
    
            else          % Off-diagonal elements
                if complex(TL_data(i,1,j),TL_data(i,2,j)) ~= 0
                    Y(i,j) = -(1/complex(TL_data(i,1,j),TL_data(i,2,j)));
    
                elseif complex(TR_data(i,1,j),TR_data(i,2,j)) ~= 0
                    Y(i,j) = -(1/complex(TR_data(i,1,j),TR_data(i,2,j)));
    
                elseif complex(TL_data(i,1,j),TL_data(i,2,j)) ~= 0 && complex(TR_data(i,1,j),TR_data(i,2,j)) ~= 0
                    Y(i,j) = -(1/complex(TL_data(i,1,j),TL_data(i,2,j)) + 1/complex(TR_data(i,1,j),TR_data(i,2,j)));
    
                else
                    Y(i,j) = 0;
                end
            end
        end
    end
end