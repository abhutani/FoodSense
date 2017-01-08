
function new_population = mt(population, p_mutation, new_population)

    population_size = size(population, 1);

    % Random permutation of genomes order 
    mutation_order = randperm(population_size);

    for i = 1:round(p_mutation*population_size);
        new_population = [new_population; mt_one(population(mutation_order(i), :))];
	end

