clear all
clc
close all

kendallWorkersCleaned = table2cell(readtable('kendallWorkersCleaned.csv'));
types = ["<$30000","$30000 - $44999","$45000 - $59999","$60000 - $99999","$100000 - $124999","$125000 - $149999","$150000 - $199999",">$200000"];
countTypes = zeros(1,length(types));
countTotal = 0;

for i = 1:length(types)
    for j = 1 :size(kendallWorkersCleaned,1)
        if(strcmp(cell2mat(kendallWorkersCleaned(j,3)),types(i)) == true)
            countTypes(1,i) = countTypes(1,i) + cell2mat(kendallWorkersCleaned(j,2));
            countTotal = countTotal + cell2mat(kendallWorkersCleaned(j,2));
        end
    end
end

proportionsType = zeros(1,length(types));

for i = 1:length(types)
    proportionsType(1,i) = countTypes(1,i) / countTotal;
end