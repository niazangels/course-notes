# Fastai
- Author: Jeremy Howard, Rachel
- URL: https://course.fast.ai/
- Book: https://github.com/fastai/fastbook

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

## Lecture notes
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


## Notes - Chapter 2

### References
- [Designing great data products](https://www.oreilly.com/radar/drivetrain-approach-data-products/)
- [RAPIDS](https://rapids.ai/)
- [Actionable Auditing - Investigating the Impact of Publicly Naming Biased Performance Results of Commercial AI Products](https://sci-hub.do/https://doi.org/10.1145/3306618.3314244)
- [To Predict and serve?](https://rss.onlinelibrary.wiley.com/doi/full/10.1111/j.1740-9713.2016.00960.x)
### Starting your project
-  When selecting a project, the most important consideration is data availability. 
-  Many researchers, and industry practitioners waste time attempting to find their perfect dataset. **The goal is not to find the "perfect" dataset or project, but just to get started and iterate from there.**
-  We also suggest that you iterate from end to end in your project; that is, don't spend months fine-tuning your model, or polishing the perfect GUI, or labelling the perfect dataset… Instead, **complete every step as well as you can in a reasonable amount of time, all the way to the end.**
-  By completing the project end to end, you will see where the trickiest bits are, and which bits make the biggest difference to the final result.

- In an organizational context show your idea can really work by **showing them a real working prototype**. This is the secret to getting **good organizational buy-in** for a project.
- Even if you can't find the exact data you need for the precise project you have in mind, you might be able to find something from a similar domain, or measured in a different way, tackling a slightly different problem.
- Working on these kinds of **similar projects** will still give you a **good understanding of the overall process, and may help you identify other shortcuts, data sources**, and so forth.

### State of the art
#### Vision
- Deep learning algorithms are generally not good at recognizing images that are significantly different in structure or style to those used to train the model.
  - Color vs B/W
  - Photo vs Drawing
  - **These are called "out-of-domain" data**
- Although your problem might not look like a computer vision problem, it might be possible with a little imagination to turn it into one.

#### NLP
- Deep learning is also very good at generating context-appropriate text, such as replies to social media posts, and imitating a particular author's style. 
- We **don't currently have a reliable way to combine a knowledge base of medical information with a deep learning model** for generating medically correct natural language responses.
- **Translation or summary could well include completely incorrect information**!

#### Combining text and images
- We generally recommend that deep learning be used not as an entirely automated process, but as part of a process in which the model and a human user interact closely. 
  - an automatic system can be used to identify potential stroke victims directly from CT scans, and send a high-priority alert to have those scans looked at quickly. 
  - automatically measure items seen on the scans, and insert those measurements into reports, warning the radiologists about findings that they may have missed, and telling them about other cases that might be relevant.
  
#### Tabular data
- If you already have a system that is using random forests or gradient boosting machines then switching to or adding deep learning may not result in any dramatic improvement.
- Deep learning does greatly increase the variety of columns that you can include
  - columns containing natural language (book titles, reviews, etc.)
  -  high-cardinality categorical columns (zip code or product ID)
-  deep learning models generally take longer to train than random forests or gradient boosting machines

#### Recommendation systems
- Recommendation systems are really just a special type of tabular data.
  - high-cardinality categorical variable representing users, and another one representing products (or something similar)
- DL helps combining these variables with other kinds of data, such as natural language or images, and additional metadata represented as tables, such as user information, previous transactions etc.
- However, nearly all machine learning approaches have the **downside that they only tell you what products a particular user might like, rather than what recommendations would be helpful** for a user

### Drivetrain approach
- We use data not just to generate more data but to produce **actionable outcomes**. That is the goal of the Drivetrain Approach. 
1.  Start by defining a clear objective.
      - Eg. Google: "What is the user’s main objective in typing in a search query?"
      - Answer: "show the most relevant search result."
2.  The next step is to consider what levers you can pull (i.e., what actions you can take) to better achieve that objective.
      - In Google's case, that was the ranking of the search results.
3. The third step was to consider what new data they would need to produce such a ranking;
     - implicit information regarding which pages linked to which other pages could be used for this purpose.
4. **Only after these first three steps do we begin thinking about building the predictive models**. 
- Our objective and available levers, what data we already have and what additional data we will need to collect, determine the models we can build.
- Another example: You could build two models for purchase probabilities, conditional on seeing or not seeing a recommendation.
  -  The difference between these two probabilities is a utility function for a given recommendation to a customer.
  -  It will be low in cases where the algorithm recommends a familiar book that the customer has already rejected (both components are small) or a book that they would have bought even without the recommendation (both components are large and cancel each other out).

### Gathering data

- To turn our downloaded data into a DataLoaders object we need to tell fastai at least four things:
  1. What kinds of data we are working with
     ```py 
     blocks=(ImageBlock, CategoryBlock)
     ```
     - independent variables are images, dependent variables are the categories
  2. How to get the list of items
     ```py
     get_items=get_image_files
     ```
  4. How to label these items
     ```py
     get_y=parent_label
     ```
  5. How to create the validation set
      ```py
      splitter=RandomSplitter(valid_pct=0.2, seed=42)
      ```
- Our images are all different sizes, and this is a problem for deep learning: we don't feed the model one image at a time but several of them (what we call a mini-batch). 
- To group them in a big array (usually called a tensor) that is going to go through our model, they all need to be of the same size. 
- So, we need to add a transform which will resize these images to the same size. 
- `Item transforms` are pieces of code that run on each individual item

```py
bears = DataBlock(
    blocks=(ImageBlock, CategoryBlock), 
    get_items=get_image_files, 
    splitter=RandomSplitter(valid_pct=0.2, seed=42),
    get_y=parent_label,
    item_tfms=Resize(128))
```

- This command has given us a DataBlock object. **This is like a template for creating a `DataLoaders`.** We still need to tell fastai the actual source of our data—in this case, the path where the images can be found.

- `DataLoader` is a class that provides batches of a few items at a time to the GPU. 
- `DataLoaders` includes validation and training `DataLoader`s. 
- When you loop through a `DataLoader` fastai will give you 64 (by default) items at a time, all stacked up into a single tensor.

- Image augmentation
  - If we squish or stretch the images they end up as unrealistic shapes, model learns that things look different to how they actually are, resulting in lower accuracy. 
  - If we crop the images, we remove some of the features that allow us to perform recognition. eg. a key part of the body or the face necessary to distinguish between similar breeds. 
  - If we pad the images then we empty space, which is just wasted computation for our model, results in a lower effective resolution for the part of the image we actually use.
  - Instead, on each epoch randomly crop a different part of each image. Now  our **model can learn to focus** on, and recognize, different features in our images. 
  - The intuitive approach to doing data cleaning is to do it before you train a model. But **a model can actually help you find data issues more quickly and easily**. So, we normally prefer to train a quick and simple model first, and then use it to help us with data cleaning.
  - Photos that people are most likely to upload to the internet are the kinds of photos that do a good job of clearly and artistically displaying their subject matter—which isn't the kind of input this system is going to be getting.
- **Domain shift**: the type of data that our model sees changes over time. For instance, an insurance company's pricing and risk algorithm- over time the types of customers that the company attracts, and the types of risks they represent, may change so much that the original training data is no longer relevant.
- Rollout process
  - ![picture 1](images/6bd1dc571954e0eed5c5733e4dba7dcd1339c24eb2d9e61966d95dc65e209c78.png)  
  - First step: Manual process 
    - use an entirely manual process, with your deep learning model approach running in parallel but **not being used directly to drive any actions**
    - The humans involved in the manual process should look at the deep learning outputs and check whether they make sense
  - Second step: limit the scope of the model, and have it carefully supervised by people. 
    - Do a small geographically and time-constrained trial of the model-driven approach. 
    - pick a single observation post, for a one-week period, and have a someone check each alert before it goes out.
  - Thrid step: Gradually increase the scope of your rollout. 
    - Ensure to have good reporting systems in place, to make sure that you are aware of any significant changes to the actions being taken compared to your manual process. 
    - If the number of bear alerts doubles or halves after rollout of the new system in some location, we should be very concerned. 
    - Try to think about all the ways in which your system could go wrong, and then **think about what measure or report or picture could reflect that problem, and ensure that your regular reporting includes that information.**


### Unforeseen Consequences and Feedback Loops¶
- A helpful exercise prior to rolling out a significant machine learning system is to consider this question: **"What would happen if it went really, really well?"** In other words, what if the predictive power was extremely high, and its ability to influence behavior was extremely significant? In that case, who would be most impacted? **What would the most extreme results potentially look like?** How would you know what was really going on?
- **Of course, human oversight isn't useful if it isn't listened to, so make sure that there are reliable and resilient communication channels so that the right people will be aware of issues, and will have the power to fix them.**
- You risk not having a feedback loop any time your model is potentially driving the next round of data
- The people involved in the model oversight need to be involved in product and engineering, not siloed into a "Trust and Safety" team
- > You are best positioned to **help people one step behind you**. The material is still fresh in your mind. Many experts have forgotten what it was like to be a beginner (or an intermediate) and have **forgotten why the topic is hard to understand when you first hear it**. The context of your particular background, your particular style, and your knowledge level will give a different twist to what you’re writing about.

- You almost certainly do not need a GPU to serve your model in production. There are a few reasons for this:

    - GPUs are only useful when they do lots of identical work in parallel.
    - An alternative could be to wait for a few users to submit their images, and then batch them up and process them all at once on a GPU. Users then have to wait, rather than getting answers straight away! And you **need a high-volume site for this to be workable**. If you do need this functionality, you can use a tool such as **Microsoft's ONNX Runtime, or AWS Sagemaker**
    - The complexities of dealing with GPU inference are significant. In particular, the GPU's memory will need careful manual management, and you'll need a careful queueing system to ensure you only process one batch at a time.
    - There's a lot more market competition in CPU than GPU servers, as a result of which there are much cheaper options available for CPU servers.


# Lesson 3
- `RandomResizedCrop` 
  - crops randomly on training set
  - crops center on validation set
- Other batch transforms only does augmentation on training set. Leaves val set untouched.
- Why are images cropped to squares?
  - Only because there are variations in image sizes in dataset
  - If its one size, then its okay to not have squares
  - Else you can choose images in each mini batches according to their sizes and decide what the best image size for each minibatch is
- `learner_inf.predict` will give you confidences in the order of `learner.dls.vocab`. 
  - `learner_inf = load_learner(...)`  will auto load the dls too within learner
- Create a model that will work on a smaller subset of your data before working on the whole dataset
  - This means fewer classes and fewer data points
- Set 'Path.BASE_PATH` so that you don't have to see all the trailing slashes
- Start with a stupid simple model
  - Always predict the mean- see what accuracy you get

- Pytorch
  - `tns.type()` (tensor.LongTensor) is different from `type(tns)` (torch.Tensor)