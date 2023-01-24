clear; clc;
load("Coords2.mat")

%% const

load("Consts2.mat")

%% tech
Speeds = zeros(2, num_nodes);
Accels = zeros(2, num_nodes);
Forces = zeros(2, num_nodes);
dt = 0.05;
t_end = 7.75;

accel_end = zeros(1,t_end/dt+1);

%% iter

damp = 1;
b = 0;
    
for i=0:dt:t_end
    Forces(1,:)=0; 
    Forces(2,2:num_nodes)=-m*g; 
    for j=2:num_nodes-1
        [Fx, Fy] = calc_elastic_force2(Coords(:,j-1),Coords(:,j),Coords(:,j+1), c, a);
        Forces(1,j) = Forces(1,j) + Fx*damp - b*Speeds(1,j);
        Forces(2,j) = Forces(2,j) + Fy - b*Speeds(2,j);
    end
    Forces(1,num_nodes) = Forces(1,num_nodes) + (Coords(1,num_nodes-1) - Coords(1,num_nodes))*c/a*damp - b*Speeds(1,j);
    Forces(2,num_nodes) = Forces(2,num_nodes) + (Coords(2,num_nodes-1) - Coords(2,num_nodes))*c/a - b*Speeds(2,j);
    Forces(:,1)=0;
    Accels = Forces/m;
    Speeds = Speeds + Accels*dt;
    if mod(i,dt*1)==0
        Coords(1,:) = Coords(1,:) + Speeds(1,:)*dt;
        Coords(2,:) = Coords(2,:) + Speeds(2,:)*dt;
    end
%     if mod(i,dt*200)==0
%         Speeds = Speeds*0;
%         Accels = Accels*0;
%     end
    plot(Coords(1,:),Coords(2,:), 'ko')
    axis([-30, 30, -60, 0])
    pause(0.001)
    accel_end(floor(i/dt+1)) = Accels(2,num_nodes);
end
plot(0:dt:t_end, accel_end/g)