# Production Machine Learning Systems
*Course Link*: https://www.coursera.org/learn/gcp-production-ml-systems/
*Instructors*: Google

## Week 1
### Components of an ML System
- Only 5% code is model. Rest is supporting code.

#### Data Ingestion
- Stream/Batch options on GCP
  - Streaming: Pub/Sub
  - Structured data directly into model: BigQuery
  - Transforming and read later: Cloud Storage
- TF Record has better performance than CSVs

#### Data Analysis and Validation
- Understand the distribution of your data
- eg. what if product code changes (changing some new numbers and keepiong some old numbers)?
- How would you know this has happened? Look out for changes in dist of incoming data!
- In the new distribution, the most commonly occurring value might different.
- Depending on how you implemented your feature columns, these new values might be mapped to one component of a one-hot encoded vector or many components
-  If you used  hash buckets, the new values will be distributed according to the hash function. One hash bucket might now get more and different values than before. 
- If you used vocabulary, then the new values would map to out-of-vocabulary buckets. 
- For a given tensor, its relationship to the label before and now are likely to be very different
- 
- **Comparing distributions**
  - Five-number summaries to compare the center and spread of the data
  - count the number of modes comparing symmetry and skewness
  - compute the likelihood of observing the new distribution given the original distribution
  - are all expected features present?
  - Are any unexpected features present? 
  - Does the feature have the expected type? Does an expected proportion of the examples contain the feature?
  - Did the examples have the expected number of values for features?

#### Data Transformation
- Feature wrangling
- Should be saved and reused consistently
- DataFLow, DataProc, DataPrep

#### Trainer
- Should support data parallelism, model parallelism,scalable to large number of workers, support experimentation, support tuning
  - ML Engine - For TF
  - GKE  - For Hybrid ML models in KubeFlow
- No lock in

#### Tuner
- There are no globally optimal values for hyperparameters. Only problem specific ones.
- Tuner should support hp tuning-  operating  multiple experiments in parallel and ideally, using early experiments to guide later ones automatically.
-  2 main concerns
   - How safe the model is to serve
      -  Should not crashe or cause errors
      -  Memory, CPU
   - the model's prediction quality.
- Model evaluation assesses the model with respect to some business-relevant metric, like AUC or cost-weighted error
- unlike model evaluation, model validation component is not human facing
- instead, it evaluates the model against fixed thresholds and alerts engineers when things go awry
- TFX
  - some opensourced including TF Transform, TF Model Analysis, and TF Serving

#### Serving
- Low latency
- Highly efficient
- Scale horizontally
- Reliable and robust to failures
- At serving we care about responding to variable user demand maximizing throughput and minimizing response latency.
- the system should allow you to set up a multi-armed bandit architecture to verify which model versions are the best.
- ML Engine or TF serving on Kubernetes engine
- Logging is critical for debugging and comparison
- **All logs should be easily accessible and integrated** + the ability to craft alerting policies, and the ability to detect when new errors occur.

#### Orchastration + Workflow
- Help the system function as a whole, rather than as a bunch of cobbled together parts
- If I make change to the trainer, what component or components might also need to change? The answer is potentially all of them.
- Because everything needs to talk to everything else, **it's imperative that these components share resources, and a configuration framework**. Failure to do so, can result in large amounts of **glue code** to tie the system together. 
- Glue code arises from their attempts to run code that was never intended to be run in production in production.
- In GCP, orchestration can be done with Cloud composer, which is managed Apache airflow
- Another option for orchestration is to use Argo on Google Kubernetes engine. 

#### Integrated Frontend + Storage
- Visualization + Projections
- http://projector.tensorflow.org
- debug TF models, set breakpoints, view contents in the graph (alpha feature)

### Design decisions
- Physics is consant. Fashion is not.
- Is your model more like physics or fashion?
- Static training
  - acquire data > transform > train > test > deploy
  - trained once
  - offline
  - easy to build and test
  - easy to let become stale
- Dynamic training
  - above training steps over and over as more data comes in
  - engg is harder to do
  - needs progressive validation - new data might contain "bugs"
  - stays upto date with data
  - will adapt to changes

Eg. voice to text:
  - global = static
  - personalized = dynamic

- Dynamic training
  - Cloud Functions
  - App Engine
  - Cloud Dataflow

- Steps in dynamic training
  1. New file in cloud storage
  2. Cloud Fn launced
  3. Start Cloud MLE training job
  4. MLE writes new model

#### Serving Design Decisions

- We use a Cache 🤷 
- We use a table instead of memory
- Static serving lookup this table and serves the output
- Dynamic serving computes the model on demand

- **Static serving**
  - higher storage costs
  - low, fixed latency
  - lower maintenance
  - space intensive

- **Dynamic serving**
  - Lower storag costs
  - variable latency
  - higher maintenance
  - compute intensive

- **Peakedness** is how concentrated the distribution is. Inverse entropy. 
- Eg. Keyboard predictions - small number of words are used majority of the time. So it's dist is highly peaked.

- **Cardinality** is the number of values in the set.
- Eg. Pred sales revenue given the organization division number is low card 
- Eg. Lifetime value of a user in e commerce store is high- no of users. and their characteristics is very large

- If cardinality is low, use static training. If low, use dynamic.

- If the division is sufficiently peaked, use hybrid- caching the peaked values and computing the tail end predictions on the fly


**Estimate training and inference needs**
  - Predict whether email is spam: Dynamic
    - Make prediction *after* the email is received, and insulate your users from the latency of the model
    - How peaked is this? Not at all. Most emails are very different. 
    - Cardinality is high.
    - Dynamic serving is best

  - Android voice to text
    - Dynamic / Hybrid
    - Precomputed answers for "Ok Google"
    - Online preds for long tail
    - Hybrid works best

  - Shopping ad conversion rates
    - Static

**Architecting a static serving model**
1. Change Cloud MLE from online to batch prediction
2. Model accepts and passes keys as input
3. Write preds to data warehouse. eg. BigQuery

- Use **Apigee** or similar tools to do auth (Apiman, API Umbrella, ...)

- Build a system that predicts the traffic levels on roads
  - Multiple sensors in the city
  - We know the location of the sensor, as well as the type of road it is in
  - **Is this problem more like physics, or like fashion?**
    - **Fashion** 
    - Cities are dynamic
      - roads may be closed
      - trains may stop working forcing people to take road transport
      - roads may get reconstructed
      - drainage/flood/earthquake, accidents
      - sports events, parades

  - **Is it more peaked or less peaked**
    - More peaked because of the most heavily trafficed roads
  
  - **Cardinality: high, moderate, low, need more info?**
  - Need more info

  - **Why?**
  - Historical traffic data
  - Problem framing
    - Does our client want to make predictions in space?
      - Where we predict traffic some distance away from a given sensor.
    - Or in time?
      - Same place, but in the future.
    - Make preds for every minute, hour, or day?
    - How big is the region? Few feet / few blocks.
  - <strike> Variance of traffic level </strike>
    - This is a property of the label and not a feature

### Getting data to the cloud

- Common issues for customers
  - Volume of data
  - Low bandwidth
  - Checksumming, encryption, firewall
  - No time and few resources

- Soultions
  - CLoud upload
  - Appliance (server shipped to client)
    - Threshold is about **60TiB** of data 😲
    - 1 PB of data 
      - Appliance: 43 days
      - 100Mbps network: 1095 days (3 years)
    - Evernote used this:
      - 3PB of data
    - Makani wind farm
      - Real time distributed data collection (?) + data size
  - Cloud2Cloud service
    - Between cloud providers or between buckets in different regions
  - BigQuery transfer service
  
![What Storage to Use](https://i.stack.imgur.com/zufuC.png)


[What's the difference between BigQuery and BigTable?](https://stackoverflow.com/a/45018201)

**When should you consider using Cloud Transfer Appliance to load your data in GCP?**
  - [x] If you have 60+TB to load
  - [x] If you have 1TB+ data and a 10 Mbps network
  - [x] If online transfer would take more than a week
  - [x] If you have less than 10TB to load but a slow network connection (less than 10 Mbps)

### Adaping to data
- All of the below are likely to change and often will
  1. An upstream model
     - Your model depends on a weather prediction model
     - WP model was trained on wrong years of data
     - Your model is fit to the above outputs
     - Someone silently pushes an update to WP model
     - Now performance of your model drops as it was fitted with the distribution of the old model
  2. A data source maintained by another team
     - Your model consume web logs maintained by a different team
     - One day they switch over to a new logging format
     - Now your model starts receiving a lot of unexpected NULLs as features
     - Here are some possible fixes:
       - Think carefully before consuming data from sources when there is a chance you won't know about changes to them
       - Make a local version of upstream models and update it on your schedule (?)
  3. The relationship between features and labels
     - Under pressure during codesprint your team decided to throw in a **number of features** without thinking about it
     - One of them us causal, others are merely correlated with the causal feature
     - Model cannot make this distinction and takes all features into account equally
     - Months later, **correlated features become decorrelated with the label**
     - Model performance suffers
     - Fix:
       - All features should be scrutinized
       - All features should be subjected to **leave one out** evaluations for assessing their importance
  4. Distribution of inputs
     - mean baby weight changes over years
     - zip codes aren't fixed- old ones get deprecated and new ones get issued every year
     - if you use a vocabulary, and didnt specify an OOV bucket and didn't specify a default one, model may be skewed
     - new vocabb will be cast to -1
     - model may be forced to make preds in regions of the feature space that were not well represented in training data
     - predict outside the bounds of train dist: **extrapolation**
     - within the bounds: **interpolation**
     - Fixes:
       - Monitor descriptive stats of input and output vigilantly
       - Residuals = difference bw predictions and labels
       - If residuals 

### Exercise
- Why do abalation studies?
  - Some old features which were included at the begining might not be useful anymore because the new features make them redundant. There might also have been adding of **bundled features**, which collectively signalled something but individually do not add any value. Both of these represent additional, unnecessary data dependencies.

- Introducting code that we cannot inspect and modify is a **code smell**

- Data Leakage is when one of the features is a particuarly good indicator of the label, and is available during training but not during testing. Eg. Hospital name in the prediction of cancer. The model will still be able to make a prediction if we use vocab and have an oov bucket, but will not be a good predictor when patients haven't decided on a hospital. So now there is a change in the distribution of input during serving time where we have many more patients who haven't decided on a hospital.

- Class imbalance - > model learns to predict the majority class

- **Cross contamination**: Sentences vs political affiliation: eg. "Mind is a ..." 
  - If training data is split by sentence, same authors appear in multiple sets (train/dev/test)
  - This will make the model suscpiciously good.
  - If instead the data is divided based on the author name, the performace will be something more reasonable.

- **System failures**
  - On black friday, your transaction server goes down, but your web server stays up. Now your model thinks anyone who's clicking is not buying.
  - Its possible for your model to "unlearn" certain things its learnt over time. 
  - One option is to roll back the model to a previous date.

- You trained a static product recommendation engine which alone will determine what products users will see when on your website. 
  - Uses data from other users. 
  - Soon after deployment, user session time and conversion rate rise. 
  - Over time, it goes down- even more than the values we had before launch.
  - Model is not updated- and is not taking in new users, new products and new user behaviors
  - Users are now unable to get any new recommendataions
  - Users drop using the recommendation altogether, and make do with the site search functionality
  - Fix:
    - Understand the limits of your model
    - Dynamically retrain your model periodically

- **In adversarial environments, it is particularly important to retrain the model on a periodic basis.** Especially when model performance is dropping over time.

### Training serving skew
- Reasons
  - Diffferent pipelines in training and serving
  - Change in data
  - Feedback loop between model and your algorithm

- Code can also affect skew
  - Different library versions that are functionally equivalent but optimize differently
  - Different library versions that are not functionally equivalent
  - Re implementation of functions

- Could be mitigated if training and serving time code is the same. Could be achieved with polymorphism.

- Eg. training is batch, production is streaming data. 
  - This is actually common. 
  - Also in prediction, we need to send data and prediction to a data warehouse
  - Abstract methods for readInstances() and writePredictions() could help
    - PCollection -> collections of infinite size
    - ParDo -> parallel do 
- Online store (widget prediction model)
  - *Bad data* -> Underpredicts demand -> Product turnover increases
  - Sales are now low
  - Inventory storage is also now low, since system predicts so
  - Great example of why humans need to stay in the loop
  - In case a new company comes in that is very different in size to your current customers
    - There might be just one purchase order, but ...
    - Multiple departments may or may not be involved in it
    - Fix:
      - Aggregate by company type before passing it to prediction serice

- What is online store's inventory is flooded?
  - Need to scrap large portion of the inventory
  - Ordered replacements, but it will be 4 days before they arrive
  - Unfulfilled orders will have to wait
  - Fix:
    - Stop your model predictions
    - Data collected during this period will be contaminated because no. of customer orders will be low, because product will show as out of stock on the website


- Summary
  - Keep humans in the loop
  - Monitor everything
  - Prioritize maintainability
    - Constantly assess value of all data sources & weight the performance vs cost to maintain them
  - Get ready to roll back
    - There is no way to unteach a model what it has learnt already
  
### High performance ML
- time taken to train the **model to the same accuracy/evaluation measure**
- in this module, we'll only look at infrastructure performance
- besides time to train we also consider **budget**
- 3 consideration
  - time (depends on business use case)
    - are you redeploying daily? you only have 24 hrs to train.
    - do you do a/b testing? you'll have even fewer hours (~18hrs)
  - cost
    - incremental benefits vs cost
  - scale
    - choice of how much data you have 
    - single big machine vs multiple smaller machine
    - fine tuning / using earlier checkpoints

- **Model peformance will be bound by one of 3 things**
  - input/output (how fast data can get in to each training step)
    - io bound if you have large no. of inputs, heterogeneous, requiring parsing
    - or model is so small, the compute is trivial
    - or data is on a different storage system with very low throughput
    - Fix:
      - store efficiently
      - parallalize reads
      - consider batch size
  - cpu (how fast you can compute the gradinet)
    - expensive computations
    - underpowered hardware
    - Fix:
      - train of faster accelerator
      - upgrade processor
      - run on TPUs
      - simplify model
      - less computationally expensive activation fn
      - train for fewer steps
  - memory (how many weights you can hold at a time)
    - large no of inputs
    - complex model
    - accelerator doesn't have enough memory
    - Fix:
      - add more memory
      - use fewer layers
      - reduce batch size

- Tip: if you have a recommendation engine, you could:
  - precompute recommendations for top 20% of users
  - make it available in 5 hrs if it takes 18hrs to do training for full users
  - consider cost in what you're predicting and how much you're precomputing 

- If you're doing online prediction, the performance considerations are very different
  - the end user is actually waiting for the prediction
  - how many queries per second can be handled? (QPS)
  - typically cannot distribute the prediction graph
  - carry out the computation for one end user on one machine
  - scale out predictions to multiple workers
  - (microservice + k8s) or cloud ml engine

#### Distributed training

- TF automatically scales across all cores of the CPU
- Multiple machines with one or more accelerators (TPU, GPU)
- Methods:
  - Data parallelism
    - same model and computations across all devices
    - but different training examples
    - each one computes loss and gradients based on it's input
    - model is updated based on all these losses and grads
    - updated model is then used in the next round
    - Two approaches to data parallelism:****
      - **Async Parameter server arch**
        - **When to use:** Many low power or unreliable workers such as cluster of machines and constrained by i/o throughput
        - Some devices are designated to be parameter servers
        - Others are workers
        - Each worker independetly fetches the latest params from the param server, computes grads based on subset of train examples
        - sends grads back to param server
        - PRO: Highly scalable, fault tolerant
        - CON: Workers can get out of sync, computes grads based on stale values, slows down convergence
      - **Sync Allreduce** 
        - **When to use:** Multiple devices on one host - fast devices with strong links and constained by compute
        - GPU & TPU
        - Each worker holds a copy
        - Syncs with every other worker to propagate the weights and updates
        - Next cycle does not begin until all workers have recieved the updated parameters

#### Faster I/O pipelines
- Data should be available as soon as acclerator has finished processing its current batch
- I/O methods:
  1. Python dict feed - Slowest
  2. Native TF Ops - CSV, JSON
     - All implemented in C++
     - Key is not to bring the data back to Python
     - That context switch is very expensive
     - So implement input fns in terms of TF native ops 
  3. Read transformed TF records - Fastest approach
     - Requires some engineering overhead
     - Use Apache Beam / Spark to convert

#### ETL
  - Extraction -> i/o device
  - Transform -> CPU
  - Load -> GPU
  - Utilize idle time b/w these ops
  - TFRecordDataset(..., num_parallel_reads=40) # parallel read across sharded cloud storage
  - dataset.map(..., num_parallel_calls=8) # number of CPU cores available
  - dataset.prefetch(buffer_size=1) # Reduces time data is produced from the time it is consumed 
  - shuffle + repeat = shuffle_and_repeat
    - avoids performance stall by overlapping the buffer for Epoch n+1 while producing elements for Epoch n
  - map + batch = map_and_batch
    - parallelizes both the execution of map fn and the data transfer of each element into batch tensors
  - together these two steps imporve performance for models that consume a large volume of data per step

- `distribution = tf.contrib.distribute.MirroredStrategy` # Synchronous allreduce
- `run_config = tf.estimator.RunConfig(train_distribution=distribution)`
- runs training on all available GPUs


### Hybrid ML systems
- In order to be hybrid ready, you need to have 3 things:
  - composability
    - about composing a bunch of microservices that handle each step of the data pipeline
  - portability
    - develop/experimentations vs training on full dataset
    - "every difference b/w dev/staging/prod will bring an outage" - Joe Beda
  - scalability
    - accelerators
    - disks/network
    - engineers
    - skillsets...


### Embedded models
  - more efficient to run ML models in the edge than in the cloud
  - o/p gets sent to cloud
  - mobile cannot delegate to microservices
  - use a library to handle on device
  - train on cloud, predict on device
  - tensorflow lite
    - poor/missing net conn
    - sending continuous data will be too expensive
    - all blocking calls. run in separate thread
  - federated model


### Optimizing for mobile
  - Inception v3 -> 91MiB in storage, TF Binary 12MiB
  - Fits into a server but too large for mobile
  - To reduce model size:
    - Freeze graph
      - load time optimizations
      - converts vars into consts
      - var nodes are in a sep file, consts are embedded in the graph
      - cannot do continuous learning any more
    - Transforms the graph
      - remove unused nodes
      - remove trainig only nodes
      - eg. batch norm, computation nodes, debug nodes
      - **fold_batch_norms** folds convs followed by column mults into a single op
    - Quantize weights and calculations
      - reduces acc
    - Compressed Inception v3 -> 23 MiB, TF Binary 1.5 MiB