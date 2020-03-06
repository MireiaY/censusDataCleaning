clear all;
clc;
close all;
format long;

kendallBlock = table2cell(readtable('Kendall_blockGroups.csv'));
censusData = table2cell(readtable('censusDataClustered2.csv'));

cont = 0;
for i = 1:size(kendallBlock,1)
    for j = 1:size(censusData,1)
        if (cell2mat(kendallBlock(i, 1))==cell2mat(censusData(j, 2)))
            cont = cont + 1;
            selectedData(cont, :) = censusData(j, :);
            break;
        end
    end
end


cont = 0;
totalPop = sum(cell2mat(selectedData(:,4)));
for i = 6:13
    cont = cont + 1;
    totalPopi(cont,1) = sum(cell2mat(selectedData(:,i)));
    totalPropPopi(cont,1) = totalPopi(cont,1) / totalPop;
end

titulos = [" <$30,000", "$30,000 - $44,999", "$45,000 - $59,999", "$60,000 - $99,999", "$100,000 - $124,999", "$125,000 - $149,999", "$150,000 - $199,999", " >$200,000"];
titulos = titulos';
totalPopPropi = [titulos,totalPopi,totalPropPopi];
writematrix(totalPopPropi,'populationProportionsKendall2.csv');

%%proporciones de la gente que vive en Kendall. Y los que trabajan¿?
