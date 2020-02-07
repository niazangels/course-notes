# End-to-End Machine Learning with TensorFlow on GCP
- Course link: https://www.coursera.org/learn/end-to-end-ml-tensorflow-gcp/
- Course repo: https://github.com/GoogleCloudPlatform/training-data-analyst/
- Instructors: Lak Lakshmanan
- Completed on 07 February 2020

### Resources
- [Slides for the course](slides/)
- Demonstration of TensorFlow Feature Columns (tf.feature_column) - https://medium.com/ml-book/demonstration-of-tensorflow-feature-columns-tf-feature-column-3bfcca4ca5c4
- An Advanced Example of the Tensorflow Estimator Class - https://towardsdatascience.com/an-advanced-example-of-tensorflow-estimators-part-1-3-c9ffba3bff03

## Week 1

### Overview
1. Explore and visualize a dataset
2. Create sampled dataset
3. Develop a TensorFlow model
4. Create full size training and evaluation datasets (Use Cloud Dataflow so same preprocessing can be applied to both train and eval)
5. Execute training
6. Deploy prediction service
7. Invoke prediction

### Resources

- Repository: https://github.com/GoogleCloudPlatform/training-data-analyst
- Blog: Repeatable Sampling - Lak Lakshman: https://towardsdatascience.com/ml-design-pattern-5-repeatable-sampling-c0ccb2889f39
- Kolmogorov-Smirnov Test: http://www.physics.csbsju.edu/stats/KS-test.html
- ML Design Pattern: https://medium.com/@lakshmanok/machine-learning-design-patterns-58e6ecb013d7

### Effective ML

- Figure out a way to train your models on **as much data as possible**
- Don't sample the data, don't aggregate the data- use as much data as possible
- Batching and distribution becomes important here
- Things like gradient descent operations **are not embarassingly parallel**
- You'll need parameter servers that form shared memory that's updated during at each step
- Scaling out (horizontal scaling) is the answer, not scaling up (vertical scaling)
- Another common shortcut people take is sampling their data so that it is small enough to do machine learning on the hardware that they happen to have
- They're leaving **substantial performance gains** on the table if they do that.
- Using all available data and devising a plan to gather even more data is the difference between models that don't work and models that appear magical.

### Fully managed ML service
- At some point you stop wondering how long it'll take to train and start thinking about how you can increase the number of requests per seconds you can handle
- This requires autoscaling of the prediction code.
- Who does the preprocessing? 
  - Cannot pass in the raw input to the trained model as it expects scaled, transformed data
  - The embedding or index of a word in an NLP model will change based on the data
  - Minimum, maximum, std. dev can all change with data
  - Bookkeeping for this is a major source of error. It is also nearly impossible to debug
  - This leads to training serving skew
  - Cloud ML promises repeatable, scalable, tuned ML models

### Exploring the data

- Shouldn't the model take all the data and do the best possible job with it?
- Real life doesn't work that way. Many times, the data as is recorded, isn't what you're expecting.
- Many features or data points might be missing or wrong
- Using data without understanding it will make productionizing hard
- Even at Google, most ML models operate on **structured data**
- Even if you have a lot of data, you probably **shouldn't be using data that is too old**

### BigQuery

- BigQuery is charged based on the amount of data processed

## Week 2

### Creating the dataset
- Start with a small subset of the data. Chances are your model isn't going to execute properly the very first time. It's much better to debug on a small data set. If you were to use the full dataset, it can take hours or even days to make updates to your code.
- What if certain features are known only some of the time? It would be a good idea to build two models, one with sex and plurality and one without. 
- Another approach is that instead of building two separate models, we can build **only one model but train the model both with fully known data and with masked data**. That way, the same model can be used in both situations

-Random splitting
  - Random sampling eliminates potential biases due to the order of the training examples. But... 
  - Consider three rows with essentially the same data, three babies for whom the mother's age, gestation weeks, and other features are all the same. We don't want what are essentially nearly identical data points to be in both training and evaluation. We want them to fall into one or the other. That would result in leakage of information from the training dataset to the evaluation dataset
  - Consider three rows with essentially the same data, three babies for whom the mother's age, gestation weeks, and other features are all the same. We don't want what are essentially nearly identical data points to be in both training and evaluation. We want them to fall into one or the other. That would result in leakage of information from the training dataset to the evaluation 
  - One way to achieve this is to use the last few digits of the hash function on the field that you're using to split your data. Eg.Farm fingerprint 
  - This will now be repeatable because the farm fingerprint function returns the same value anytime and is invoked on a specific date. You can be sure that you will get the exact same 80 percent of the data each time.
  - If you want to split your data by arrival airport so that 80 percent of airports are in the training dataset, compute the farm fingerprint on arrival airport instead of date.
- What filter do you use to hash on? You want it to be randomly spread throughout. You cannot split by year because babies' weights actually have a long term trend. Use a concatenated string of year and month


- Base query
  ```sql
  SELECT 
    weight_pounds,
    is_male,
    mother_age,
    plurality,
    gestation_weeks,
    ABS(FARM_FINGERPRINT(CONCAT(CAST(YEAR AS STRING), CAST(month as STRING)))) AS hashmonth

  FROM
    publicdata.samples.natality
  WHERE year > 2020
  ```

  - See aggregate stats:
  ```sql
  SELECT hashmonth, COUNT(weight_pounds) AS num_babies FROM (base_query) GROUP BY hashmonth
  ```


  - Sampling 80 % for training: `sampling_query`
  ```sql
  SELECT COUNT(weight_pounds) FROM (base_query) WHERE MOD(ABS(hashmonth), 10) < 8
  SELECT * FROM (base_query) WHERE MOD(ABS(hashmonth), 10) < 8
  ```
 - Also run with `=8` and `=9` for the testm, eval  

- Sampling far fewer items (You need to see what fraction you get and adjust `RAND` condition accordingly)
 
 ```sql
   sampling_query AND RAND()  < 0.001
 ```

- See counts quickly using `df.describe()`
- If there any mismatch in counts, update SQL accordingly
  ```sql
  base_query AND is_male IS NOT null AND plurality IS NOT null;
  ```


- **Simulating unknown data**: Create a copy of the df. Hide/mask relevant columns of the dataset. Add it back to the original dataset. Eg. `plurality`, `is_male` could be unknown without an ultrasound test.

### Building the model
- Edges in graph represent arrays of data
- Nodes represent mathematical operators

- **Working with the Estimator API**
  - Setting up the ML model
    1. Regression / Classification?
    2. What is the label
    3. What are the features
  - Carrying out ML steps
    1. Train the model
    2. Evaluate the model
    3. Predict with the model

- Bucketizing:
  - Why would you want to split a number into a categorical value?
  - Categorization splits a single input number into a four-element vector: Therefore, the model now can learn four individual weights rather than just one; four weights creates a richer model than one weight. 
  - More importantly, bucketizing enables the model to clearly distinguish between different year categories since only one of the elements is set (1) and the other three elements are cleared (0).

- Think in terms of *steps, not epochs*. An epoch is rather arbitrary. As data continues to grow, it'll take longer and longer to complete training over an epoch

- [Reading from CSV, Shuffling, TrainSpec, EvalSpec](slides/)



### Creating a TensorFlow model
- Inputs like price and wait time are **dense features**
- If price increases, customer satisfaction goes down
- If wait time increases, customer satisfaction goes down
- But a customer served by **employee_id=2** is not likely to be 9x satisfied than one served by **employee_id=8345**. One hot encode this. This is a sparse feature.
- **DNN work if inputs are dense and highly correlated.**
- **Linear models are better at handling sparse and independent models** 
- IRL you'll have both sparse and dense features.
- Wide and deep model uses Linear models for sparse features (memorize input space), and DNNs for dense features (`tf.estimator.DNNLinearCombinedClassifier`)
- Wide = memorization, relevance(?)
- Dense = generalization, diversity
- > **We don't want to evaluate too much because eval comes at a cost**

### Operationalizing the model
- We need to build a pipeline to convert data to features
- **Apache Beam**
  - Pipelines definition is different from execution
  - Only exucuted when `.run()`
  - Supports both **B**atch and Str**eam** (Beam)
  - Supports a variety of connectors, or you can write your own

- **Cloud Data Flow**
  - Python and Java
  - Serverless
  - Fully managed & elastic

- A `key` column helps associate predictions with input after being processed as batch over distributed compute


### Deploying the model
- Can't use training input fn for serving: serving input fn might need to parse differnt input (JSON) instead of CSV
- Also, serving time inputs from user may be fewer (eg. time can be pulled from the system clock- user does not have to supply it)