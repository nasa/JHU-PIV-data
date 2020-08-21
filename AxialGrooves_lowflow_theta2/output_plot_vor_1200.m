% This code outputs high quality vorticity plot for pubulication


% define normalized parameters
normvor = 1000/(2*pi*8); % Angular velocity of the Nasa pump at 480rpm. 


% define font size and font name
font_size = 15;
font_name = 'Times New Roman';

% define x,y limits
% x_lim = [-0.47,0.29];
x_lim = [-0.47,0.27];
y_lim = [0.8,1.18];
v_lim = [-100,200];

%define vector plot parameters
z_skip = 5;
r_skip = 5;  % define skips for vector plots
vector_length = 4;
vector_linewidth = 0.01; 

% define figure position and size
fig = figure;
fig.Position = [50,0,1600,800];

% start with pseudo color plots
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.vor_mean.*normvor);
shading interp
caxis(v_lim);
axis equal
colormap(jet);
hold on

xlim(x_lim);
ylim(y_lim);

title(all_data.Test_condition)
xlabel('z/c_{A}','FontSize',18,'FontName',font_name,'FontWeight','bold')
ylabel('r/L','FontSize',18,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1):0.1:x_lim(2);
ax.YTick = y_lim(1):0.1:y_lim(2);
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
    'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',12.5);
hold on

% Add mask
 g = plot(all_data.norm_Zmask(1:1:end),all_data.norm_Rmask(1:1:end),'.','Color', [0.5,0.5,0.5]);
%  g = plot(all_data.norm_Zmask(1:1:end)-0.008,all_data.norm_Rmask(1:1:end),'.','Color', [0.5,0.5,0.5]);
% g = patch(x,y,[0,0,1]);
%     g1 = patch(all_data.norm_x_wall1,all_data.norm_y_wall1,[0.6,0.6,0.6],'EdgeColor','none');
%     g2 = patch(all_data.norm_x_blade1,all_data.norm_y_blade1,[0.6,0.6,0.6],'EdgeColor','none');
% Add colorbar
h  = colorbar('eastoutside');
% h.Position(1) = h.Position(1)+0.08;
% h.Position(2) = h.Position(2)+0.04;
% h.Position(3) = h.Position(3)-0.15;
% h.Position(4) = h.Position(4)/2;
% Add annotation
text(x_lim(1)-0.01,y_lim(2)+(y_lim(2)-y_lim(1))/15,['<\omega_{\theta}>' '/' '\Omega:'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');

% Add reference vector
% text(x_lim(2)-0.012,y_lim(2)+(y_lim(2)-y_lim(1))/15,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.04,h.Position(1)+h.Position(3)+0.04+dz*vector_length*z_skip],...
%     [h.Position(2)+h.Position(4)+0.011,h.Position(2)+h.Position(4)+0.011],'HeadStyle','vback3','HeadWidth',5)

 text(0.055,0.805,'PS','Color','w','FontWeight','bold','FontSize',10);

% Add PS annotation
%text(0.083,0.81,'PS','Color','w','FontWeight','bold','FontSize',18);
% [x,y] = ginput;
% a = getframe(fig);
% [geo_mask(1).msk,geo_mask(1).z,geo_mask(1).z]= roipoly(a);