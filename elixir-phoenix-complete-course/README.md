# The Complete Elixir and Phoenix Bootcamp

- Author: Stephen Grider
- URL: https://www.udemy.com/course/the-complete-elixir-and-phoenix-bootcamp-and-tutorial

- ![picture 1](images/bf760a42aecd34c3e80dd584b9cd2f4983c97ad32cceecc56db6d9becea21e85.png)  
- Examples of Tasks:
  - generating docs for a project
  - running tests
- Elixir has implicit return (last value)
  ```elixir
    def hello do
      "hi there"
    end
  ```
- `iex -S mix` (?)
- Use `recompile` to reload the module in `iex` after modification
- Functional programming
  - fns always return object (return "Ace")- instead of mutating an obj (self.cards = cards)
  - ![picture 1](images/de935cadfa319d615f51c7f13c3ac60adf03e450bbd5d96df6e204ab7e74554b.png)
  - ![picture 2](images/bc9bd63836ef525c6f5c0ff7e7c72583e34528c343a9d1397daa491df5b1345f.png)  
    - No concept of instance variables
    - create_deck - Return array of strings
