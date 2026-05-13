%Lloyd
k_max = 6;
tol = 0.0001;
err = 10000;

for k = k_min:k_max
    for i=1:10
        n = size(X,1);
        r = randperm(n,k);
        mu0 = X(r,:);

        while err >= tol
            % assignment
            z = binvar(n,k);
            c = [];
            for i = 1:n
                C = [C; sum(z(i,:)) == 1];
            end

            D = zeros(n,k);
            for i=1:n
                for j=1:k
                    D(i,j) = (X(i,:)-mu(j,:))*(X(i,:)-mu(j,:))';
                end
            end

            obj = ones(1,n)*(z.*D)*ones(k,1)
            sol = optimize(C, obj, options)
            z_new = double(z)

            % centroid
            mu_var = sdpvar(k,2)
            obj = 0
            for i=1:n
                for j=1:k
                    obj = obj + z_new(i,j)*(X(i,:)-mu(j,:))*(X(i,:)-mu_var(j,:))'
                end
            end
            sol = optimize([],obj,options)
            mu_new = double(mu_var)

            err = 0
            for i=1:k
                err = err + norm(mu_new - mu(j,:));
            end
            err = err/k
            mu = mu_new
        end
    
    end
end