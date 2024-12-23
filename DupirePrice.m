% Option Price routine, solving Dupire Equation

function price = DupirePrice(K,T)
    % K: Strike price
    % T: Maturity
    arguments
        K (1,:) {mustBeNonzero}
        T (1,:) {mustBeNumeric}
    end
    
    % import market data
    [spot,expiries,disc_factors,forward_prices,strikes,imp_volatilities] = ETL();
    % Discout rate and dividend yield
    r = -log(disc_factors)/T;
    %q = r-1/T*log(polyval(forward_prices,T)/spot); % this is wrong
    q = zeros(1,11);

    % Dupire Solver parameters - not sure about how to set K_min,K_max
    Lt = 100; Lh = 1000; K_min = 0.01; K_max = 3.5; scheme = 'cn';
    [k,C] = solve_dupire(expiries,strikes,imp_volatilities,T,Lt,Lh,K_min,K_max,scheme);
    
    fwd_at_expiry = forward(spot,expiries,disc_factors,q,T);
    norm_strike = K/fwd_at_expiry;

    norm_price = interp1(k,C,norm_strike);
    disc_fact_at_expiry = discount(expiries,r,T);
    price = fwd_at_expiry * disc_fact_at_expiry * norm_price;
end