#Fermi Estimation Question: How many scientists are there in Kansas City? 

# Step 1: Identify relevant factors and take assumptions
population_of_Kansas <- 1.1e6  # estimated population of Kansas
average_household_size <- 2.5   # estimated average household size
percentage_of_households_having_scientists <- 0.2  # estimated percentage of households having scientist
scientists_per_household <- 1.2   # estimated average number of scientist per household
time_for_a_scientists_in_laboratory <- 2   # estimated time (in hours) a scientists spends in laboratory

# Step 2: Perform calculations
total_scientists <- population_of_Kansas * average_household_size * percentage_of_households_having_scientists * scientists_per_household
total_hours <- total_scientists * time_for_a_scientists_in_laboratory

# Step 3: Make the estimation
estimation <- total_hours / 8  # assuming an 8-hour workday

# Step 4: Display the result
cat("Estimated number of scientists in Kansas:", round(estimation), "\n")

# Estimated number of scientists in Kansas: 165000