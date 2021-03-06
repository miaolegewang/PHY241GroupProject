function saveFrames_tom(Filename)
  Data = csvread(Filename,0,0);
  index = Data(:,1);
  xdata = Data(:,2);
  ydata = Data(:,3);
  zdata = Data(:,4);
  num_points = max(Data(:,1)) + 1;
  num_frames = length(xdata)/num_points;
  disp(num_frames);
  num_particles = num_points/2;
  parfor j = 1:50
      i = j + 300;
      index1 = (((i-1)*num_points+1):i*num_points);  %the index of the data in the whole array
      indicator = index(index1);
      x = xdata(index1);
      y = ydata(index1);
      z = zdata(index1);
      A = [indicator, x, y, z];
      A = sortrows(A,1);  % sort the order of A by the index of particles
      x1 = A(1:num_particles, 2);
      y1 = A(1:num_particles, 3);
      z1 = -A(1:num_particles, 4);
      x2 = A((num_particles+1):num_points, 2);
      y2 = A((num_particles+1):num_points, 3);
      z2 = -A((num_particles+1):num_points, 4);
      figure('Color','black');
      plot3(x1,y1,z1,'.','Color','blue','Markersize',0.7);
      hold on;
      plot3(x2,y2,z2,'.','Color','red','Markersize',0.7);
      axis equal;
      axis([-70,70,-5,5,-5,5]);
      axis off;
      set(gcf,'inverthardcopy','off');
      view(180,0); %rotate the viewpoint
      saveas(gcf,strcat('andromeda_3b/time_',int2str(j)),'png');
      hold off;
  end
      
   