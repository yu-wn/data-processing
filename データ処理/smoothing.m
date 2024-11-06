% 手すりセンサデータのノイズ除去　ファイル名要修正

% ファイル選択
cd 'C:\Users\miyazakipc\Desktop\ゼミ資料用データ\1回目';
list = dir('*_force1.csv');

% 全ファイルに対して平滑化
for n = 1:length(list)
    filename = list(n).name;
    data = readtable(filename);  % 全体のデータを読み込む
    
    % 実際の列名に基づいてA列とB列を保持
    data_AB = data(:, {'Var1', 'Var2'});  % A列、B列に相当する列を保持
    
    % CからE列のデータを抽出して行列に変換
    data_D1 = data(:, {'Var3', 'Var4', 'Var5'});  % CからE列に相当する列を指定
    data_D1_array = table2array(data_D1);
    
    % 平滑化１
    data_D1_s1 = smoothdata(data_D1_array);
    
    % 平滑化後のデータをテーブルに変換
    data_D1_s1_table = array2table(data_D1_s1, 'VariableNames', data_D1.Properties.VariableNames);
    
    % A列B列と平滑化したデータを結合
    combined_data = [data_AB, data_D1_s1_table];
    
    % 新しいファイル名を作成して保存
    new_filename_s1 = strrep(filename, '.csv', '_s1.csv');
    writetable(combined_data, new_filename_s1, 'WriteVariableNames', true);
    
    % 平滑化２
    data_D1_s2 = smoothdata(data_D1_s1);
    data_D1_s2_table = array2table(data_D1_s2, 'VariableNames', data_D1.Properties.VariableNames);
    combined_data_s2 = [data_AB, data_D1_s2_table];
    new_filename_s2 = strrep(filename, '.csv', '_s2.csv');
    writetable(combined_data_s2, new_filename_s2, 'WriteVariableNames', true);
    
    % 平滑化３
    data_D1_s3 = smoothdata(data_D1_s2);
    data_D1_s3_table = array2table(data_D1_s3, 'VariableNames', data_D1.Properties.VariableNames);
    combined_data_s3 = [data_AB, data_D1_s3_table];
    new_filename_s3 = strrep(filename, '.csv', '_s3.csv');
    writetable(combined_data_s3, new_filename_s3, 'WriteVariableNames', true);
end
