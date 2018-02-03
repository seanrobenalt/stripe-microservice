### Stripe microservice

Use this microservice to easily integrate Stripe in your apps to make payments without having to use Stripe Checkout or Elements. No token needed, simply pass a Stripe customer id and a few other params and this microservice takes care of charging the customer's credit card through Stripe.

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
