# Money Tally <a name="readme-top"></a>

## Table of Contents

- [About Project](#about-project)
- [Built With](#built-with)
- [Tech Stack](#tech-stack)
- [Key Features](#key-features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
- [Usage](#usage)
- [Tests](#tests)
- [Author](#author)
- [Future Features](#future-features)
- [Contributing](#contributing)
- [Show your support](#support)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## **About Project** <a name="about-project"></a>

**Money Tally** is a straightforward Rails application designed to help you track and monitor your daily expenses. It offers an overview of your total monthly expenses, broken down by category, giving you a clear picture of your spending patterns.

## **Built With** <a name="built-with"></a>

- Ruby on Rails
- Postgres SQL

## **Tech Stack**  <a name="tech-stack"></a>

- Ruby
- Rails
- CSS3
- JavaScript

## **Key Features**  <a name="key-features"></a>

1. User Account Creation and Authentication
2. Category Creation for Expenses
3. Monthly Expense Overview
4. Editable User Profile

## **Getting Started**<a name="getting-started"></a>

To have the app on your local machine, please follow the instructions bellow.

### **Prerequisites**  <a name="prerequisites"></a>

Ensure you have **Ruby >= 3.2.2**, **Rails >= 7.1.2** and **postgres >= 15.3** installed on your machine. If not, follow the official installation guide for [Ruby](https://www.ruby-lang.org/en/documentation/installation/), [Rails](https://guides.rubyonrails.org/getting_started.html#installing-rails) and [PostgreSQL](https://www.postgresql.org/docs/).

### **Setup** <a name="setup"></a>

Clone the repository to your local machine:

  ```bash
  git clone https://github.com/lily4178993/money-tally.git
  ```

Navigate to the project folder:

  ```bash
  cd money-tally
  ```

You can use your own database and change the `config/database.yml`
  ```ruby
    default: &default
    adapter: postgresql
    encoding: unicode
    pool: 5
    username: [your_postgres_username]
    password: [your_postgres_password]
    host: localhost

  development:
    <<: *default
    database: [your_database_for_development]

  test:
    <<: *default
    database: [your_database_for_test]

  production:
    <<: *default
    database: [your_database_for_production]
  ```

### **Install**<a name="install"></a>

1. **Install Ruby Gems:**

    Install project dependencies using Bundler:
    ```bash
    bundle install
    ```

2. **Install Node.js Dependencies:**
  
    This project has additional dependencies specified in `package.json`, install them using npm:
    ```bash
    npm install
    ```

    Or if you prefer using Yarn:
    ```bash
    yarn install
    ```
    This step ensures that your development environment has all the required packages.

3. **Database Setup:**
  
    Set up the database by running the following commands:
    ```bash
    rails db:create
    rails db:migrate
    ```

## **Usage**<a name="usage"></a>

To start the Rails server, run:
  ```bash
  rails s
  ```
Visit `http://localhost:3000` in your browser to explore the **Money Tally** platform.

## **Tests** <a name="tests"></a>
The **Money Tally** application comes with a suite of tests to ensure the reliability and correctness of its functionality.

To run all the tests for the **Money Tally** application, follow these steps:
1. **Run Migrations in the Test Database:**

    Ensure the test database is up-to-date by migrating tables:
    ```bash
    rails db:migrate RAILS_ENV=test
    ```
2. **Execute Tests:**

    Run all tests using the following command:
    ```bash
    rspec --format documentation
    ```

## **Author** <a name="author"></a>

**Money Tally** is developed and maintained by Nelly Telli. If you have any questions, suggestions, or feedback, feel free to reach out:

- GitHub: [@lily4178993](https://github.com/lily4178993)
- LinkedIn: [Nelly T.](https://www.linkedin.com/in/nellytelli/)

## **Future Features** <a name="future-features"></a>

**Money Tally** is constantly evolving, and we have some exciting features lined up to enhance your experience:

1. **Theme Customization**: We understand that personalization is key. In the future, you'll be able to customize the appearance of the app with various themes to suit your style.

2. **Multilingual Support**: To make **Money Tally** accessible to a wider audience, we are working on adding support for multiple languages. This will allow users to interact with the app in their preferred language.

3. **Expanded Profile Options**: We aim to give you more control over your profile. Soon, you'll have more options to edit and personalize your profile information, tailoring it to your needs.

4. **Enhanced User Interface**: We're committed to improving your experience. Expect a more intuitive and user-friendly interface, making your expense tracking smoother and more enjoyable.

Stay tuned for these updates as we strive to make **Money Tally** your go-to app for managing daily expenses!

---

## **Contributing** <a name="contributing"></a>

Contributions are welcome! Feel free to [open an issue](https://github.com/lily4178993/money-tally/issues) or submit a pull request.

## **Show your support** <a name="support"></a>

If you find **Money Tally** helpful, please consider starring the repository.

## **Acknowledgments** <a name="acknowledgements"></a>

Special thanks to Microverse for making this project possible.
Original design idea by [Gregoire Vella on Behance](https://www.behance.net/gregoirevella)

## **License** <a name="license"></a>

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
