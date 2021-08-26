## Wave Software Development Challenge - Payroll API

This is API only Ruby on Rails based application solution to Wave's [se-challenge-payroll](https://github.com/wvchallenges/se-challenge-payroll) challenge. 
This is a MVP product with minimum functionalities.

### Live Demo
Live demo can be found at https://sa-payroll.herokuapp.com

### Tech Stack
* Ruby (3.0.2)
* Rails (6.1.4)
* PostgreSQL (13.3.1)

### Running Locally
Make sure above requirements are fulfilled before running this application.
Navigate to project directory and follow following commands

`bundle install` will install all the required gems.

`rails db:setup` command will install all the required gems.

`rails server` Rails Server will start and you can visit `localhost:3000` in your web browser.

### Running Tests
Run `rails spec` command from project folder.

### Assumptions
* Upload CSV file will be in correct format and there is no validation on csv rows.
* If csv contains zero records, I am still saving reference of the file in the system, so another csv with same report id can't be uploaded.

### Features
1. Upload a CSV file containing data on the number of hours worked per day per employee
2. Retrieve a report detailing how much each employee should be paid in each _pay period_
3. API Docs using Swagger
4. Validations for file format

### API End Points
**POST /api/file_imports**

Replace HOST & PATH_TO_CSV in below curl requests.

File name should be of the format `time-report-x.csv`,
where `x` is the ID of the time report represented as an integer. 
For example, `time-report-42.csv` would represent a report with an ID of `42`.

```
curl -X POST "https://{HOST}/api/file_imports" -H  "Content-Type: multipart/form-data" -F "file_report[file]=@{PATH_TO_CSV};type=text/csv"
```

**GET /api/payroll_reports**

```
curl -X GET "http://{HOST}/api/payroll_reports"
```

### Design
* This application is using Ruby on Rails only. It’s not a single page application and I am using rails views to render response. The application is simple and easy to use.
* For persistence, **Postgres** is being used. We have structured data and later on, we may want to perform complex queries to generate timesheet and reports. So I choose SQL based database.
* There is no authentication as of now. For an MVP, I wanted to build a working application with important functionalities.
* The application is hosted on Heroku free instance and we can use some `elastic server` in case our app becomes popular and attract thousands or millions of users. Also generally we can predict peak hours as general check-in and checkout time would be at start and end of the day.

## Database Schema
Table Names: `file_imports` `time_logs`

| **file_imports** |           |
|------------------|-----------|
| report_id        | int(PK)   |
| `has_many`       |`time_logs`|


| **time_logs**   |             |
|-----------------|-------------|
| employee_id     | int         |
| date            | date        |
| hours_worked    | decimal     |
| job_group       | string      |
| report_id       | int (FK)    |
| wage_cents      | int         |
| wage_currency   | string      |
| `belongs_to`    |`file_import`|

## Other Alternatives I considered
* Having separate model for employee, payment groups


#### How did you test that your implementation was correct?
I have written Test Cases using rspec and swagger.

#### If this application was destined for a production environment, what would you add or change?
* **API Authentication** - Only authenticated requests can access the system
* Having separate models for employee, payment groups. For this we should have employees, groups already created in the system.
* Background processing of CSV and maintain status of the job and errors if any.
* Validation on CSV data.
* Export report data in formats like CSV or XLS

#### What compromises did you have to make as a result of the time constraints of this challenge?
    
## Evaluation

Evaluation of your submission will be based on the following criteria.

1. Did you follow the instructions for submission?
1. Did you complete the steps outlined in the _Documentation_ section?
1. Were models/entities and other components easily identifiable to the
   reviewer?
1. What design decisions did you make when designing your models/entities? Are
   they explained?
1. Did you separate any concerns in your application? Why or why not?
1. Does your solution use appropriate data types for the problem as described?
