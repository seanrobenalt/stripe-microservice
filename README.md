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

This repo comes with the `stripe.rb` initializer file so you're all set up

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

Wait for your app to be deployed and take down the url that Heroku created for you where your app is hosted. You will need this url to POST to from your app.

#### Using the service

One simple function in your app will take care of creating a payment to your Stripe account.

First, set up a namespace to avoid this code colliding with other JavaScript in your app:

```javascript
var payments = {};
```

Then define a function as a property on that object that will POST to this microservice which exists at your deployed Heroku instance:

```javascript
payments.hitStripe = function(data) {
  // cus_id, amount and currency are required, description is optional
  var payment = {payment: {
    cus_id: data.cus_id,
    amount: data.amount,
    currency: data.currency,
    description: data.description
  }};

  // perform the async AJAX request
  var request = new XMLHttpRequest();
  request.open("POST", "https://your-heroku-path-02918.herokuapp.com", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(payment));
};
```

Now you can call `payments.hitStripe(data)` on your payment forms where your customer is already an existing Stripe customer and if you pass in the `customer_id` of that Stripe customer along with `amount` and `currency`, this service will charge the customer's credit card for you.
