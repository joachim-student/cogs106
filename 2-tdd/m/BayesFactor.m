classdef BayesFactor
    properties
        n
        k
        prior1
        prior2
    end
    
    methods
        function obj = BayesFactor(n, k, prior1, prior2)
            obj.n = n;
            obj.k = k;
            obj.prior1 = prior1;
            obj.prior2 = prior2;
        end
        
        function p = binomial_pdf(obj, p)
            p = nchoosek(obj.n, obj.k) * (p .^ obj.k) .* ((1 - p) .^ ...
                (obj.n - obj.k));
        end
        
        function integrand1 = integrand1(obj, p)
            integrand1 = obj.binomial_pdf(p) .* obj.prior1(p);
        end
        
        function integrand2 = integrand2(obj, p)
            integrand2 = obj.binomial_pdf(p) .* obj.prior2(p);
        end
        
        function bf = compute(obj)
            integration1 = integral(@(p) obj.integrand1(p), 0, 1);
            integration2 = integral(@(p) obj.integrand2(p), 0, 1);
            bf = integration2 / integration1;
        end
    end
end
