normvor = 1000/(2*pi*8); % Angular velocity of the Nasa pump at 480rpm. 
normvel = 1./11.47; % tip speed of the Nasa pump at 480rpm. 
normTKE = 1./(11.4*11.4);  % UTUT for turbulence normalization

% v_lim = [-100,100]; %vorticity limits
v_lim = [-0.5,0.8]; %Vq limits


% define font size and font name
font_size = 25;
font_name = 'Times New Roman';

% define x,y limits
x_lim = [-0.46,0.28];
y_lim = [0.75,1.20];

%define vector plot parameters
z_skip = 4;
r_skip = 4;  % define skips for vector plots
mag=sqrt((all_data.Vz_mean).^2+(all_data.Vr_mean).^2);
max_mag=max(max(mag));
vector_length = 3.0;

vector_linewidth = 1.25; 


% define figure position and size
fig = figure;
fig.Position = [50,50,1600,800];

% start with pseudo color plots
% e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.vor_mean,[4,4]).*normvor);
e = pcolor(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.Vq_mean,[1,1]).*normvel);

shading interp
% caxis([-50,50]);
caxis(v_lim);

axis equal
colormap(jet);
hold on

xlim(x_lim);
ylim(y_lim);

title(all_data.Test_condition)
xlabel('z/c_{A}','FontSize',30,'FontName',font_name,'FontWeight','bold')
ylabel('r/L','FontSize',30,'FontName',font_name,'FontWeight','bold')

ax = gca;
ax.XTick = x_lim(1)+0.06:0.1:x_lim(2);
ax.YTick = y_lim(1)+0.05:0.1:y_lim(2);
ax.FontSize = 20;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.Box = 'off';
ax.LineWidth = 1.5;
ax_pos = ax.Position;
g_Zmesh = (all_data.norm_Zmesh-x_lim(1))./(x_lim(2)-x_lim(1))+ax_pos(1);
dz = abs(g_Zmesh(1,1)-g_Zmesh(2,1));
hold on

contour(all_data.norm_Zmesh,all_data.norm_Rmesh,medfilt2(all_data.Vq_mean,[1,1])./normvel,'Color',[1.0,0.0,0.0],'LevelListMode','manual',...
    'LineWidth',1.5,'LevelList',[0],'LineStyle','--');
hold on



% Add vector plots
f = quiver(all_data.norm_Zmesh(1:r_skip:end,1:z_skip:end),all_data.norm_Rmesh(1:r_skip:end,1:z_skip:end),...
    all_data.Vz_mean(1:r_skip:end,1:z_skip:end)./normvel,all_data.Vr_mean(1:r_skip:end,1:z_skip:end)./normvel,...
    'k','LineWidth',vector_linewidth,'AutoScaleFactor',vector_length,'MaxHeadSize',12.5);
hold on


% Add mask
%  g = plot(all_data.norm_Zmask(1:1:end)-0.008,all_data.norm_Rmask(1:1:end),'.','Color', [0.5,0.5,0.5]);
% g = patch(x,y,[0,0,1]);
    g1 = patch(all_data.norm_x_wall1,all_data.norm_y_wall1,[0.6,0.6,0.6],'EdgeColor','none');
    g2 = patch(all_data.norm_x_blade1,all_data.norm_y_blade1,[0.6,0.6,0.6],'EdgeColor','none');
% Add colorbar
h  = colorbar('eastoutside');
% % h  = colorbar('northoutside');
% % h.Position(1) = h.Position(1)+0.08;
% % h.Position(2) = h.Position(2)+0.07;
% % h.Position(3) = h.Position(3)-0.15;
% % h.Position(4) = h.Position(4)/2;

% Add annotation
% text(x_lim(1)-0.01,y_lim(2)+(y_lim(2)-y_lim(1))/15,['<\omega_{\theta}>' '/' '\Omega:'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');
% text(x_lim(2)+0.055,y_lim(1)-0.02+(y_lim(2)-y_lim(1))/2,['<\omega_{\theta}>' '/' '\Omega:'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');
text(x_lim(2)+0.055,y_lim(1)-0.02+(y_lim(2)-y_lim(1))/2,['U_{\theta}' '/' 'U_{T}'],'FontSize',font_size,'FontName',font_name,'FontWeight','bold');

% Add reference vector
% text(x_lim(2)-0.011,y_lim(2)+(y_lim(2)-y_lim(1))/25,'U_{T}','FontSize',25,'FontName',font_name,'FontWeight','bold');
% annotation('arrow',[h.Position(1)+h.Position(3)+0.09,h.Position(1)+h.Position(3)+0.09+dz*vector_length*z_skip*(normvel/max_mag)],...
%     [h.Position(2)+h.Position(4)+0.038,h.Position(2)+h.Position(4)+0.038],'LineWidth',1,'HeadStyle','vback3','HeadWidth',15)
% 

% Add blade annotation
% text(0.03,0.805,'PS','Color','w','FontWeight','bold','FontSize',12);
% text(+0.24,0.805,'SS','Color','w','FontWeight','bold','FontSize',12);
% [x,y] = ginput;
% a = getframe(fig);
% [geo_mask(1).msk,geo_mask(1).z,geo_mask(1).z]= roipoly(a);
%phase='_sc-163';
%flow_rate='038';
% print(['mean_vel_',flow_rate,'_',phase],'-dtiff','-r200')
rd=1;