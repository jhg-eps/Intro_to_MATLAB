
enrollment = [
% Year	
1995	1996	1997	1998	1999	2000	2001	2002	2003	2004	2005	2006	2007	2008	2009	2010	2011	2012	2013	2014
% UM	
9996	9928	9213	9451	9945	10282	10698	11135	11222	11358	11435	11797	11912	11818	11867	11501	11168	10901	11247	11286
% UMA	
6023	5496	5248	5130	5612	5617	5575	5722	5943	5538	5494	5257	5101	4974	5054	5074	4974	4990	4770	4664
% UMF	
2510	2512	2446	2507	2479	2413	2435	2395	2420	2349	2452	2424	2265	2227	2238	2322	2269	2179	2061	1960
% UMFK	
731	767	690	827	926	886	897	827	924	1076	1193	1339	1269	1102	1126	1073	1080	1169	1209	1327
% UMM	
856	915	884	899	908	927	1017	1068	1313	1191	1149	1259	1093	1023	964	951	863	925	892	810
% UMPI	
1278	1347	1307	1344	1378	1427	1367	1560	1546	1652	1548	1655	1533	1455	1436	1434	1453	1463	1263	1138
% USM	
9721	9966	10230	10462	10645	10820	10966	11382	11007	11089	10974	10478	10453	10009	9655	9654	9301	9385	8923	8428
];

%%%%%%%%%%%%%%%% PROBLEM 1 %%%%%%%%%%%%%%%%%%%%%%
enrollprime = enrollment';
% enrollmentprime looks like:
%         1  2   3    4   5   6    7
%        UM UMA UMF UMFK UMM UMPI USM
%   yr1
%   yr2
yr_begin = num2str(enrollment(1,1));
yr_end = num2str(enrollment(1,end));
yr_bn = str2num(yr_begin);
yr_en = str2num(yr_end);
base_str = 'Enrollment in UMaine Campuses, ';
through = ' through ';
super_string = strcat(base_str, yr_begin, '-', yr_end);
enrollprime(:,1) = [];  % get rid of the years column;
       %numbering of columns
bar(yr_bn:yr_en, enrollprime, 0.5, 'stack');
title(super_string);
xlabel('Year');
ylabel('Total Enrollment (Thousands)');
legend('UM', 'UMA', 'UMF', 'UMFK', 'UMM', 'UMPI', 'USM');
xlim([(yr_bn - 1) (yr_en + 1)]);
grid on

%%%%%%%%%%%%%%%% PROBLEM 2 %%%%%%%%%%%%%%%%%%%%%%
% enrollmentprime looks like:
%         1  2   3    4   5   6    7
%        UM UMA UMF UMFK UMM UMPI USM
%   yr1
%   yr2
%   yr3
num_years = length(enrollprime(:,1));
total_enrollment = zeros(num_years,1);
years = enrollment(1,:)';

for i = 1:num_years
  total_enrollment(i,1) = sum(enrollprime(i,:)) ;
end
total_enrollment(:,1);   % total enrollment each of the 20 years
um_perc = (100)*enrollprime(:,1)./total_enrollment(:,1);
usm_perc = (100)*enrollprime(:,7)./total_enrollment(:,1); %elementwise division
plot(years,um_perc,'ro--',years,usm_perc,'m^:');
grid on
ylabel('Percentage of System Total (%)');
xlabel('Year');
legend('UMaine','USM');

% %%%%%%%%%%%%%%%% PROBLEM 3 %%%%%%%%%%%%%%%%%%%%%%
%   enrollmentprime looks like:
%         1  2   3    4   5   6    7
%        UM UMA UMF UMFK UMM UMPI USM
%   yr1
%   yr2
%   yr3

[axes, han_bar, han_line] = plotyy(years,enrollprime./1000,years,[um_perc usm_perc],'bar','plot');
set(han_bar,'BarLayout', 'stacked');
set(han_line(1), 'LineStyle', '--', 'Marker', 'o', 'Color', 'g', 'LineWidth', 2);
set(han_line(2), 'LineStyle', ':', 'Marker', 'o', 'Color', 'k', 'LineWidth', 2);
ylabel(axes(1),'Enrollment (in thousands)', 'FontSize', 14) % label left y-axis
ylabel(axes(2),'Percentage of Total Enrollment (%)', 'FontSize', 14) % label right y-axis
xlabel(axes(1),'Years') % label x-axis

ylim(axes(1), [0, 35]);
set(axes(1),'YTick',0:5:35);
set(axes(1), 'XLim', [(yr_bn - 1) (yr_en + 1)]);
set(axes(2), 'XLim', [(yr_bn - 1) (yr_en + 1)]);
set(axes(2), 'XTick', []);
ylim(axes(2), [25, 55]);
set(axes(2), 'YTick', []);
set(axes(2),'YLim', [25 40]);
set(axes(2), 'YTick',25:3:40);
legend('UM', 'UMA', 'UMF', 'UMFK', 'UMM', 'UMPI', 'USM','UMaine Perc.', 'USM Perc.','Location','NorthOutside','Orientation','horizontal');
grid on;
% 
% %%%%%%%%%%%%%%%% PROBLEM 4 %%%%%%%%%%%%%%%%%%%%%%

umaine_enroll = enrollment(2,:);
grid on;
bar(yr_bn:yr_en, umaine_enroll, 0.8);
xlim([(yr_bn - 1) (yr_en + 1)]);
umaine_enroll_diff = diff(umaine_enroll) % STARTS AT yr_bn + 1!!!
years_prime = years(2:end);  % now appropriate for the "diff" data.
diff_length = length(umaine_enroll_diff(1,:));

for i=1:diff_length;
    rel_diff(1,i) = 100*umaine_enroll_diff(1,i)./umaine_enroll(1,i)
end

[axes, han_bar, han_line] = plotyy(years,umaine_enroll./1000, years_prime, [rel_diff],'bar','plot');
set(han_line(1), 'LineStyle', '--', 'Marker', 'o', 'Color', 'r', 'LineWidth', 2);
set(han_bar(1),'FaceColor','g','EdgeColor','g');
set(axes(2), 'XTick', []);
ylabel(axes(1),'Enrollment (in thousands)', 'FontSize', 14) % label left y-axis
ylabel(axes(2),'Year over Year Growth (%)', 'FontSize', 14) % label right y-axis
xlabel(axes(1),'Years') % label x-axis

ylim(axes(1), [9, 12]);
set(axes(1),'YTick',9:0.5:12);
set(axes(1), 'XLim', [(yr_bn - 1) (yr_en + 1)]);
set(axes(2), 'XLim', [(yr_bn - 1) (yr_en + 1)]);
set(axes(2), 'XTick', []);
ylim(axes(2), [-10, 10]);
legend('UM Enrollment', 'UM YoY Growth','Location','NorthOutside','Orientation','horizontal');
grid on;

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%