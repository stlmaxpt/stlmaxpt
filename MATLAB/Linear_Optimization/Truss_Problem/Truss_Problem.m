                
clc
clear
close all

tic

S_y = 8;

figure(1)
hold on
plot([19 19],[5 3],'r','Linewidth',2)
plot([19 18.5],[3 3.5],'r','Linewidth',2)
plot([19 19.5],[3 3.5],'r','Linewidth',2)

plot([0 -1 -1 0],[6 5.7 6.5 6],'k','Linewidth',2)
plot([0 -1 -1 0],[5 4.7 5.5 5],'k','Linewidth',2)
plot([0 -1 -1 0],[4 3.7 4.5 4],'k','Linewidth',2)
plot([-1.5 -1],[3.5 3.8],'k','Linewidth',2)
plot([-1.5 -1],[3.8 4.1],'k','Linewidth',2)
plot([-1.5 -1],[4.1 4.4],'k','Linewidth',2)
plot([-1.5 -1],[4.5 4.8],'k','Linewidth',2)
plot([-1.5 -1],[4.8 5.1],'k','Linewidth',2)
plot([-1.5 -1],[5.1 5.4],'k','Linewidth',2)
plot([-1.5 -1],[5.5 5.8],'k','Linewidth',2)
plot([-1.5 -1],[5.8 6.1],'k','Linewidth',2)
plot([-1.5 -1],[6.1 6.4],'k','Linewidth',2)
axis equal
xlim([-2 21])
ylim([-1 11])
box on

x_dots = zeros(1,11*20);
y_dots = zeros(1,11*20);

for i = 0:19
    for j = 0:10
        x_dots(i*11 + j + 1) = i;
        y_dots(i*11 + j + 1) = j;
    end
end

scatter(x_dots,y_dots,7,'filled','b')

% lengths
total_beams = (numel(x_dots)*(numel(x_dots) - 1))/2;

beam_lengths = zeros(total_beams,1);
beam_angles = zeros(total_beams,1);

counter_beams = 1;

for k = 1:(numel(x_dots) - 1)
    for l = (k + 1):numel(x_dots)
        p1 = [x_dots(k),y_dots(k)];
        p2 = [x_dots(l),y_dots(l)];
        tan_arg = (p2(2) - p1(2))/(p2(1) - p1(1));
        beam_angles(counter_beams) = atan(tan_arg);
        beam_lengths(counter_beams) = norm(p1 - p2);
        counter_beams = counter_beams + 1;
    end
end

A_trig = zeros(numel(x_dots),total_beams);
column_num = 1;

for m = 1:(numel(x_dots) - 1)
    A_trig(m,column_num:(numel(x_dots) - m + column_num - 1)) = -ones(size(column_num:(numel(x_dots) - m + column_num - 1)));
    A_trig((m + 1):end,column_num:(numel(x_dots) - m + column_num - 1)) = eye(numel(x_dots) - m);
    column_num = column_num + numel(x_dots) - m;
end

A_cos = A_trig;
A_sin = A_trig;

for n = 1:total_beams
    A_cos(:,n) = A_cos(:,n)*cos(beam_angles(n));
    A_sin(:,n) = A_sin(:,n)*sin(beam_angles(n));
end

b_cos = zeros(numel(x_dots),1);
b_sin = zeros(numel(x_dots),1);
b_sin(215) = -4;

for p = 1:numel(x_dots)
    if p == 5
        b_cos(p:(p + 2)) = [];
        b_sin(p:(p + 2)) = [];
        A_cos(p:(p + 2),:) = [];
        A_sin(p:(p + 2),:) = [];
    end
end

A_both = sparse([A_cos; A_sin]);

A_add = speye(total_beams);

b_8 = [b_cos; b_sin];
b_15 = S_y*ones(total_beams,1);
   
b_1 = [b_8; -b_8; b_15; b_15; zeros(2*total_beams,1)];

A_1 = [A_both, zeros(numel(b_8),total_beams);
       -A_both, zeros(numel(b_8),total_beams);
       A_add, zeros(size(A_add));
       -A_add, zeros(size(A_add));
       A_add, -A_add;
       -A_add, -A_add];

c_nolengths = [zeros(total_beams,1); ones(total_beams,1)];

c_lengths = [zeros(total_beams,1); beam_lengths];

u_test = linprog(c_nolengths,A_1,b_1);

u_use = u_test(1:total_beams);

u_test_lengths = linprog(c_lengths,A_1,b_1);

u_use_lengths = u_test_lengths(1:total_beams);

counter_plot = 1;
num_beams_nolengths = 1;

for q = 1:(numel(x_dots) - 1)
    for r = (q + 1):numel(x_dots)
        xs = [x_dots(q),x_dots(r)];
        ys = [y_dots(q),y_dots(r)];
        if abs(u_use(counter_plot)) > 1e-4
            if u_use(counter_plot) < 0
                plot(xs,ys,'r')
            elseif u_use(counter_plot) > 0
                plot(xs,ys,'b')
            end
            num_beams_nolengths = num_beams_nolengths + 1;
        end
        counter_plot = counter_plot + 1;
    end
end

hold off

figure(2)
hold on
plot([19 19],[5 3],'r','Linewidth',2)
plot([19 18.5],[3 3.5],'r','Linewidth',2)
plot([19 19.5],[3 3.5],'r','Linewidth',2)

plot([0 -1 -1 0],[6 5.7 6.5 6],'k','Linewidth',2)
plot([0 -1 -1 0],[5 4.7 5.5 5],'k','Linewidth',2)
plot([0 -1 -1 0],[4 3.7 4.5 4],'k','Linewidth',2)
plot([-1.5 -1],[3.5 3.8],'k','Linewidth',2)
plot([-1.5 -1],[3.8 4.1],'k','Linewidth',2)
plot([-1.5 -1],[4.1 4.4],'k','Linewidth',2)
plot([-1.5 -1],[4.5 4.8],'k','Linewidth',2)
plot([-1.5 -1],[4.8 5.1],'k','Linewidth',2)
plot([-1.5 -1],[5.1 5.4],'k','Linewidth',2)
plot([-1.5 -1],[5.5 5.8],'k','Linewidth',2)
plot([-1.5 -1],[5.8 6.1],'k','Linewidth',2)
plot([-1.5 -1],[6.1 6.4],'k','Linewidth',2)
axis equal
xlim([-2 21])
ylim([-1 11])
box on

scatter(x_dots,y_dots,7,'filled','b')

counter_plot_lengths = 1;
num_beams_lengths = 1;

for u = 1:(numel(x_dots) - 1)
    for v = (u + 1):numel(x_dots)
        xs = [x_dots(u),x_dots(v)];
        ys = [y_dots(u),y_dots(v)];
        if abs(u_use_lengths(counter_plot_lengths)) > 1e-4
            if u_use_lengths(counter_plot_lengths) < 0
                plot(xs,ys,'r')
            elseif u_use_lengths(counter_plot_lengths) > 0
                plot(xs,ys,'b')
            end
            num_beams_lengths = num_beams_lengths + 1;
        end
        counter_plot_lengths = counter_plot_lengths + 1;
    end
end

toc

