### Stripe microservice

Use this microservice to easily integrate Stripe into your apps without having to use Stripe Checkout or Elements. No token needed, simply pass in a few parameters for each request and this service will take care of interacting with Stripe for you.

First, visit [Stripe](https://stripe.com/), sign up for an account and get API keys.

#### Quick start

Once equipped with keys, clone this repo:

`git clone https://github.com/seanrobenalt/stripe-microservice`

And then:

`cd stripe-microservice`

`bundle`

`figaro install` *<-- easy app config using ENV and YAML file*

Figaro generates an `application.yml` file where you will store your Stripe keys like so:

```
STRIPE_PUBLISHABLE_KEY: `pk_test00000000000`
STRIPE_SECRET_KEY: `pk_secret0000000000`
```

This repo comes with the [`stripe.rb`](./config/initializers/stripe.rb) initializer file so you're all set up.

#### Deploying to Heroku

If you don't have an account, visit [Heroku](https://www.heroku.com/) and sign up for one.

Install Heroku CLI with Homebrew:

`brew install heroku/brew/heroku`

Log in to your account via CLI:

`heroku login`

Create a Heroku app:

`heroku create`

Run this series of commands to ensure Heroku production environment gets set up and your API is ready:

`bundle`

`RAILS_ENV=production rake db:create db:migrate`

`git push heroku master`

`heroku restart`

`heroku run rake db:migrate`

Wait for your app to be deployed and take down the url that Heroku created for you where your app is hosted. You will need this url to POST to from your app.

#### Testing the service

To test on local server use curl with the rails server running in separate tab:

```
curl -v -H "Accept: application/json" -H "Origin: http://anywhere.com" -H "Content-Type: application/json" -X POST -d '{"charge_id": "ch_1BrYauDO9zv0VK3hsnE9oVyo", "amount": "18", "reason": "duplicate"}' http://localhost:3000/api/refunds
```

You can test all endpoints, just make sure to send the correct parameters.

#### Using the service

A few simple functions in your app will take care of interacting with your Stripe account.

First, set up a namespace to avoid this code colliding with other JavaScript in your app:

```javascript
var stripeService = {};
```

Next, set up a global function for sending the AJAX request:

```javascript
const ajaxify = function(endpoint, payload) {
  var request = new XMLHttpRequest();
  request.open("POST", endpoint, true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(payload));
}
```

Then define functions on the `stripeService` object that POST to different routes and send different objects depending on what you want to send to Stripe.

##### Creating a customer

```javascript
const customerEndpoint = 'https://your-heroku-path.herokuapp.com/api/customers';

stripeService.createStripeCustomer = function(data, customerEndpoint) {
  // description not required
  var customer = description: {customer: {
    description: data.description,
    email: data.email,
    exp_month: data.exp_month,
    exp_year: data.exp_year,
    cvc: data.cvc,
    number: data.card_number
  }};

  ajaxify(customerEndpoint, customer);

};
```

##### Making a payment

```javascript
const paymentEndpoint = 'https://your-heroku-path.herokuapp.com/api/payments';

stripeService.hitStripe = function(data, paymentEndpoint) {
  // cus_id, amount and currency are required, description is optional
  var payment = {payment: {
    cus_id: data.cus_id,
    amount: data.amount,
    currency: data.currency,
    description: data.description
  }};

  ajaxify(paymentEndpoint, payment);

};
```

##### Creating coupons

If you want to create coupons for customers along with their payments, do so by including a `coupon` value of `true` in your data. You must also send a  `duration` for the coupon and attach these params to your payments like so:

```javascript
const paymentEndpoint = 'https://your-heroku-path.herokuapp.com/api/payments';

stripeService.hitStripe = function(data, paymentEndpoint) {
  // coupon must be set to true in order for a coupon to be created
  // a coupon duration can be 'once', 'forever' or 'repeating'
  // coupon percent_off must be integer and coupon_id is string of your choice ie. '50OFF'
  var payment = {payment: {
    cus_id: data.cus_id,
    amount: data.amount,
    currency: data.currency,
    description: data.description,
    coupon: data.coupon,
    duration: data.duration,
    percent_off: data.percent_off,
    coupon_id: data.coupon_id
  }};

  ajaxify(paymentEndpoint, payment);

};
```

This method will create a coupon in Stripe with the provided params. It will also send out an email to the Stripe customer with the coupon code, percent off they get with the coupon and how many times they can use the coupon. This does require you to set up a [Mailgun](https://www.mailgun.com/) account, but this is extremely easy to do with the Heroku CLI:

`heroku addons:create mailgun`

`heroku addons:open mailgun`

This creates an account and opens up your dashboard. Click the `Domains` tab from your Mailgun dashboard. Copy your *Default SMTP Login* and *Default Password* to your `application.yml` file which was generated by figaro and then run:

`figaro heroku:set -e production`

Open up the [`mail.rb`](./config/initializers/mail.rb) included in this repo and change the domain to your deployed Heroku instance. You are all set to send out emails to your customers with Stripe generated coupons upon receiving their payments.

You can also create coupons separate from customer payments:

```javascript
const couponEndpoint = 'https://your-heroku-path.herokuapp.com/api/coupons';

stripeService.createCoupon = function(data, couponEndpoint) {
  // available params on coupon object
  var coupon = {coupon: {
    duration: data.duration,
    percent_off: data.percent_off,
    duration_in_months: data.duration_in_months,
    currency: data.currency,
    amount_off: data.amount_off,
    max_redemptions: data.max_redemptions,
    redeem_by: data.redeem_by
  }};

  ajaxify(couponEndpoint, coupon);

};
```

This creates a coupon for you to use as you wish. Stripe will generate a custom coupon code for your customers to use.

##### Creating plans

```javascript
const planEndpoint = 'https://your-heroku-path.herokuapp.com/api/plans';

stripeService.createPlan = function(data, planEndpoint) {
  // available params on plan object
  // all but statement_descriptor are required
  var plan = {plan: {
    currency: data.currency,
    interval: data.interval,
    name: data.name,
    amount: data.amount,
    interval_count: data.interval_count,
    statement_descriptor: data.statement_descriptor
  }};

  ajaxify(planEndpoint, plan);

};
```

##### Creating accounts

```javascript
const accountEndpoint = 'https://your-heroku-path.herokuapp.com/api/accounts';

stripeService.createAccount = function(data, accountEndpoint) {
  // type is required, email is required if type is 'standard'
  var account = {account: {
    country: data.country,
    email: data.email,
    type: data.account_type
  }};

  ajaxify(accountEndpoint, account);

};
```

##### Creating and verifying bank accounts

```javascript
const bankAccountEndpoint = 'https://your-heroku-path.herokuapp.com/api/bank_accounts';

stripeService.createAccount = function(data, bankAccountEndpoint) {
  // customer_id, account_number, routing_number, country and currency required
  var bank_account = {bank_account: {
    country: data.country,
    currency: data.currency,
    account_holder_name: data.account_holder_name,
    account_holder_type: data.account_holder_type,
    routing_number: data.routing_number,
    account_number: data.account_number,
    customer_id: data.cus_id
  }};

  ajaxify(bankAccountEndpoint, account);

};
```

This takes care of creating and verifying a bank account for an existing Stripe customer.

##### Creating subscriptions

```javascript
const subscriptionEndpoint = 'https://your-heroku-path.herokuapp.com/api/subscriptions';

stripeService.createAccount = function(data, subscriptionEndpoint) {
  // a customer_id and plan_id are required
  var subscription = {subscription: {
    cus_id: data.cus_id,
    plan_id: data.plan_id
  }};

  ajaxify(subscriptionEndpoint, subscription);

};
```

##### Making payouts

Make sure to go into the Settings tab underneath Balance on the left nav and check the box next to manual for manual payouts.

```javascript
const payoutEndpoint = 'https://your-heroku-path.herokuapp.com/api/payouts';

stripeService.createAccount = function(data, payoutEndpoint) {
  // amount and type of currency are required, default payout destination is your bank account
  var payout = {payout: {
    amount: data.amount,
    currency: data.currency,
    destination: data.destination,
    description: data.description
  }};

  ajaxify(payoutEndpoint, payout);

};
```

#### The helpers

When your app is deployed to Heroku and you've been making requests to it in production for quite some time, the methods in [`application_helper.rb`](./app/helpers/application_helper.rb) might come in handy.

From your terminal, you can get these stats with:

`heroku run bundle exec rails console`

And then:

`helper.get_your_balance` *<-- will return your balance object as JSON*

All the methods in that file are self explanatory.
