% This code outputs high quality vorticity plot for pubulication


% define normalized parameters
normvel = 11.47; % tip speed of the Nasa pump at 480rpm. 


% define font size and font name
font_size = 20;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [0-.45,.33];
% y_lim = [0.8,1.13];
y_lim = [.8,1.18];
% y_lim = [-0.3,0.7]
v_lim = [-0.3,0.30];

%define vector plot parameters
z_skip = 4;
r_skip = 4;  % define skips for vector plots
vector_length =3.0;
vector_linewidth = 0.1; 

% define figure position and size
fig = figure;
fig.Position = [100,0,1200,600];

% start with pseudo color plots
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.Vq_mean./normvel);
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
% ylabel('y/L','FontSize',font_size,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1):0.1:x_lim(2);
ax.YTick = y_lim(1):0.1:y_lim(2);
ax.FontSize = 20;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.Box = 'off';
ax.LineWidth = 1.5;
%ax_pos = ax.Position;
%g_Zmesh = (all_data.norm_Zmesh-x_lim(1))./(x_lim(2)-x_lim(1))+ax_pos(1);
%dz = abs(g_Zmesh(1,1)-g_Zmesh(1,2));
hold on

contour(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.Vq_mean,'Color',[0.2,0.2,0.2],'LevelListMode','manual',...
    'LineWidth',1,'LevelList',[0],'LineStyle','--');
hold on

% Add vector plots
% f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
%    all_data.Vz_mean(1:r_skip:end,1:z_skip:end),all_data.Vr_mean(1:r_skip:end,1:z_skip:end),...
%    'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',00.5);
% hold on


% Add mask
%   g2 = patch(all_data.norm_Zmask,all_data.norm_Rmask,[0.6,0.6,0.6],'EdgeColor','none');
%  hold on

% Add colorbar
h  = colorbar('eastoutside');
% h.Position(1) = h.Position(1)+0.07;
% h.Position(2) = h.Position(2)+0.04;
% h.Position(3) = h.Position(3)-0.08;
% h.Position(4) = h.Position(4)/2;
h.Ticks = v_lim(1):0.2:v_lim(2);
% Add annotation
text(x_lim(2)+(x_lim(2)-x_lim(1))/5,y_lim(1)+(y_lim(2)-y_lim(1))/2,['U_{\theta}' '/' 'U_{T}'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');

% Add reference vector
% text(x_lim(2)-0.012,y_lim(2)+(y_lim(2)-y_lim(1))/40,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.04,h.Position(1)+h.Position(3)+0.04+dz*vector_length*z_skip],...
%     [h.Position(2)+h.Position(4)+0.011,h.Position(2)+h.Position(4)+0.011],'HeadStyle','vback3','HeadWidth',5)

 %text(0.083,0.81,'PS','Color','w','FontWeight','bold','FontSize',18);

% Add PS annotation
text(0.055,0.805,'PS','Color','w','FontWeight','bold','FontSize',10);

