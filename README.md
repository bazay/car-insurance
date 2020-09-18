# Car insurance

Note that it is **not** a requirement that you complete the exercise in the time that you have. The process of coming up with the solution is more important than the complete solution itself.

Treat this exercise as you would a real-life business problem. You can ask for clarification of any domain name or rule. If the business requirement is not clear, assume you have access to a business owner to answer your questions.

## Problem domain

A car insurance aggregator wants to build a system that returns insurance quotes based on customer requests.

A customer can request a level of cover for various parts of a car, e.g. they may want £10 cover for their tires and £50 cover for their windows. In simplified insurance terms, this is how much they will get from the insurer when their tires or windows break.

Based on the customer request, quotes are provided by a panel of insurers. Each quote can have a different price, e.g. `insurer_a` may give a quote of £10 for the request above, while `insurer_b` may give a quote of £15. The rules for coming up with the price are specified in detail below.

## What to build

Build an application that produces insurer quotes based on customer requests.

This is an example of a **customer request** in a JSON format:

```json
{
  "covers": {
    "tires": 10,
    "windows": 50,
    "engine": 20,
    "contents": 30,
    "doors": 15
  }
}
```

The JSON request specifies which value the customer is requesting for 5 possible covers.

The application uses a static configuration file (also JSON) which contains the list of the covers each insurer is providing.

This is an example of the **insurer configuration** JSON file:

```json
{
  "insurer_rates": {
    "insurer_a": "windows+contents",
    "insurer_b": "tires+contents",
    "insurer_c": "doors+engine"
  }
}
```

The application should, for each request, calculate quotes for the 3 insurers. The **business requirement** for the pricing model is simply stated as follows:

If 2 covers are matched, the quote is 10% of the sum of the requested cover limits for each of those covers. If only 1 cover is matched, the quote is 20% of the requested cover limit if it is the highest cover requested, 25% if it is the second highest, or 30% if it is the third.

Only the biggest incoming 3 values from the customer request are taken into account for the calculation, discarding the other 2.

The system should not return a quote if the value is zero (0).

You can assume the interviewer is the business owner and ask any clarification on the above.

## Example

Assume the following customer request:

```json
{
  "covers": {
    "tires": 10,
    "windows": 50,
    "engine": 20,
    "contents": 30,
    "doors": 15
  }
}
```

The application will select the 3 biggest covers requested and ignore the rest:

* `windows`: 50
* `contents`: 30
* `engine`: 20

The application will then calculate the following quotes:

* `insurer_a`: `8`     (10% of 80 (two matches on *windows* and *contents*))
* `insurer_b`: `7.5`   (25% of 30 (one match on *contents*, the 2nd biggest cover))
* `insurer_c`: `6`     (30% of 20 (one match on *engine*, the 3rd biggest cover)
