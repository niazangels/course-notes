# Randomness

## Resources
- https://machinelearningmastery.com/randomness-in-machine-learning/
- https://machinelearningmastery.com/reproducible-machine-learning-results-by-default/

## Where does randomness creep in from
1. Randomness in data collection
    - Trained with different data, same algorithms produce different models
2. Randomness in observation order
    - Think neural networks
3. Randomness in the algorithm
    - Algorithm may be initialized to random state
    - Votes that end in a draw (and other internal decisions) during training in a deterministic method may rely on randomness to resolve
4. Randomness in sampling
    - Too much data?
    - Sampling algorithm will introduce randomness
5. Randomness in resampling
    - Think k-fold cross validation
    
## Tactics To Address The Uncertainty of Stochastic Algorithms
1. Reduce the uncertainty
    - Use k fold, increase k
    - Repeat the experiment n times (random repeats / random restarts)
2. Report the uncertainty
    - Never report the performance of a model with a single number
    - Once you have gathered a population of performance measures, use statistics on this population. This tactic is called report **summary statistics**
    - The distribution of results is most likely a Gaussian, so a great start would be to report the mean and standard deviation of performance. Include the highest and lowest performance observed.
    - You can then compare populations of result measures when you’re performing model selection. Such as:
        - Choosing between algorithms.
        - Choosing between configurations for one algorithm.
    - Lean on statistical significance tests. Statistical tests can determine if the difference between one population of result measures is significantly different from a second population of results.
    - Report the significance as well. This too is a best practice, that sadly does not have enough adoption.

## About Final Model Selection
- The final model is the one prepared on the entire training dataset, once we have chosen an algorithm and configuration.
- "Should I create many final models and select the one with the best accuracy on a hold out validation dataset?" **No** This would be a fragile process, highly dependent on the quality of the held out validation dataset. You are selecting random numbers that optimize for a small sample of data.
- Take the first model, it’s just as good as any other
- If required, build an ensemble of models, each trained with a different random number seed
- Use a simple voting ensemble. Each model makes a prediction and the mean of all predictions is reported as the final prediction.
- Make the ensemble as big as you need to.
- Maybe keep adding new models until the predictions become stable. For example, continue until the variance of the predictions tightens up on some holdout set.