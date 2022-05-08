function [sigma_angle, phi_angle]=possol4(th,rs)
    theta = th(1);
    sigma = th(2);
    phi = th(3);

    epsilon = 1.0E-6;
    
    f = [rs(7)*cos(sigma)-rs(8)*cos(phi)+rs(6)*cos(theta)-rs(5); rs(7)*sin(sigma)-rs(8)*sin(phi)+rs(6)*sin(theta)]
    
    while norm(f)>epsilon
        J = [-rs(7)*sin(sigma) rs(8)*sin(phi); rs(7)*cos(sigma) -rs(8)*cos(phi)];
        dth = inv(J)*(1.0*f);
        sigma = sigma+dth(1);
        phi = phi+dth(2);
        f = [rs(7)*cos(sigma)-rs(8)*cos(phi)+rs(6)*cos(theta)-rs(5); rs(7)*sin(sigma)-rs(8)*sin(phi)+rs(6)*sin(theta)]
        norm(f)
    end
    sigma_angle = sigma;
    phi_angle = phi;
end
