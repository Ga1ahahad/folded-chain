clc; clear;

%% const

num_nodes = 11;
c = 80;
a = 2;                                    % min(a) = right_fix_coord/(num_nodes-1)
g = 9.8;
m = 1;
b = 2*sqrt(m*c)/5;
right_fix_coord = 1;

save("Consts2.mat", "c", "a", "g", "m" ,"right_fix_coord", "num_nodes", "b");
%% tech

Coords = zeros(2, num_nodes);
Speeds = zeros(2, num_nodes);
Accels = zeros(2, num_nodes);
Forces = zeros(2, num_nodes);
t_end = 300;
dt = 0.01;
smth = 200/1.5;

%% init

for it=1:num_nodes
    Coords(1,it) = right_fix_coord*(it-1)/(num_nodes-1);
    Coords(2,it) = 0;
%     Coords(2,it) = -smth+abs(right_fix_coord/2-Coords(1,it))/(right_fix_coord/2)*smth;
end

%% iter

do_stop = 1;
b = 0;

for i=0:dt:t_end
    Forces(1,:)=0;
    Forces(2,2:num_nodes-1)=-m*g;
    for j=2:num_nodes-1
        [Fx, Fy] = calc_elastic_force2(Coords(:,j-1),Coords(:,j),Coords(:,j+1), c, a);
        Forces(1,j) = Forces(1,j) + Fx - b*Speeds(1,j);
        Forces(2,j) = Forces(2,j) + Fy - b*Speeds(2,j);
    end
    Forces(:,1)=0;
    Forces(:,num_nodes)=0;
    Accels = Forces/m;
    Speeds = Speeds + Accels*dt;
    if mod(i,dt*1)==0
%         Coords(1,:) = Coords(1,:) + Speeds(1,:)*dt;
        Coords(2,:) = Coords(2,:) + Speeds(2,:)*dt;
    end
    if mod(i,dt*690)==0
        Speeds = Speeds*0;
        Accels = Accels*0;
    end
    if ((do_stop==1)&&(abs(Coords(2,10)+smth*1.5)<2))
        Speeds = Speeds*0;
        Accels = Accels*0;
        do_stop = 0
    end
%     if(i>t_end/8*7*0)
%         plot(Coords(1,:),Coords(2,:), 'ko')
%         axis([-0.1, right_fix_coord+0.1, -smth*1.5, 0])
%         pause(0.001)
%     end
end

%% plots

plot(Coords(1,:),Coords(2,:), 'ko')

save("Coords2.mat", "Coords")