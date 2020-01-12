# Deployment of Machine Learning Models
**URL:** https://www.udemy.com/course/deployment-of-machine-learning-models/
**Authors:** Soledad Galli, Christopher Samiullah


## Resources
- Joblib explained - http://www.admin-magazine.com/HPC/Articles/Parallel-Python-with-Joblib

## Related notes
- [Randomness](./randomness.md)

## Section 2: Machine Learning Pipeline

### Feature Engineering
- Missing data
- Labels
    - Labels are strings rather than numbers
    - Cardinality: High number of labels
    - Rare labels
        - Present operational problem because of rarity
        - Some appear only in train set
        - Some appear only in test set
         
- Distribution: Normal vs Skewed
    - Linear model assumptions:
        - Variables follow a Gaussian model
    - Other models:
        - No assumption
        - Better spread of values may benefit performance 

- Outliers: Unusual or unexpected values
    - Strongly deviates linear models
    - Adaboost puts tremendous weights on outliers to correct mistakes

- Feature magnitude - Scale
    - Magnitude **insensitive**:
        - Classification/Regression trees
        - Random forests
        - GB trees

    - Magnitude sensitive:
        - Linear and Logistic regression
        - Neural Networks
        - SVM
        - kNN, k-means
        - PCA, LDA (Linear Discriminant Analysis)
    
    - Eg Area in sq feet(will be deemed more important) vs. No of rooms

### Why do we select features?
- Easier interpretation
- Shorter training time
- Enhanced generalization
- Simpler to implement and put into production
- Reduce risk of errors

### Reducing features for model deployment means:
- Less json messages sent over network
- Less code for error handling
- Less info to log
- Less feature engineering

### Variable redundancy
- Constant variables: only 1 value
- Quasi constant variables: only 1 value for 99% observations
- Duplication: same var multiple times
- Correlated variables

### Feature selection methods
- Filter models
    - **Pros**
        - Independent of ML models
        - Quick feature removal
        - Fast computation
    - **Cons**
        - Does not capture redundancy
        - Does not capture feature interaction
        - Lowest model performance

- Wrapper models
    -**Pros**
        - Consider feature interaction
        - Best performance
        - Best feature subset for a given algorithm
    -**Cons**
        - Not model agnostic (needs recomputation)
        - Expensive compute

- Embedded models (eg.Lasso regression)
    - Best of both worlds
    -**Pros**
        - Better than filter performance
        - Faster than wrapper
        - Good model performance
        - Captures feature interaction
    -**Cons**
        - Not model agnostic

### Model stacking / Meta ensembling
- Multiple independent models -> Meta models -> Preds
- Not included in this course

## 3. Machine Learning System Architecture

### Key principles for ML System Architecture
- Reproducibility
    - Ability to replicate given predictions
- Automation
    - Retrain, update and deploy ML models as part of an automated pipeline
- Extensibility
    - Easily add or update models
- Modularity
    - Clear pipelines for data flow
- Scalability
    - Volume and time constrains
- Testing
    - Variations between models

### Building a reproducible ML pipeline
- Focus is not just the model, rather the entire pipeline

### Reproducibility during data gathering
- Problems
    - Problems occur if training dataset cannot be reproduced at a later stage
    - Eg. constantly updated databases
    - Order of data during data loading is random eg. SQL loads data randomly

- Solutions
    - Save db snapshots
        - Good if data is not pulled from too many sources
        - Potential conflict with GDPR
    - Design data sources with accurate time stamps, so a view of the data at that time point can be retrieved
        - Ideal situation
        - If not in house, requires huge effort

### Reproducibility during feature creation
May arise from
    - Missing values replaced with random ones
    - Removing labels based on % of observations
    - Calculating stat values like mean for missing value replacement
    - Complex eqns to extract features (eg.aggregation over time)

- Solutions
    - Feature generation code should be version controlled and released incrementally
    - Ensure data used for FE is reproducible
    - If replacing by random, always set a seed


### Reproducibility during model building
- Record order of features
- Record applied feature transformations eg. standardisation
- Record hyperparameters
- For models using randomness(decision trees/NN), always set a seed
- If using meta models, always record the sturcture of the ensemble

### Reproducibility during model deployment
- Software versions should match exactly
- Use a container
- Use same language throughout for reserch, dev and deployment (eg. Python)
- Understand the big picture and how the model will be consumed
    - Some data may not be available at the time of consuming the model live
    - Filters in place do not allow a certain cohort of data to be seen by the model

## 4. Building a Reproducible Machine Learning Pipeline

### Procedural programming
- Use functions for everything (data loading, sampling, scaling)
- Have a train script that calls these functions and create a pipeline
- Have scoring script that creates preds using the same imported functions
- YAML file (for configurations, hardcoded values, model/data path, list of features)

- Pros
    - Straightforward
    - No software developement skills required
    - Easy to manually check
- Cons
    - Cann get buggy
    - Difficult to test
    - Difficult to develop software on top of it
    - Need to save a lot of intermediate files for transformations

### Designing a custom pipeline
- OOP concepts
- Save the object as a single pickle

### Sklearn Pipeline
Scikit Learn Objects
- Transformers
    - Transformers have `.fit()` and `.transform()`
    - Eg. Scaler, Feature selectors, One hot encoders

- Predictors
    - Predictors have `.fit()` and `.predict()`
    - Any ML model

- Pipeline
    - All steps should be transforms except last one
    - Last should be predictor
    - You can write custom transformers to be used with sklearn Pipeline
    - Easy to inherit from `sklearn.base`'s `TransformerMixin` and `BaseEstimator`

### Feature selection in CI/CD
- Advantages
    - Reduce overhead in implementation of new model
    - New model is almost immediately available to business
- Disadvantages
    - Lack of data versatility
    - No additional data can be fed throught the pipeline (eg. data from new sources)

- Ensures that from all the features, only the most useful ones are selected for training
- Potenially avoides overfitting
- Need to deploy code for FE for all variables regardless of whether they will be used in the final model or not
- Error handling and unit testing for all FE code

- Suitable if:
    - Model built and refreshed on same data source
    - Smaller datasets

- Not suitable if:
    - datasets have high feature space (tests, FE)
    - model is constantly enriched with new data sources


## 6. Hands on with housing prices prediction
- Ensure modularity
- Write tests for single as well as multiple predictions
- Ensure all preprocessing is nicely abstracted away
- Separate out any feature engineering:
    - Lines between feature engineering and preprocessing can be very blurred
    - You might even need to call external APIs for feature engineering
    - Eg. sending out location co-ordinates to get crime statistics

### Versioning and Logging 
- `TimedRotatingFileHandler`
- `logger.propagate`
- In the `save_pipeline` method, delete any existing model files
- You can use `logger.info` when running pytest and it will still work (unlike `print`)
- Log model_version, input, predictions

## Building the package
- [Video](https://www.youtube.com/watch?v=na0hQI5Ep5E) Inside the Cheeseshop: How Python Packaging Works | SciPy 2018 | Dustin Ingram 
- Docs on packaging: https://packaging.python.org/
- Needs
    - `requirements.txt`
        - Include `setuptools`, `wheel` (but why? we're packaging from host environment, right?)
        - Explicitly specify versions
    - `setup.py`
    - `MANIFEST.ini` - specify what dirs and files to include in the package
- run `python setup.py sdist bdist_wheel`
- this will create source distribution (`.tar.gz`) and wheel distribution(`.whl`) repectively
- Use pip install -e regression_model

## 7. Serving our model with a REST API
- Serve predictions to multiple clients
- Decouple model development from client facing layer
- Potentially combine multiple models at different API endpoints
- Scales horizontally

### Structure
```
    + root/
    |_ ml_api/
        |_ app/
            |_
        |_ requirements.txt (contains `-e "path/to/regresion/model"`)
        |_ __init__.py
    |_ regression_model
```
- Use blueprints if necesary(subdomains, url-prefixes etc) 
- Don't forget to register the Blueprint
- Have a heartbeat api "/health" that always returns 200 OK, "ok", so you can see the text on your browser

### Configurations
- Create confgs as classes:
    ```python
        class Config:
            DEBUG = False
            TESTING = False
            CSRF_ENABLED = True
            SECRET_KEY = 'this-really-needs-to-be-changed'
            SERVER_PORT = 5000
        
        class ProductionConfig(Config):
            DEBUG = False
            SERVER_PORT = os.environ.get('PORT', 5000)
        
        class DevelopmentConfig(Config):
            DEBUG = True
            DEVELOPMENT = True
        
        class TestingConfig(Config):
            TESTING = True
    ```
- Make the API a thin layer
- Have api versions included in the route `/v1/regression-model/predict`
- This is NOT the model version, but the api version, so we can change the API contract later
- `/version` endpoint should return both model version as well as api version
- No feature engineering or adjustnments should in the /predict api
- They should be within the model package
- Log both inputs and outputs in separate steps so you don't break if model.predict() fails
- When returning response, send model version number too
- When writing tests for the API, testing file should come directly from the model package
- So when model changes, test is automatically updated
- Have a `validate_inputs` function to validate inputs to model (eg. data types) or return appropriate error
- You could filter invalid inputs from inputs received, and return all error rows with the response of the `/predict` endpoint
- If you have a field beginning with a number, you might have to hack around this, because Python doesn't let you create variables starting with numbers

## 8. Continuous Integration / Continuous Deployment

- CI -> C Delivery -> C Deployment

- CI [Build -> Test -> Merge]
- Continuous Delivery [Automatically release to repository]
- Continuous Deployment [Automatically deploy to production]

- System is always in a releasable state
- Faster regular release cycle
- Build and test is automated
- Delivery and deployments are automated
- Visibility across the company


### Publishing to Package Index server
- Gemfury is one such private PI server
- set up env variable PIP_EXTRA_INDEX_URL==https://token@pypi.fury.io/username
- now you can remove `-e` from requirements, and pull in with the version number directly
- First time you publish to Gemfury, make sure you train_and_upload_to_gemfury first, before testing ml_api, otherwise, when we test ml_api, it wont be able to find anything in gemfury
- However, once you have the initial model in gemfury, swap this back because we don't want to publish before we run the tests
- Use CI caches if necessary. You can use checksum to see if a file has changed, and restore the cache.
- Train and upload model only when in __master__
- How to deal with ml_api model version requirements within CI?