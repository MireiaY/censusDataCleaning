clear all;
clc;
close all;

gamaBlockGroups = table2cell(readtable('tl_2015_25_bg_msa_14460_MAss_TOWNS_Neighb.csv'));
%%clear data
cont = 2;
gamaBlockGroupsCleared(1,:) = gamaBlockGroups(1,:);
for i = 2:size(gamaBlockGroups,1)
    repetido = false;
    for j = 1:size(gamaBlockGroupsCleared,1)
        if(strcmp(char(gamaBlockGroups(i,5)), char(gamaBlockGroupsCleared(j,5))))==true
            repetido = true;
            break;
        end
    end
    if repetido == true
    else
        gamaBlockGroupsCleared(cont,:) = gamaBlockGroups(i,:);
        cont = cont + 1;
    end
end

censusData = table2cell(readtable('censusData.csv'));

selectedData(1, :) = censusData(1, :);
cont = 1;
for i = 1:size(gamaBlockGroupsCleared,1)
    for j = 1:size(censusData,1)
        if strcmp(char(gamaBlockGroupsCleared(i, 5)),char(censusData(j, 2)))==true
            cont = cont + 1;
            selectedData(cont, :) = censusData(j, :);
            break;
        end
    end
end

selectedDataWOMArgin = selectedData(:,[1,2,3,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36]);
selectedDataClustered = selectedDataWOMArgin(:,1:4);

for i = 2: size(selectedDataWOMArgin,1)
    matrix(i - 1, 1) = {str2double(cell2mat(selectedDataWOMArgin(i,4)))};
    matrix(i - 1, 2) = {(str2double(cell2mat(selectedDataWOMArgin(i,5))) + str2double(cell2mat(selectedDataWOMArgin(i,6))) + str2double(cell2mat(selectedDataWOMArgin(i,7))) + str2double(cell2mat(selectedDataWOMArgin(i,8)))) + str2double(cell2mat(selectedDataWOMArgin(i,9)))};
    matrix(i - 1, 3) = {str2double(cell2mat(selectedDataWOMArgin(i,10))) + str2double(cell2mat(selectedDataWOMArgin(i,11))) + str2double(cell2mat(selectedDataWOMArgin(i,12)))};
    matrix(i - 1, 4) = {str2double(cell2mat((selectedDataWOMArgin(i,13)))) + str2double(cell2mat(selectedDataWOMArgin(i,14)))};
    matrix(i - 1, 5) = {str2double(cell2mat((selectedDataWOMArgin(i,15)))) + str2double(cell2mat(selectedDataWOMArgin(i,16)))};
    matrix(i - 1, 6) = {str2double(cell2mat((selectedDataWOMArgin(i,17))))};
    matrix(i - 1, 7) ={ str2double(cell2mat(selectedDataWOMArgin(i,18)))};
    matrix(i - 1, 8) = {(str2double(cell2mat(selectedDataWOMArgin(i,19))))};
    matrix(i - 1, 9) = {(str2double(cell2mat(selectedDataWOMArgin(i,20))))};
    
    diversity = 0;
    prop = 0;
    for j = 2 : 9
        if (cell2mat(matrix(i - 1,1))) == 0
        else
            prop = (cell2mat(matrix(i - 1, j))) / (cell2mat(matrix(i - 1,1)));
            if prop == 0
            else
                diversity = diversity + prop*log(prop);
            end
        end
    end
    diversity = - diversity;
    matrix(i - 1, 10) = {diversity};

end

maxDiver = max((cell2mat(matrix(:,10))));
minDiver = min((cell2mat(matrix(:,10))));

for i = 1:size(matrix,1)
    matrix(i, 11) = {((cell2mat(matrix(i,10))) - minDiver) / (maxDiver - minDiver)};
end

titulos = cellstr(["total"," < $30,000", "$30,000 - $44,999", "$45,000 - $59,999", "$60,000 - $99,999", "$100,000 - $124,999", "$125,000 - $149,999", "$150,000 - $199,999", ">$200,000", "diversity", "normalised_diversity"]);
selectedDataClustered(1,5:15) = titulos;
selectedDataClustered(2:size(selectedDataClustered,1),5:15) = matrix;

T = cell2table(selectedDataClustered(2:end,:),'VariableNames',selectedDataClustered(1,:));
writetable(T,'censusDataClustered2.csv');

