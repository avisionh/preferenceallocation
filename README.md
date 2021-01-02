# Preference Allocation
[![Travis-CI Build Status](https://travis-ci.org/avisionh/Preference-Allocation.svg?branch=master)](https://travis-ci.org/avisionh/Preference-Allocation) [![CodeFactor](https://www.codefactor.io/repository/github/avisionh/preferenceallocation/badge)](https://www.codefactor.io/repository/github/avisionh/preferenceallocation) [![License: MIT](https://img.shields.io/badge/License-MIT-informational.svg)](https://opensource.org/licenses/MIT)

# Overview
preferenceallocation explores methods for solving *preference allocation*/*one-sided matching* problems.

Consider that we have to assign *x* people to *y* sessions. For each of these *y* sessions,
and individual person will have a preference ordering, meaning that they strictly prefer some sessions over others.

The task is to allocate these *x* people to their *y* sessions, accounting for their preferences
in such a way that the total utility of all *x* people is maximised.

## Methodology
We will tackle this problem in two ways:
1. **Gale-Shapley Algorithm |** Implementation of Alvin Roth and Lloyd Shapley's algorithm that assigns delegates to sessions in random order by accounting for both their preferences and ensuring that no two matching pairs will mutually want to switch their matches.
1. **Iterative Preference |** Implementation of a method suggested by a work experience student, Fatma Hussain, this takes chooses delegates and assigns them their n-th most preferred session provided the session is available. 

## Usage
To see how to use the bespoke *iterative preference* method proposed in this repo, access and run the `src/iterative_preference.R` script.

To see how to use [matchingR](https://github.com/jtilly/matchingR)'s implementation of Gale-Shapley algorithm, access and run the `src/galeshapley.R` script.

> Note: Your data needs to be in tidy data format for *iterative preference* whereas for the Gale-Shapley algorithm, it does not.

WIP Shiny app is being developed so you can enter your data and apply the iterative preference method on it to get matchings.
- https://avisionh.shinyapps.io/preference20allocation/

Documentation of how each method works is available in these slides:
- https://avisionh.github.io/preferenceallocation/

## Getting help
If you encounter a clear bug, please fill a minimal reproducible example on [Issues](https://github.com/avisionh/preferenceallocation/issues). For questions and other discussion, please use the [Discussion](https://github.com/avisionh/preferenceallocation/discussions) channel.

***

# Case Study
This algorithm was used in the 2018 and 2019 versions of the [GSS Conference](https://gss.civilservice.gov.uk/) to allocate a set ofvconference delegates to a series of talks that were taking place at the same time. 

These talks were delivered by internal government and external private sector companies.

In total, there were four sessions of five simultaneous talks. As such, this algorithm was run four times to produce matchings between delegates and these five simultaneous talks.

**Note:** The rooms in which the speakers delivered their presentations were not pre-allocated. Instead, the decision to place more popular talks (based on people's preferences) in larger rooms was based on plotting the distribution of preferences for the five simultaneous talks for all delegates.

## EARL 2019
This project was presented at [Enterprise Application of the R Language (EARL) Conference](https://www.mango-solutions.com/earl-speaker-highlights-from-the-mango-team/) in 2019.

## References
- [The Stable Marriage Problem and School Choice](http://www.ams.org/publicoutreach/feature-column/fc-2015-03)
- [Gale-Shapley algorithm](https://www.nobelprize.org/nobel_prizes/economic-sciences/laureates/2012/popular-economicsciences2012.pdf)
- [matchingR](https://cran.r-project.org/web/packages/matchingR/vignettes/matchingR-intro.html)

