# Preference Allocation

***

[![Travis-CI Build Status](https://travis-ci.org/avisionh/Preference-Allocation.svg?branch=master)](https://travis-ci.org/avisionh/Preference-Allocation)

The problem we will tackle in this repository is of *preference allocation*/*one-sided matching*.

In particular, consider that we have to assign *x* people to *y* sessions. For each of these *y* sessions,
and individual person will have a preference ordering, meaning that they strictly prefer some sessions over others.

The task is to allocate these *x* people to their *y* sessions, accounting for their preferences
in such a way that the total utility of all *x* people is maximised.

# Methodology
We will tackle this problem in two ways:
1. Gale-Shapley Algorithm **|** Implementation of Alvin Roth and Lloyd Shapley's algorithm that assigns delegates to sessions in random order by accounting for both their preferences and ensuring that no two matching pairs will mutually want to switch their matches.
2. Iterative Preference **|** Implementation of a method suggested by a work experience student, Fatma Hussain, this takes chooses delegates and assigns them their n-th most preferred session provided the session is available. 
***

## References
- [The Stable Marriage Problem and School Choice](http://www.ams.org/publicoutreach/feature-column/fc-2015-03)
- [Gale-Shapley algorithm](https://www.nobelprize.org/nobel_prizes/economic-sciences/laureates/2012/popular-economicsciences2012.pdf)
- [matchingR](https://cran.r-project.org/web/packages/matchingR/vignettes/matchingR-intro.html)

