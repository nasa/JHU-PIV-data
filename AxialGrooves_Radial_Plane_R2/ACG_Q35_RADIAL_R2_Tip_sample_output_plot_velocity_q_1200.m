% This code outputs high quality vorticity plot for pubulication
% Ver 1.0 developed by Huang Chen @4/22/2015
% Ver 1.1 revised by Huang Chen @4/24/2015

% define normalized parameters
normvor = 1000/(2*pi*8); % Angular velocity of the Nasa pump at 480rpm. 
normvel = 11.47; % tip speed of the Nasa pump at 480rpm. 
normTKE = 1./(11.4*11.4);  % UTUT for turbulence normalization 

% define font size and font name
font_size = 25;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [-0.45,0.23];
y_lim = [-0.7,0.3];
v_lim = [-0.3,0.3];

%define vector plot parameters
z_skip = 4;
r_skip = 4;  % define skips for vector plots
vector_length = 2.0;
vector_linewidth = 0.1; 

% define figure position and size
fig = figure;
fig.Position = [100,0,1200,800];

% start with pseudo color plots
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.Vq_mean,[10,10])./normvel);
shading interp
caxis(v_lim);
axis equal
colormap(jet);
hold on
xlim(x_lim);
ylim(y_lim);

title(all_data.Test_condition)
xlabel('z/c_{A}','FontSize',font_size,'FontName',font_name,'FontWeight','bold')
ylabel('y/L','FontSize',font_size,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1):0.2:x_lim(2);
ax.YTick = y_lim(1):0.2:y_lim(2);
ax.FontSize = 25;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.Box = 'off';
ax.LineWidth = 1.5;
ax_pos = ax.Position;
g_Zmesh = (all_data.norm_Zmesh-x_lim(1))./(x_lim(2)-x_lim(1))+ax_pos(1);
dz = abs(g_Zmesh(1,1)-g_Zmesh(1,2));

hold on
f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
   all_data.Vz_mean(1:r_skip:end,1:z_skip:end),all_data.Vr_mean(1:r_skip:end,1:z_skip:end),...
   'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',00.5);
hold on
%e = contour(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.vor_mean.*normvor,6);
%shading interp
%caxis([-300,400]);
%axis equal
%colormap(jet(512));
%hold on
% Add mask
g = plot(all_data.norm_Zmask(1:1:end),all_data.norm_Rmask(1:1:end),'.r','Color', [0.5,0.5,0.5]);
hold on

line([-0.435,0.216],[-0.131,-0.131],'LineWidth',3,'Color',[1,1,1]);
line([-0.435,0.216],[0.131,0.131],'LineWidth',3,'Color',[1,1,1]);
line([-0.435,-0.435],[-0.131,0.131],'LineWidth',3,'Color',[1,1,1]);
line([0.216,0.216],[-0.131,0.131],'LineWidth',3,'Color',[1,1,1]);


line([-0.435,0.216],[-0.3928,-0.3928],'LineWidth',3,'Color',[1,1,1]);
line([-0.435,0.216],[-0.6546,-0.6546],'LineWidth',3,'Color',[1,1,1]);
line([-0.435,-0.435],[-0.3928,-0.6546],'LineWidth',3,'Color',[1,1,1]);
line([0.216,0.216],[-0.3928,-0.6546],'LineWidth',3,'Color',[1,1,1]);

% contour(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.Vq_mean,'Color',[0.2,0.2,0.2],'LevelListMode','manual',...
%     'LineWidth',1,'LevelList',[0],'LineStyle','--');
% hold on

% Add colorbar
h  = colorbar('eastoutside');
% h  = colorbar('northoutside');
% h.Position(1) = h.Position(1)+0.08;
% h.Position(2) = h.Position(2)+0.066;
% h.Position(3) = h.Position(3)-0.10;
% h.Position(4) = h.Position(4)/2;
% h.Ticks = v_lim(1):0.15:v_lim(2);
% Add annotation
text(x_lim(2)+.15,y_lim(1)+(y_lim(2)-y_lim(1))/2-.06,'U_{r}/U_{T}:','FontSize',font_size,'FontName',font_name,'FontWeight','bold');


% Add reference vector
% text(x_lim(2)+0.012,y_lim(2)+(y_lim(2)-y_lim(1))/60,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.033,h.Position(1)+h.Position(3)+0.033+dz*vector_length*z_skip],...
%    [h.Position(2)+h.Position(4)+0.017,h.Position(2)+h.Position(4)+0.017],'HeadStyle','vback3','HeadWidth',5)
% 
%  hold on

% Add PS annotation
% text(0.01,0.81,'PS','Color','w','FontWeight','bold','FontSize',10);
% Add vector plots

