% This code outputs high quality vorticity plot for pubulication
% Ver 1.0 developed by Huang Chen @4/22/2015
% Ver 1.1 revised by Huang Chen @4/24/2015

% define normalized parameters
normvor = 1000/(2*pi*8); % Angular velocity of the Nasa pump at 480rpm. 


% define font size and font name
font_size = 15;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [0.05,0.80];
% x_lim = [-0.49,0.31];
% y_lim = [0.80,1.128];
y_lim = [0.80,1.2];


%define vector plot parameters
z_skip = 2;
r_skip = 2;  % define skips for vector plots
vector_length =2.5;
vector_linewidth = 0.1; 

% define figure position and size
fig = figure;
fig.Position = [100,50,1600,800];

% start with pseudo color plots
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.vor_mean*normvor);
shading interp
caxis([-200,200]);
axis equal
colormap(jet);
hold on

xlim(x_lim);
ylim(y_lim);

title(all_data.Test_condition)
xlabel('z/c_{A}','FontSize',18,'FontName',font_name,'FontWeight','bold')
ylabel('r/L','FontSize',18,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1)-0.03:0.05:x_lim(2);
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
f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
    all_data.Vz_mean(1:r_skip:end,1:z_skip:end),all_data.Vr_mean(1:r_skip:end,1:z_skip:end),...
    'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',00.5);
hold on


% Add mask
g = plot(all_data.norm_Zmask(1:1:end),all_data.norm_Rmask(1:1:end),'.r','Color', [0.5,0.5,0.5]);


% Add colorbar
h  = colorbar('northoutside');
h.Position(1) = h.Position(1)+0.07;
h.Position(2) = h.Position(2)+0.05;
h.Position(3) = h.Position(3)-0.12;
h.Position(4) = h.Position(4)/2;
% Add annotation
text(x_lim(1)-0.01,y_lim(2)+(y_lim(2)-y_lim(1))/30,['<\omega_{\theta}>' '/' '\Omega:'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');

% Add reference vector
text(x_lim(2)-0.004,y_lim(2)+(y_lim(2)-y_lim(1))/40,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
annotation('arrow',[h.Position(1)+h.Position(3)+0.04,h.Position(1)+h.Position(3)+0.04+dz*vector_length*z_skip],...
    [h.Position(2)+h.Position(4)+0.011,h.Position(2)+h.Position(4)+0.011],'HeadStyle','vback3','HeadWidth',5)

%  text(0.12,0.71,'PS','Color','w','FontWeight','bold','FontSize',18);

% Add PS annotation
text(0.46,0.76,'PS','Color','w','FontWeight','bold','FontSize',18);

