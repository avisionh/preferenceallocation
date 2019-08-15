# ----------- #
## Functions ##
# ----------- #

# ----------------------------------------------------------------
# Desc: Houses all user-created functions.
# Credit: Please see functions.
# Script Dependencies: None
# Notes: None
# ----------------------------------------------------------------


# func_nth_largest ---------------------------------------------------------------
# DESC: Returns the n-th largest number from a vector.
# PACKAGE DEPENDENCIES: None
# FUNCTION DEPENDENCIES: None
# CREDIT: https://stackoverflow.com/questions/25559778/producing-the-nth-largest-number-from-a-vector-in-r
# NOTES: Only works for vectors.
# ARGUMENTS:
  # 1. 'x' | (vector) Data to feed in
  # 2, 'n' | (integer) n-th largest number you want to take from the 'x'
func_nth_largest <-  function(x, n){
  x[rev(order(x))][n]
}


# func_sample -----------------------------------------------------------
# DESC: Take a random sample of rows from a vector.
# PACKAGE DEPENDENCIES: None
# FUNCTION DEPENDENCIES: None
# CREDIT: https://stackoverflow.com/questions/9390965/select-random-element-in-a-list-of-r
# NOTES: Builds on base `sample` function which does not work expectantly for vectors of length one.
# ARGUMENTS:
  # 1. 'x' | (vector) Data to feed in
  # 2, 'n' | (integer) Size of random sample you want to take from 'x'
  # 3. 'replacement' | (boolean) Whether you want to take a random sample with or without replacement
func_sample <- function(x, n, replacement) {
  if (length(x) <= 1) {
    return(x)
  } else {
    return(sample(x, n, replace = replacement))
  }
}


# func_iterative_preferences ----------------------------------------------
# DESC: Take a random sample of rows from a vector.
# PACKAGE DEPENDENCIES: dplyr
# FUNCTION DEPENDENCIES: func_nth_largest, func_sample
# CREDIT: Fatma Hussain (work experience student)
# NOTES: Builds on base `sample` function which does not work expectantly for vectors of length one.
# ARGUMENTS:
  # 1. 'x' | (tibble/dataframe) Data to feed in
  # 2. 'limits' | (tibble/dataframe) Maximum capacity of each session
func_iterative_preferences <- function(x, limits, with_replacement) {
  
  # get number of people
  n_people <- nrow(x)
  # get number of session columns
  n_sessions <- ncol(x) - 1
  
  # create dummy tibble for storing output
  matchings <- tibble(PersonRowId = rep(x = -1, times = n_people), 
                      SessionPreferredColumnId = rep(x = "dummy", times = n_people))
  
  # convert limits from vector to tibble
  limits <- limits[,2] %>% as.tibble()
  
  # generate vector of people and random sample from it
  people <- seq(from = 1, to = n_people, by = 1)
  sample_people <- func_sample(x = people, n = n_people, replacement = with_replacement)
  
  # Run for each person
  for (i in 1:n_people) {
    
    # choose i-th person in random sample of people
    select_person <- x[sample_people[i], ]
    
    # Run for each preference if their session is full
    for (j in 1:n_sessions) {
      
      # n-th largest value for selected person
      nth_most_preferred <- func_nth_largest(x = select_person[, 2:(n_sessions + 1)] %>% t(), n = j)
      
      # return column number with n-th most preferred session
      # note: subtract one since need to account for column of delegates' name
      preferred_session <- which(select_person == nth_most_preferred) - 1
      
      # check if preferred session is available
      if(limits[preferred_session,] > 0) {
        
        # assign person number to session number
        matchings[i, ] <- c(rownames(x)[sample_people[i]], preferred_session)
        
        # remove a place from session that's been allocated
        limits[preferred_session, 1] <- limits[preferred_session, 1] - 1
        
        # if session is now full, assign 0 to all its preference values
        # note: need to add 1 since 'x' dataframe has column for delegates
        if(limits[preferred_session,] == 0) {x[, preferred_session + 1] <- 0}
        
        # break out of inner loop since as we have allocated person to session
        break
      } #if
      
    } #inner loop
    
  } #outer loop
  
  # store output in list as have multiple objects
  output <- list(matchings, sample_people)
  
  return(output)
}