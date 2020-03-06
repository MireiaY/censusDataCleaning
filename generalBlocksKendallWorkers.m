clear all;
clc;
close all;

kendallBlockWorkers = table2cell(readtable('kendall_homes.csv'));
censusDataBlocksTable = (readtable('censusDataClustered2.csv'));
censusDataBlocks = table2cell(censusDataBlocksTable);
headers =["Id","Id2","Geography","Estimate Total","total","<$30000","$30000 - $44999","$45000 - $59999","$60000 - $99999","$100000 - $124999","$125000 - $149999","$150000 - $199999",">$200000","diversity","normalised_diversity"];

cont = 0;
for i = 1: size(kendallBlockWorkers,1)
    for j = 1: size(censusDataBlocks,1)
        if (cell2mat(kendallBlockWorkers(i,1)) == cell2mat(censusDataBlocks(j,2)))
            cont = cont + 1;
            mostRepeatedProfileIndex = find(cell2mat(censusDataBlocks(j,6:13))==max(cell2mat(censusDataBlocks(j,6:13))));
            if(length(mostRepeatedProfileIndex) > 1)
                mostRepeatedProfileIndex = mostRepeatedProfileIndex(randperm(length(mostRepeatedProfileIndex),1));
            end
            kendallBlockWorkersValid(cont,1:2) = kendallBlockWorkers(i,1:2);
            kendallBlockWorkersValid(cont,3) = {headers(mostRepeatedProfileIndex + 5)};
            break;
        end
    end
end

T = cell2table(kendallBlockWorkersValid);
writetable(T,'kendallWorkersCleaned.csv');