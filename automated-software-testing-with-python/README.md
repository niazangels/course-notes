# Automated Software Testing with Python
- _Course link:_ https://www.udemy.com/course/automated-software-testing-with-python/
- _Instructor: Jose Salvatierra_

## Resources
- https://realpython.com/python-mock-library/


## How to start writing tests
- Start withe simplest possible tests
- Then develop the simplest possible code to make the test pass. Eg hard code return values
- Run tests make sure that it passes
- Continue writing tests that will fail with the simplest code developed above
- Continue writing code that generalizes

## General Advice
- Put `_test.py` at the very end, if you can, instead of the `test_*.py`. This makes the file names more readable.
- Always test models first before testing apis
- Write init tests for all models even if you think they're trivial because they ensure that your api does not change and your class can  create objects.
- When writing creation tests, ensure that the item does not exist in the db before you create the item. So you should have two assertions - one before creation and one after creation
- Eg. 
```python
    assert x.get(expected) is None
    x.create(y)
    assert x.get(y) == expected

```


## Unit, Integration & System tests
- Ensure that unit tests cover only a single unit. Eg. `Blog` should not depend on `Post` class. If it does, move it to an integration test.
- A system test is a test that is going to test your entire system.
- System tests take much longer than unit and integration tests. 
- Aim for more unit tests than integration tests, more integration tests than system tests.


## Mocking and Patching
- Patching will help intercept functions and test out how they were called.
- `print` cannot be tested directly. However if we intercept `print`, we can check to see if it was called with the correct arguments.
- There is probably a test inside python core tests whether `print` works correctly given the right arguments, so you don't have to test this
- You can patch multiple functions. For example when testing `app.show_menu()` you may need to patch `builtins.input()` as well as `print`.
- Without patching the test will wait indefinitely at that point for user input which never arrived. 
- You can also specify return value for the patched function so the flow continues.
- If you have two successive input() then use side effect to specify what each return value is.

## setUp and tearDown
- `TestCase.setUp()` runs once before each function to be tested
- `setUpClass` and `tearDownClass` runs once for a class, as opposed to every test function in case of `setUp()` and `tearDown()`
- In Flask, `app.testing = True` will ensure that flask handles errors slightly differently than when deployed
- For non unit tests create a blank database each time to ensure there is no stale data. This is done with setup and teardown. Depending on the framework, you have to initialize the db at a blank location (eg. `sqlite:////`, possibly with the app context) and remove all data and tables when tearing down
- For best results ensure that the database you use is the one you use in production. 
- Eg. Don't use `sqlite` for testing if you're using `mysql` in production. 
- **Sqlite does not check foreign key constrains when creating so you can have a row which points to a non existent row in another table.** Thus tests that may pass with sqlite may fail outright with an integrity error in mysql /postgresql, especially with CRUD operations. In such a case, create the dependency in your test manually by instantiation and but by rest api calls. [Videos - 85,86]
- You can do the entire crud in one single test- have assertions throughout the process and ensure the old item does not exist any more

```python
    #TODO write sample code
    
```


- **Q: when we do "`from x import y`"** what all gets imported? Everything from x? Only dependencies of y in x? Only x? Can you check globals and locals to find out? Specifically, When writing 86, how does store model get imported when importing app?

- Tests that use models which have relationships with other models will require both models to be imported and initialized. This might lead to unused imports on the tests file which is not recommended. The other opinion is to have the base test class which does the setup and teardown but this will take 10x longer to run because of the overhead. The suggested way to solve this is to have a dummy unitbasetest class that does nothing. However this class is in a separate file that is imported into every unit test. Let this file also have an unused "from app import app". This will pull in all the dependencies directly.

- What parts of a model object are unit testable? If the model depends on a database retrieval or on another object, it stops being unit testable. So in a few cases, only `__init__` will be unit testable.

- Certain methods like db.Model.relationships could either be lazily loaded or be loaded on object creation 87

- **Q: how can we make testing as painless as possible with vs code?**

- **Q: how can we make adding docstrings as painless as possible?**

- **Q: what does `werkzeug.security.safe_str_cmp`  do?**

- If you're sending data with `data` attribute in `requests.get()`, you'll need to do `json.loads(r.data)` to get back the data. Requests package actually sends this as form data, so it converts the value of the data attribute to a string format internally.

- If you need authentication for certain system tests, do a `setUpClass` that performs the login and saves it as `self.access_token`. Add this to the header of all subsequent API calls that need to be tested. If you need this for a class that inherits from base class, make sure you call init of the super class.

- Q: Why use PROPAGATE_EXCEPTIONS in Flask?
- Flask raises a 500 internal server error by default when it encounters any errors. This is done so that any unhandled errors are caught and not much information is given to the end user. Propagate exception overrules this and bubbles up the exact error.  

## Postman
- Postman tests should be very scarce as they are system tests. Simulates app in production
- Once you have multiple endpoint tests configured, you can run through them all.
- [Settings button] (top left) has a "Manage environments" option that lets you configure variables: eg. {{url}} = 'https://dev.company". Make sure you DON'T include the slash at the end
- Save each endpoint as you're developing it. That way you have a really nice log of whatever you need
- Under "Tests" section, you can assign variables and check truthiness
- eg. `tests['response time less than 200ms'] = responseTime<200`
- Tests will automatically fail if the response code does is not a `2xx`
- You can check for response values with `jsonData.message`, `postman.getResponseHeader("Content-Type")`

- `postman.setEnvironmentVariable` will add a var to the env so other requests can make use of this var. Clear it using `postman.clearEnvironmentVariable`.
- Use this for example in case of authentication. 
- The [eye](#) icon will show all env vars
- **newman** is a node package that will run postman tests. to install newman ensure you have npm. To keep a variety of node versions use nvm.
