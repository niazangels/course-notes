# Fastai
- Author: Jeremy Howard, Rachel
- URL: https://course.fast.ai/

# Lesson 1
-  **Metric**: A metric is a function that measures the quality of the model's predictions using the validation set.
-  **Metric vs Loss**: The purpose of loss is to define a "measure of performance" that the training system can use to update weights automatically (easy for stochastic gradient descent to use). Metrics are for humans- it's easy to understand, and is close to what you want the model to do.
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

### Hiring third parties
- This same discipline can be critical if you intend to hire a third party to perform modeling work on your behalf.
-  if you're considering bringing in an external vendor or service, make sure that you hold out some test data that the vendor never gets to see. Then you check their model on your test data, using a metric that you choose based on what actually matters to you in practice, and you decide what level of performance is adequate. 
-  It's also a good idea for you to try out some simple baseline yourself, so you know what a really simple model can achiev


### Splitting data

- a key property of the validation and test sets is that they must be representative of the new data you will see in the future

- random split may not always be a good choice

- For TS problems, choose a continuous section with the latest dates (last 2 weeks or last month of available data) as your validation set

- Distracted driver competition had photos of drivers in the test set who never appeared in the training set
