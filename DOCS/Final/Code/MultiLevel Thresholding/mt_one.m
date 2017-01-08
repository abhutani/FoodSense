
function new_chromosome = mt_one(chromosome)

    new_chromosome = chromosome;

    chromosome_size = size(chromosome, 2);
    gene = round(unifrnd(1, chromosome_size));

    % Mutate one gene
    if (chromosome(gene) == 1)
        new_chromosome(gene) = 0;
    else
        new_chromosome(gene) = 1;
    end


