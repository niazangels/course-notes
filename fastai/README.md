# Fastai
- Author: Jeremy Howard, Rachel
- URL: https://course.fast.ai/

# Lesson 1
-  **Metric**: A metric is a function that measures the quality of the model's predictions using the validation set.
-  **Metric vs Loss**: The purpose of loss is to define a "measure of performance" that the training system can use to update weights automatically (easy for stochastic gradient descent to use). Metrics are for humans- it's easy to understand, and is close to what you want the model to do.
   - "You need a fn where if yu change the params a little bit, you need to know if your model gets a little bit better or a little bit worse. Some of these **changes are so subtle that it won't change any of the predictions** and so the metric would remain the same- but the loss would definitely change"
   -  
-  **Model**: The combination of the architecture with a particular set of parameters
-  
- The architecture only describes a *template* for a mathematical function
- fastai has both `fit` and `finetune`
- `finetune`
  1. Use one epoch to fit just the head to work correctly with your dataset.
  1. Use the number of epochs requested when calling the method to fit the entire model
- Pretrained models are not widely available for any tabular modeling tasks, although some organizations have created them for internal use
- Tip: start by using one of the cut-down versions of the dataset and later scale up to the full-size version 
- If a model makes an accurate prediction for a data item, **that should be because it has learned characteristics of that kind of item**, and not because the model has been shaped by actually having seen that particular item.
- Why do we need test datasets?
  - We, as modelers, are evaluating the model by looking at predictions on the validation data when we decide to explore new hyperparameter values! So subsequent versions of the model are, indirectly, shaped by us having seen the validation data. Just as the automatic training process is in danger of overfitting the training data, we are in danger of overfitting the validation data through human trial and error and exploration.
  - training data is fully exposed, the validation data is less exposed, and test data is totally hidden.
  - "There is a point where your validation loss could be getting worse but your val metric(acc / error) is getting better.. So the important point to detect is your **metric** getting worse, not your **loss** getting worse"

### Hiring third parties
- This same discipline can be critical if you intend to hire a third party to perform modeling work on your behalf.
-  if you're considering bringing in an external vendor or service, make sure that you hold out some test data that the vendor never gets to see. Then you check their model on your test data, using a metric that you choose based on what actually matters to you in practice, and you decide what level of performance is adequate. 
-  It's also a good idea for you to try out some simple baseline yourself, so you know what a really simple model can achiev


### Splitting data

- a key property of the validation and test sets is that they must be representative of the new data you will see in the future

- random split may not always be a good choice

- For TS problems, choose a continuous section with the latest dates (last 2 weeks or last month of available data) as your validation set

- Distracted driver competition had photos of drivers in the test set who never appeared in the training set

# Lesson 2

- DL isnt good for generating accurate information- but its goiod at generating things that sound accurate. We currently don't have great ways to make sure they're correct

- How do we decide if there is a relationship?
  - Start with a null hypothesis ("There's no relationship")
  - Gather data of dependent and independent variables
  - What percent of time do we see this(which?) relationship by chance? 
    - There's a simple equation we can use for this
  - Here's the thing
    - p-values are terrible [American Statistical Association](https://www.amstat.org/asa/files/pdfs/P-ValueStatement.pdf)
      1. P-values can indicate how incompatible the data are with a specified statistical model.
      2. 2.P-values do not measure the probability that the studied hypothesis is true, or the probability that the data were produced by random chance alone. 
         1. J: "As you can see when we collected data from 3000 cities, p-values were much lower"
      3. Scientific conclusions and business or policy decisions should not be based only on whether a p-value passes a specific threshold.
      4. Proper inference requires full reporting and transparency.
      5. A p-value, or statistical significance, does not measure the size of an effect or the importance of a result.
      6. By itself, a p-value does not provide a good measure of evidence regarding a model or hypothesis
   - J: **"I've shown you this so you know why they don't work- not so that you can use them"** 
   - What if you picked the opposite hypothesis? "There is a relationship"
     - Do I have enough data to reject that hyp?
   - Univatiate vs Multivariate
     - If you look at just univariate models (one independent var vs one dependent var), there might not seem like there;s a relationship
     - But if you look at multivariate models, there might be enough significance for the same variables (temp and humidity in this case)
     - Why?
       - Denser cities are going to have more transmission
       - More humid might mean less transmission
       - When you do a multivariate model, it allows you to be more confident about your results
   - p-value still does not tell us whther this is of practical importance
   - The thing that does tell us this is the slope
     - Change the value of temp and humidity and see the effect on output
       - In this case, temp = 35, rel hum = 40 yielded R < 0.8 (no transmission of disease)
       - But if we plug in 10, 15, then there's a massive explosion of disease (R>2)
   - [Designing great data products - Jeremy Howard](https://www.oreilly.com/radar/drivetrain-approach-data-products/)
   - Autocorrelated
     - Places that are close to each other geographically have similar temp and humidit
     - So you cant think of these as separate cities, because the ones close to each other have similar behaviour
   - Consider utiilty: What would be the economic and social implications 
       - No real relationship, Act as if there was
       - No real relationship, Don't act as if there was
       - Is real relationship, Act as if there was
       - Is real relationship, Don't act as if there was
   - Priors
     - Flu virus dies at 27 deg C
     - Other coronaviruses are seasonal
     - 1918 flu was seasonal
     - Climate relationship seen in every country and city studied (?)
     - All this might let us conclude Covid is seasonal

![Data loader creation](../images/168e45947d4b6c329ac333019b2cbc5e4fc8f9b518d8d9af96b8eceb7041deed.png)  

