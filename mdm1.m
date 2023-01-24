clear; clc;
load("Coords.mat")

%% const

load("Consts.mat")

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
H = 120;    

coord = 0;
speed = 0;
force = -m*g;
    
for i=0:dt:t_end
    Forces(1,:)=0; 
    Forces(2,2:num_nodes)=-m*g; 
    for j=1:num_nodes-1
        [Fx, Fy] = calc_elastic_force(Coords(:,j),Coords(:,j+1), c, a);
        Forces(1,j) = Forces(1,j) + Fx*damp - b*Speeds(1,j);
        Forces(2,j) = Forces(2,j) + Fy - b*Speeds(2,j);
        Forces(1,j+1) = Forces(1,j+1) - Fx*damp;
        Forces(2,j+1) = Forces(2,j+1) - Fy;
    end
    Accels = Forces/m;
    Speeds = Speeds + Accels*dt;
    Speeds(:,1)=0;
    Coords(1,:) = Coords(1,:) + Speeds(1,:)*dt;
    Coords(2,:) = Coords(2,:) + Speeds(2,:)*dt;

    accel = force/m;
    speed = speed + accel*dt;
    coord = coord + speed*dt;
    
    clf
    hold on 
    grid on
    plot(Coords(1,:),Coords(2,:), 'ko')
    plot(H/4, coord, 'c*')
    axis([-H/2, H/2, -H, 0])
    pause(0.001)
    accel_end(floor(i/dt+1)) = Accels(2,num_nodes);
end
clf
plot(0:dt:t_end, accel_end/g)