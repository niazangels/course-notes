# Building Machine Learning Powered Applications
- URL: https://www.oreilly.com/library/view/building-machine-learning/9781492045106/
- Author: Emmanuel Ameisen
- Released: January 2020
- Publisher(s): O'Reilly Media, Inc.
- ISBN: 9781492045113


# Preface

- > "Deploying ML as part of an application requires a blend of creativity, strong engineering practices, and an analytical mindset."

- > "To successfully serve an ML product to users, you need to do more than simply train a model. You need to **thoughtfully translate your product need to an ML problem, gather adequate data, efficiently iterate in between models, validate your results, and deploy them in a robust manner**."

## The ML Process
- Four key successive stages
    1. **Identifying the right ML approach**:  ML is broad- the best approach for a given problem will depend on many factors such as success criteria, data availability, and task complexity. The goals of this stage are to **set the right success criteria** and to **identify an adequate initial dataset and model choice**.
   
   2. **Building an initial prototype**: Start by building an **end-to-end prototype with no ML involved. This will allow you to determine how to best apply ML**
   
   3. **Iterating on models**: Now that you have a dataset, you can train a model and evaluate its shortcomings. The goal of this stage is to repeatedly alternate between error analysis and implementation."

   4. **Deployment and monitoring**: Once a model shows good performance, you should pick an adequate deployment option. **Once deployed, models often fail in unexpected ways.**

# Part I - Find the Correct ML Approach

# Chapter 1 - From Product Goal to ML Framing

- It is important to **identify which parts of a product would benefit from ML** and how to **frame a learning goal** in a way that **minimizes the risks of users having a poor experience**.

- An application that calculates your taxes automatically should rely on guidelines provided by the government. The use of ML for automatically generating tax returns a dubious proposition.

- > "You **never want to use ML** when you can solve your problem with a **manageable set of deterministic rules**."

## Estimate what is possible

- Guidelines that can help you reduce the risk associated with tackling an ML project: 
  - Always start with a product goal to then decide how best to solve it. At this stage, be open to any approach whether it requires ML or not. 
  - When considering ML approaches, evaluate them based on how appropriate they are for the product, and not based on how interesting the methods are
  - The best way to do this is by following two successive steps: 
    1. **Framing your product goal in an ML paradigm**
       - start thinking of what service we want to deliver to users
       - for one product goal, there are usually many different ML formulations, with varying levels of implementation difficulty.
    2. **Evaluating the feasibility of that ML task**
       - consider multiple potential ML framings and start with the ones we judge as the simplest

### Models
- **weakly supervised algorithms** leverage labels that aren’t exactly the desired output but that resemble it in some way.

- Generally, supervised approaches are easier to validate since we have access to labels to assess the quality of a model’s prediction.

- While creating a labeled dataset can sometimes be time-consuming initially, it makes it much easier to build and validate models.

- Some standard appraches:
    1. **Classification and regression**
       - Methods to tackle regression and classification  have significant overlap
       - Most classification models output a probability score for a model to belong to a category. The classification aspect then boils down to deciding how to attribute an object to a category based on said scores.
       -  Classification model can be seen as a regression on probability values.
    2. **Knowledge extraction**
       - NLP: extracting spans, categorizing them
       - Images: finding areas of interest and categorizing them
       - Extracted information can be used as an input to another model. 
       - Eg. pose detection model:
         - extract key points from a video of a yogi
         - second model classifies the pose as correct or not based on labeled data
    3. **Catalog organization**
       - Often produce a set of results to present to users. 
       - Results can be conditioned eg.
         - an input string typed into a search bar
         - an uploaded image
         - a phrase spoken to a home assistant 
       - **Collaborative**: Recommendations are based on learning from previous user patterns
       - **Content based**: Recsys based on particular attributes of items
       - Some systems leverage both collaborative and content-based approaches.
    4. **Generative models**
       - Have outputs that are less constrained
         - riskier choice for production.
         - starting with other models first unless absolutely necessary

### Data
- If a dataset contains features that are predictive of the target output, it should be possible for an appropriate model to learn from it. 
- Most often we do not initially have the right data to train a model to solve a product use case from end-to-end.
- Rarely  able to find the exact mapping we are looking for.
- >**It is common to mistake the dataset that you find for the dataset that you need.**

- **Weakly labelled**: contain labels that are not the perfect modeling target, but somewhat correlated 
  - Playback and skip history for a music streaming service are examples of a weakly labeled dataset for predicting whether a user dislikes a song. 
  - If they skipped it as it was playing, it is an indication that they may have not been fond of it. 
  - Weak labels are less precise but  easier to find than perfect labels.

- Case study 
  - ![picture 1](images/389b55f2f8305b0582a4bb5c158faca82f259935f622382029fc7ab413271b36.png)  

  - Perfect case: an ideal dataset would be a set of user-typed questions, along with a set of better worded questions. 
  - A weakly labeled : many questions with some weak labels indicative of their quality such as “likes” or “upvotes.” 
    - Helps a model learn what makes for good and bad questions but would not provide side-by-side examples for the same question.

 
- In practice, most datasets that we can gather are weakly labeled.
- **Having an imperfect dataset is entirely fine and shouldn’t stop you**. 
  - ML process is iterative in nature, 
  - Starting with a dataset and getting some initial results is the best way forward, regardless of the data quality.

## Framing the Editor

### Trying to Do It All with ML: An End-to-End Framework
- **Data**
  - Could attempt to gather a dataset of poorly formulated questions, and their professionally edited versions. Then use a generative model to go straight from one text to the other.
  - Expensive
  - Time consuming
  - Need professional help
- **Models**: 
  - Seq2Seq models?
    - success of these models has mostly been on sentence-level tasks, no longer than a paragraph
    - slow to train
    - If it needs to be retrained hourly or daily, training time can become an important factor
- **Latnecy**
  - slow to train
  - can take a **few seconds at inference time**, as opposed to subsecond latency for simpler models
- **Ease of implementation**
    - other teammates may need to iterate on this?
      - choose a set of simpler, more well-understood models
      - 

### The Simplest Approach: Being the Algorithm
- Leverage prior art to define what makes a question or a body of text well written. 
- Consult a professional editor or research newspapers’ style guides to learn more.
- Dive into a dataset to look at individual examples and trends and let those inform our modeling strategy.

- Case study
  - **Prose simplicity**: Use simpler words and sentence structures
  - **Tone**: Measure the use of adverbs, superlatives, and punctuation to measure the polarity of the text
  - **Structural features**: Extract the presence of important structural attributes such as the use of greetings or question marks.

- Now **build a simple solution with no ML involved** to provide recommendations. This phase is crucial for two reasons: 
  1. it provides a baseline that is very quick to implement 
  2. serve as a yardstick to measure models against

### Middle Ground: Learning from Our Experience
- Once we have a baseline set of features, attempt to use them to **learn a model of style from a body of data**. 
- To do this, train a classifier to separate good and bad examples
- Inspect it to identify which features are highly predictive and use those as recommendations.
- ![picture 2](images/df3f666499ba65764f3c2a35269774deae4f39da25bbfdca1660cc7b80be5adc.png)  

- **Dataset**
  - gather questions from an online forum along with some measure of their quality, such as the number of views or upvotes
  - cheaper and easier
- **Model**
  - Consider two things here: 
    1. how predictive a model is 
       - can it efficiently separate good and bad articles
    2. how easily features can be extracted from it 
       - can we see which attributes were used to classify an example
- **Latency**
  - classifers are quick
  - return results in less than a tenth of a second on regular hardware
- **Ease of implementation**
  - well understood

- Start with a human heuristic and then build this simple model to have an initial baseline
- Great way to inform what to build next

## Monica Rogati: How to Choose and Prioritize ML Projects
- only use ML if it makes sense
- design the product around handling ML failures gracefully
- formulate our suggestions differently based on the confidence score
  - above 90% - prominent recommendation
  - 50 - 90%  - display with less emphasis
  - less than 50% - do not display

- find the **impact bottleneck**- the piece of your pipeline that could provide the **most value if you improve on it**

- If there are problems around the model, **replace the model with something simple and debug the whole pipeline**
  - Frequently, the issues will not be with the accuracy of your model. 
  - Frequently, your product is dead even if your model is successful.
- The goal of our plan should be to derisk our model. 
  - Evaluate worst-case performance. eg. suggesting whichever action the user previously took
  - If we did this, how often would our prediction be correct, and how annoying would our model be to the user if we were wrong? 
  - Assuming that our model was not much better than this baseline, would our product still be valuable?
  -** Oftentimes in summarization, for example, simply extracting the top keywords and categories covered by an article is enough to serve most users’ needs.**
-I encourage publicizing before you even start on a project. That helps you avoid working on something just because you thought it was cool and puts the impact of the results into context based on the effort
- > At LinkedIn, we had access to a very useful design element, a little window with a few rows of text and hyperlinks, that we could customize with our data. This made it eas‐ ier to launch experiments for projects such as job recommendations, as the design was already approved
- **It is always valuable to spend the manual effort to look at inputs and outputs of your model.** Scroll past a bunch of examples to see if anything looks weird.
  - A naive way to recommend groups - the most popular group containing their company’s name in the group title. After looking at a few examples, we found out **one of the popular groups for the company Oracle was “Oracle sucks!”** which would be a terrible group to recommend to Oracle employees.
- Looking at your data helps you think of good heuristics, models, and ways to reframe the product. 
  - If you rank examples in your dataset by frequency, you might even be able to quickly identify and label 80% of your use cases.
  - > At Jawbone, for example, people entered “phrases” to log the content of their meals. By the time we labeled the top 100 by hand, we had covered 80% of phrases and had strong ideas of what the main problems we would have to handle, such as varieties of text encoding and languages
- The last line of defense is to have a **diverse workforce** that looks at the results. This will allow you to catch instances where a model is exhibiting discriminative behavior, 
  - tagging your friends as a gorilla
  - is insensitive by surfacing painful past experiences with its smart “this time last year” retrospective


# Chapter 2- Create a Plan
- Covers the use of metrics to track ML and product progress and compare different ML implementations, identify methods to build a baseline and plan modeling iterations.

- > Many ML projects be doomed from the start due to a misalignment between product metrics and model metrics. 
- > More projects fail by producing good models that aren’t helpful for a product rather than due to modeling difficulties.

## Measuring success
- 3 Potential approaches
  1. Baseline 
       - designing heuristics based on domain knowledge
       - No ML at this stage
  2. Simple model 
        - classifying text as good or bad, and using the classifier to generate recommendations
  3. Complex model; 
        - training an end-to-end model that goes from bad text to good text

- **You Don’t Always Need ML**
  - Can often simply use a heuristic for their first version. 
  - After this, you may realize that you do not need ML at all.
  - **Building a heuristic is also often the fastest way to build a feature** 
  - Once its deployed, you’ll have a clearer view of your user’s needs

- Categories of performance that have a large impact on the usefulness of any ML product: 
  - Business metrics
  - Model metrics
  - Freshness
  - Speed
  ### Business metrics
  - starting with a clear product or feature goal. 
    - Then define a metricto judge its success
    - **should be separate from any model metrics** and only be a reflection of the product’s success.
    - Could be simple or complex Eg.
      - number of users a feature attracts 
      - click-through rate (CTR) of recommendations
- **Product metrics are the only ones that matter**
  - All other metrics should be used as tools to improve prod‐ uct metrics
  - Do not need to be unique
- Most projects tend to focus on improving one product metric, but their impact is often measured in terms of multiple metrics, including **guardrail metrics** 
  - metrics that shouldn’t decline below a given point.
  - increase CTR without decline in session length

### Model performance
- When a product is still being built and not deployed yet, it is not possible to measure usage metrics. 
- To still measure progress, use an offline/model metric.
- A good offline metric should be possible to evaluate without exposing a model to users, and be as correlated as possible with product metrics and goals
- Eg. Autocomplete
  - Business metric: CTR
  - Model metric: 
    - high accuracy in the next words prediction (hard)
    - tag prediction for user input (easier)
    - ![picture 1](images/918db1ee7a447cee86074bcd27cfcf5273cd3c6804c4d41d57b4bea457ab4450.png)  
- Application can also be updated 
  - Changing an interface so that a model’s results can be omitted if they are below a confidence threshold.
  - Presenting a few other predictions or heuristics in addition to a model’s top pred
    - Show 5 items instead of one
  - Communicating to users that a model is still in an experimental phase and giving them opportunities to provide feedback
    - Eg. Submit feedback on translations

- Use a suitable metric
  - Eg. Sketch to HTML
    - Cross entropy does not account for alignment
    - If one token is added in excess, all tokens appearing later will be shifted, leading to high loss
    - Output does not really matter on token order
    - BLEU scores are a better fit in this case
- > **If a product relies on a model being perfect to be useful, it is very likely to produce inaccurate or even dangerous results**
- >What is the worst accuracy a model can have and still be useful? If this accuracy requirement is hard to attain with current methods, could you redesign your product to make sure users are well served by it and not put at risk by prediction errors it could make?
- Case study
  - Should we use precision or recall?
    - High precision means that when we do make a recommendation, it will tend to be correct

### Freshness and distribution
- How often will you need to retrain models, and how much will it cost you each time we do so? 
- The right way to ask a question about mathematics will change much more slowly than the best phrasing of questions concerning music trends
- You need new data to refresh the models
- **You can collect data by letting users submit feedback with predictions**

### Speed
- Does user press a button or do we provide dynamic predictions as user updates inputs?
- On an individual datapoint, this difference are small, but they can quickly add up when needing to run inference on tens of thousands of examples at a time.
- If multiple network calls or database queries are involved, speed of inference becomes less of an issue

## Estimate Scope and Challenges
- In ML, success requires understanding the context of the task well, acquiring a good dataset, and building an appropriate model

### Leverage Domain Expertise
- The best way to devise heuristics is to see what experts are currently doing
- The second best way to devise heuristics is to look at your data

- **Learning from experts**
  - understand which assumptions we can reasonably make.
  - gather features to leverage, find pitfalls to avoid, and most importantly prevent us from reinventing the wheel

- **Examining the data**
  - In addition to EDA, it is crucial to individually label examples in the way you hope a model would.
    - Eg. phrase labelling instead of entity labelling

### Stand on the Shoulders of Giants
- Look for public implementations either with similar models or similar datasets, or both
- **Open data**
  - a similar dataset simply means a dataset with similar input and output types (**but not necessarily domains**).
  - ![picture 1](images/e74129dfb848bf1f50e276dc76f9e5b06d2f4fc0b40ead156c54fcf845da27af.png)  
  - Dataset sources
    - [Internet archive - The Dataset Collection](https://archive.org/details/datasets)
    - [r/datasets](https://www.reddit.com/r/datasets/)
    - [UCI Machine learning repository](https://archive.ics.uci.edu/ml/index.php)
    - [Google dataset search](https://datasetsearch.research.google.com/)
    - [Common crawl](https://commoncrawl.org/)
    - [Wikipedia - List of datasets for machine-learning research](https://en.wikipedia.org/wiki/List_of_datasets_for_machine-learning_research)

- **Open source code**
  - Before building your own pipeline from scratch, it's worthwhile to observe what others have done.
  - lets us see which challenges others have faced when doing similar modeling and surfaces potential issues with the given dataset
  - **Look for repos tackling both your product goal and code working with the dataset you have chosen**
  - First, try reproducing the results yourself
  - If none of the existing models performs well on an open dataset, we'll know that this project will require significant work
  - Steps
    - Find a repo and train it on the dataset it was trained on. See if you can reproduce performance
    - Train the above model on a dataset closer to your problem
    - Judge how well its doing with metrics and iterate

##  ML Editor Planning
### Initial planning
- > Build an initial model by using Stack Exchange questions and trying to predict a question’s upvotes score from its content. We will also use this opportunity to look through the dataset and label it, trying to find patterns
- model will attempt to classify text quality accurately, to then provide writing recommendation
- The engagement that a question receives depends on many more factors than just the quality of its formulation:
  - Context
  - Date
  - Community to which it was posted
  - Popularity of poster
- Our first model will ignore all metadata related to a post

## To Make Regular Progress: Start Simple
- extremely hard to predict how far a given dataset or model will get us
- Start simple and iterate

### Start with a Simple Pipeline
- helps understand what to tackle next
- Ideally, the cleaning and preprocessing steps should be the same for both training and inference pipelines

### Pipeline for the ML Editor
- Will write both training and inference pipelines
- Will write various analysis and exploration functions to help us diag‐ nose problems, such as:
  - A function that visualizes examples the model performs the best and worst on 
  - Functions to explore data 
  - A function to explore model results
- Acknowledge that models will not always work and to architect systems around this potential for mistakes.


# Part II - Build a Working Pipeline
# Chapter 3 - Build Your First End-to-End Pipeline
## The Simplest Scaffolding
- Start with the inference pipeline 
  - Avoid training pipeline: we can instead write some simple rules for now
  - allow us to quickly examine how users may interact with the output of a model
  - helps gather useful information to make training a model easier
  - critical to make us confront the problem and devise an initial set of hypotheses about how best to solve it
- Start with simple heuristics
  - devise it based on expert knowledge and data exploration 
  - use it to confirm initial assumptions and speed up iteration
- Create a CLI or API 
  - simplify it as much as possible, and have a minimal functional version.
```py
input_text = parse_arguments() 
processed = clean_input(input_text) 
tokenized_sentences = preprocess_input(processed) suggestions = get_suggestions(tokenized_sentences)
```
### Parse and clean data
- parse returns `args.text`
  - @niazangels: Book uses argparse, I'm gonna use `typer`
- clean could remove non-ASCII characters: 
  - `return str(text.encode().decode('ascii', errors='ignore'))`
### Tokenization
- > Mr. O’Neill thinks that the boys’ stories about Chile’s capital aren’t amusing
- @niazangels: Book uses `nltk`. I'm gonna use `spacy`

### Generating Features
- Some features we could use
  - frequency of a few common verbs and connectors
  - count adverb usage
  - determine the Flesch readability score
- Then return a report of these metrics to our users

## Test Your Workflow
### User Experience
- how satisfying is the product to use?
- is this the most useful way to present results to our users?

### Modeling Results
- If you set a ranking metric  to DCG@5, and notice that users only ever consider the first three results displayed, you should change our metric of success from DCG at 5 to 3.
- The goal of considering both user experience and model performance is to **make sure we are working on the most impactful aspect**

- **Finding the impact bottleneck**
  - identify which challenge to tackle next.
  - Most of the time, this will mean iterating on the way we present results to our users (**which could mean changing the way we train our models**) or improving model performance by identifying key failure points
  - On the product side
    - Document readability score vs. suggestions to improve
  - On the model side
    - Check for model biases
    - Build a new cleaning and augmentation pipeline to attempt to address this
    - dive deeper than an aggregate metric and look at the impact of your model on different slices of your data

## ML Editor Prototype Evaluation
- Test a simple question, a convoluted question, and a full paragraph.
- Case study
  - **Model**
    - Model predicts paragraph as easier to read than the convoluted sentence.
    - > attributes we are extracting from the text are not necessarily the most correlated with “good writing.” 

  - **User experience**
    - The information returned is both overwhelming and irrelevant
    - The goal of our product is to provide actionable recommendations to our users.
    - may want to boil down our recommendations to a single score, along with actionable recommendations to improve it.
      - say "use fewer adverbs"
      - provide sentence/word level correction
      - could present results by highlighting or parts of the input that needs correction
      - ![picture 2](images/62b68e6623f1e67e5d9d6ae91891845b2a951f724f3362f208dcb486bb1c0e7f.png)  
    - 
