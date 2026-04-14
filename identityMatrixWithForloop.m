n=5
I=zeros(n)
for i=1:n
    for j=1:n
        if i==j
            I(i,j)=1;
        end
    end
end