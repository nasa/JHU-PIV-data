% This code outputs high quality TKE plot for pubulication


% define normalized parameters
normvel = 11.47; % tip speed of the Nasa pump at 480rpm. 
normvor = 1./(2*pi*8); % Angular velocity of the Nasa pump at 480rpm. 
normTKE = 1./(11.4*11.4);  % UTUT for turbulence normalization

% define font size and font name
font_size = 15;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [-.1,0.18];
y_lim = [0.80,1.005];


%define vector plot parameters
z_skip = 1;
r_skip = 1;  % define skips for vector plots
vector_length =2.5;
vector_linewidth = 0.1; 

% define figure position and size
fig = figure;
fig.Position = [100,0,1200,900];

% start with pseudo color plots
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.TKE.*normTKE);
shading interp
% caxis([-.002,0.08]);
caxis([0,0.05]);
axis equal
colormap(jet);
hold on


mina = min(all_data.vor_mean(:));
maxa = max(all_data.vor_mean(:));
levelmin = linspace(mina,-0.001,5);
levelmax = linspace(0,maxa,8);
levelmax = levelmax(2:end);

% contour(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.vor_mean*normvor,[7,7]),'Color',[0.6,0.6,0.6],'LevelListMode','manual',...
%      'LineWidth',1,'LevelList',levelmin,'LineStyle','--');
contour(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.vor_mean.*normvor,[1,1]),'ShowText','on','Color',[0.6,0.6,0.6],'LevelListMode','manual',...
     'LineWidth',1,'LevelList',[-50:5:-1],'LineStyle','--');
hold on

% contour(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.vor_mean.*normvor,[5,7]),'Color',[0.6,0.6,0.6],'LevelListMode','manual',...
%     'LineWidth',1,'LevelList',[0:25:200]);
contour(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.vor_mean.*normvor,[5,7]),'ShowText','on','LineColor',[0,0,0],'LevelListMode','manual',...
    'LineWidth',0.8,'LevelList',[0:25:200],'LineStyle','-','LabelSpacing',1000,'LineWidth',0.7);
hold on


xlim(x_lim);
ylim(y_lim);

title(all_data.Test_condition)
xlabel('z/c_{A}','FontSize',18,'FontName',font_name,'FontWeight','bold')
ylabel('r/L','FontSize',18,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1):0.04:x_lim(2);
ax.YTick = y_lim(1):0.05:y_lim(2);
ax.FontSize = 15;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.Box = 'off';
ax.LineWidth = 1.5;
ax_pos = ax.Position;
g_Zmesh = (all_data.norm_Zmesh-x_lim(1))./(x_lim(2)-x_lim(1))+ax_pos(1);
dz = abs(g_Zmesh(1,1)-g_Zmesh(1,2));
hold on



% Add vector plots
% f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
%     all_data.Vz_mean(1:r_skip:end,1:z_skip:end),all_data.Vr_mean(1:r_skip:end,1:z_skip:end),...
%     'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',00.5);
% hold on


% Add mask
g = plot(all_data.norm_Zmask(1:1:end),all_data.norm_Rmask(1:1:end),'.r','Color', [0.5,0.5,0.5]);


% Add colorbar
% h  = colorbar('northoutside');
h  = colorbar('eastoutside');
% h.Position(1) = h.Position(1)+0.05;
% h.Position(2) = h.Position(2)+0.03;
% h.Position(3) = h.Position(3)-0.05;
% h.Position(4) = h.Position(4)/2;
% Add annotation
text(x_lim(2)+0.035,y_lim(1)+(y_lim(2)-y_lim(1))/2,['k^{*}' '/' 'U_{T}^{2}'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');

% Add reference vector
% text(x_lim(2)-0.012,y_lim(2)+(y_lim(2)-y_lim(1))/40,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.04,h.Position(1)+h.Position(3)+0.04+dz*vector_length*z_skip],...
%     [h.Position(2)+h.Position(4)+0.011,h.Position(2)+h.Position(4)+0.011],'HeadStyle','vback3','HeadWidth',5)
% 
%  text(0.083,0.81,'PS','Color','w','FontWeight','bold','FontSize',18);

% Add PS annotation
text(0.087,0.805,'PS','Color','w','FontWeight','bold','FontSize',18);


