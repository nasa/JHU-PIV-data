% This code outputs high quality vorticity plot for pubulication
% Ver 1.0 developed by Huang Chen @4/22/2015
% Ver 1.1 revised by Huang Chen @4/24/2015

% define normalized parameters
normvel = 11.47; % tip speed of the Nasa pump at 480rpm. 
normvor = 1000/(2*pi*8);
normvel1 = 11.47*0.38;

mesh_size = size(all_data.Vz_mean);


d_theta = 0*4.8/180*pi;
norm_theta = all_data.norm_Zmesh*45.72/95.7557;


% Trying to convert the cartisian coordinate system into 
r = sqrt((all_data.norm_Zmesh*45.72).^2+(all_data.norm_Rmesh*45.72+182.9).^2);
theta = asin(all_data.norm_Zmesh*45.7./r);


mesh_r = sqrt((all_data.norm_x_blade1*45.72).^2+(all_data.norm_y_blade1*45.72+182.9).^2);
mask_theta = asin(all_data.norm_x_blade1*45.7./mesh_r);
new_maskx = mesh_r.*sin(d_theta+mask_theta)./95.7557;
new_masky = (mesh_r.*cos(d_theta+mask_theta)-182.9)./45.72;
new_maskx1 = mesh_r.*sin(24*pi/180+d_theta+mask_theta)./95.7557;
new_masky1 = (mesh_r.*cos(24*pi/180+d_theta+mask_theta)-182.9)./45.72;



orm_theta_mask = all_data.norm_x_blade1*45.72/95.7557;

uz = all_data.Vq_mean;
ur = all_data.Vz_mean.*sin(theta) + all_data.Vr_mean.*cos(theta);
uq = all_data.Vz_mean.*cos(theta) - all_data.Vr_mean.*sin(theta);

new_x = r.*sin(d_theta+theta)./95.7557;
new_y = (r.*cos(d_theta+theta)-182.9)./45.72;





% define font size and font name
font_size = 20;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [-1,0.05];
y_lim = [-0.5,1.25];
v_lim = [-0.5,2];

%define vector plot parameters
z_skip = 1;
r_skip = 1;  % define skips for vector plots
vector_length =2.5;
vector_linewidth = 0.1; 

% define figure position and size
fig = figure;
fig.Position = [100,50,1200,900];

% start with pseudo color plots
e = pcolor(new_x,new_y,medfilt2(uz,[1,1])/normvel1);
shading interp
caxis(v_lim);
% axis equal
colormap(jet);
hold on

xlim(x_lim);
ylim(y_lim);

xlabel('\theta/\theta_{blade}','FontSize',font_size,'FontName',font_name,'FontWeight','bold')
ylabel('r/L','FontSize',font_size,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1):0.2:x_lim(2);
ax.YTick = y_lim(1):0.2:y_lim(2);
ax.FontSize = 20;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.Box = 'off';
ax.LineWidth = 1.5;
ax_pos = ax.Position;
g_Zmesh = (norm_theta-x_lim(1))./(x_lim(2)-x_lim(1))+ax_pos(1);
dz = abs(g_Zmesh(1,1)-g_Zmesh(1,2));
ax.DataAspectRatio = [1 2.09 1];
hold on
% f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
%     all_data.Vz_mean(1:r_skip:end,1:z_skip:end),all_data.Vr_mean(1:r_skip:end,1:z_skip:end),...
%     'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',00.5);
% hold on


% contour(new_x,new_y,uz/normvel1,'Color',[0.2,0.2,0.2],'LevelListMode','manual',...
%     'LineWidth',1,'LevelList',[1],'LineStyle','--');
% hold on
contour(new_x,new_y,uz/normvel1,'Color',[0,0.0,0.0],'LevelListMode','manual',...
    'LineWidth',1,'LevelList',[1],'LineStyle','--');
hold on

contour(new_x,new_y,uz/normvel1,'Color',[1,1,1],'LevelListMode','manual',...
    'LineWidth',1,'LevelList',[0],'LineStyle','-.');
hold on

%e = contour(all_data.norm_Zmesh,all_data.norm_Rmesh,all_data.vor_mean.*normvor,6);
%shading interp
%caxis([-300,400]);
%axis equal
%colormap(jet(512));
%hold on
% Add mask

g1 = plot(radialmask_x(1:1:end)*45.72/95.7557,radialmask_y(1:1:end),'.r','Color', [1,1,1]);
hold on


% g1 = plot(new_maskx(1:1:end),new_masky(1:1:end),'.r','Color', [0.5,0.5,0.5]);
% hold on


g21 = plot(casingmesh_white_x(1:1:end)*45.72/95.7557,casingmesh_white_y(1:1:end),'.r','Color', [1,1,1]);
hold on
g22 = plot(casingmesh_r_x(1:1:end)*45.72/95.7557,casingmesh_r_y(1:1:end),'.r','Color', [1,1,1]);
hold on
g2 = plot(casingmesh_x(1:1:end)*45.72/95.7557,casingmesh_y(1:1:end),'.r','Color', [0.5,0.5,0.5]);
hold on
g3 = patch(new_maskx,new_masky,[0.6,0.6,0.6],'EdgeColor','none');
hold on
g4 = patch(new_maskx1-0.01,new_masky1,[0.6,0.6,0.6],'EdgeColor','none');
hold on


% Add colorbar
h  = colorbar('northoutside');
h.Position(1) = h.Position(1)+0.07;
h.Position(2) = h.Position(2)+0.06;
h.Position(3) = h.Position(3)-0.09;
h.Position(4) = h.Position(4)/2;
% h.Ticks = v_lim(1):0.10:v_lim(2);
% Add annotation
text(x_lim(1),y_lim(2)+(y_lim(2)-y_lim(1))/30,['U_{Z}' '/' 'U_{T}'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');


% Add reference vector
% text(x_lim(2)-0.012,y_lim(2)+(y_lim(2)-y_lim(1))/38,'U_{T}','FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.015,h.Position(1)+h.Position(3)+0.015+dz*vector_length*z_skip],...
%     [h.Position(2)+h.Position(4)+0.011,h.Position(2)+h.Position(4)+0.011],'HeadStyle','vback3','HeadWidth',5)

%  hold on

% Add PS annotation
% text(0.23,0.71,'PS','Color','w','FontWeight','bold','FontSize',22);
% Add vector plots

phase='_sc086';
flow_rate='_038';
print(['Contour_Vz',flow_rate,phase],'-dpng','-r300')
