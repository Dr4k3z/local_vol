% Extract - Transform - Load

function [spot,expiries,disc_factors,forward_prices,strikes,imp_volatilities] = ETL(filename)
    % read the input from the filename
    % default value if market_data.xlsx

    arguments
        filename (1,1) string = 'market_data.xlsx'
    end
    
    data = readtable(filename);
    
    spot = 3566.38;
    
    expiries = data(2,2:12).Variables; %expiries = [0,expiries];
    disc_factors = data(3,2:12).Variables; %disc_factors = [1,disc_factors];
    forward_prices = data(4,2:12).Variables; %forward_prices = [spot,forward_prices];
    
    strikes = zeros(7,11);
    imp_volatilities = zeros(7,11);
    for i=1:7
        for j=1:11
            strikes(i,j) = data(19+i,1+j).Variables;
            imp_volatilities(i,j) = data(8+i,1+j).Variables;
        end
    end
end
