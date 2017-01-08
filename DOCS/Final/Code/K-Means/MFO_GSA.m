function [Best_flame_score,Best_flame_pos,Convergence_curve, Moth_pos]=MFO_GSA(N,Max_iteration,lb,ub,dim,fobj)


%Initialize the positions of moths
Moth_pos=initialization(N,dim,ub,lb);
for i = 1:N
	for j = 1:dim
		Moth_vel(i,j) = 0;
	end
end
for i = 1:N
	Moth_fitness(1,i) = 0;
	Moth_fitness(2,i) = 0;
end
% Constants set here
G0 = 10^-5;
t0 = 1;
b = 0.1;

Convergence_curve=zeros(1,Max_iteration);

Iteration=1;

% Main loop
while Iteration<Max_iteration+1
    
    % Number of flames Eq. (3.14) in the paper
    Flame_no=round(N-Iteration*((N-1)/Max_iteration));
    
    for i=1:size(Moth_pos,1) % iterate over each moth
        
        % Check if moths go out of the search spaceand bring it back
        Flag4ub=Moth_pos(i,:)>ub;
        Flag4lb=Moth_pos(i,:)<lb;
        Moth_pos(i,:)=(Moth_pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  
        
        % Calculate the fitness of moths
        Moth_fitness(1,i)= fobj(Moth_pos(i,:));  
		% display(['Moth fitness at ', num2str(i),': ', num2str(Moth_fitness(1,i))]);
    end
       
    if Iteration==1
        % Sort the first population of moths
%         [fitness_sorted I]=sort(Moth_fitness);
		fitTrans = transpose(Moth_fitness);
		[fitness_sorted I]=sortrows(fitTrans,1);
		fitness_sorted = transpose(fitness_sorted);
        sorted_population=Moth_pos(I,:);
       
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    else
        
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_fitness=[previous_fitness best_flame_fitness];
        
		fitTrans = transpose(double_fitness);
		[double_fitness_sorted I]=sortrows(fitTrans,1);
		double_fitness_sorted = transpose(double_fitness_sorted);
		
        double_sorted_population=double_population(I,:);
        fitness_sorted=double_fitness_sorted(:, 1:N);
		
        sorted_population=double_sorted_population(1:N,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    end
    
    % Update the position best flame obtained so far
    Best_flame_score=fitness_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=Moth_pos;
    previous_fitness=Moth_fitness;
    
    % a linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:size(Moth_pos,1)
        
        for j=1:size(Moth_pos,2)
            if i<=Flame_no % Update the position of the moth with respect to its corresponsing flame
                
                % D in Eq. (3.13)
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                % Eq. (3.12)
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
            end
            
            if i>Flame_no % Upaate the position of the moth with respct to one flame
                
                % Eq. (3.13)
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                % Eq. (3.12)
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
            end
            
        end
        
    end
    % For mass updation
    for i=1:size(Moth_pos,1) % iterate over each moth
        Moth_fitness(2,i) = 1/Moth_fitness(1,i);  % adding mass as the 2nd column of the fitness matrix
	end
    
	% Update G
	G = G0*(t0/Iteration)^b;
% 	G = G0*(b^(Iteration));
	
    % Gravity ki vajah se position update
    for i=1:size(Moth_pos,1) % iterate over each moth
        accel = zeros(1,dim);
		for j=1:size(Moth_pos,1)
			if i~=j
				rVec = Moth_pos(i,:)-Moth_pos(j, :);
				mag = G*norm(Moth_fitness(2,j))/norm(rVec);				
				rUnitVec = rVec/norm(rVec);
				accel = accel + mag.*rUnitVec; 
			end
		end
		Moth_vel(i, :) = Moth_vel(i, :).*rand + accel;
		Moth_pos(i, :) = Moth_pos(i, :).*rand + Moth_vel(i, :);
	end
	
    Convergence_curve(Iteration)=Best_flame_score;
    
    % Display the iteration and best optimum obtained so far
    if mod(Iteration,50)==0
        display(['At iteration ', num2str(Iteration), ' the best fitness is ', num2str(Best_flame_score)]);
    end
    Iteration=Iteration+1; 
end





