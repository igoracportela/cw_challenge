# Project Title

Challenge

## Description

[read here](https://gist.github.com/cloudwalk-tests/76993838e65d7e0f988f40f1b1909c97)

## Getting Started

### Dependencies

* PostgreSQL
* ruby 3.2.2
* rails 7.1.1

## Answers:

### 3.1.1

A simple diagram
``` 
  ┌──────────────────┐
  │     Merchant     │
  └──────┬───────────┘
       A │   ▲
         ▼   │ E
  ┌──────────┴───────┐
  │  Payment Gateway │
  └──────┬───────────┘
       B │   ▲
         ▼   │ E
  ┌──────────┴───────┐
  │     Acquirer     │
  └──────┬───────────┘
       C │   ▲
         ▼   │ E
  ┌──────────┴───────┐
  │    Card Brand    │
  └──────┬───┬───────┘
       D │   │
         ▼   │ E
  ┌──────────┴───────┐
  │   Issuing Bank   │
  └──────────────────┘
```

A. The customer makes the decision to pay for the products or services and selects a payment method. They provide all the necessary information and confirm the purchase.

B. The store interacts solely with the payment gateway, which conceals the underlying steps required for completing a payment.

C. The Acquirer receives the payment information from the gateway and processes it to fulfill the payment. Subsequently, the request is forwarded to the Card Brand, which establishes various business rules concerning installment plans, card usage restrictions, and more.

D. Ultimately, the payment is transmitted to the Issuing Bank, which verifies the availability of funds or credit limit, performs a credit analysis, and either approves or denies the payment.

E. The payment outcome is then relayed back to the customer, informing them whether the purchase was approved or denied.

### 3.1.2

An Acquirer is a specialized company that handles payment processing on behalf of merchants, enabling them to offer various payment methods to customers. The Acquirer receives payment information, processes it, and forwards the request to the Card Issuer or Issuing Bank. To receive payment information, the Acquirer must be connected to the merchant's payment gateway. Examples of Acquirers include Stone and Cielo.

A Sub-Acquirer is also a payment processing company, but it performs only a subset of the functionalities provided by an Acquirer. By offering limited services, Sub-Acquirers reduce implementation costs, making them a cost-effective option for small businesses. However, these players often charge higher rates to generate profits, so merchants must consider this trade-off. Examples of Sub-Acquirers include PagSeguro and Paypal.

The Gateway serves as an intermediary system between the merchant and the rest of the payment system. It simplifies the integration process for merchants by abstracting the complexities of the payment system.

A Chargeback occurs when a customer requests a refund for a completed payment. It usually involves a dispute between the merchant and the customer, and the reasons for chargebacks can include:

Product not matching the description, such as a product that was falsely advertised and misled the customer.
Non-delivery of the product to the customer.
Payment amount differing from the agreed price.
Unauthorized payment made without the customer's consent.
While some chargeback requests are legitimate and justified, there are instances where customers may have malicious intent, such as falsely claiming that a product was never delivered or misrepresenting the product itself.

In addition to dealing with dishonest customers, chargebacks also serve as a means to protect customers from fraud. Fraudulent transactions can occur when someone steals credit card information and makes unauthorized purchases using the victim's funds. To prevent such incidents, payment systems must implement anti-fraud mechanisms to identify and reject suspicious transactions.

On the other hand, a cancellation occurs before funds are transferred between the merchant and the issuing bank. It is an agreed-upon action between the merchant and the customer and is generally less complex than filing for a chargeback.

### 3.1.3

Upon analyzing the CSV data, it becomes evident that there is a significant increase in fraud incidents between 19:00 and 04:00. Furthermore, the average value of fraudulent transactions consistently exceeds $1000 during this time period, which could serve as a threshold for identifying suspicious activities.

Unusually large purchases are infrequent after midnight, but they are relatively more common between 19:00 and 22:00. To accommodate legitimate transactions within this timeframe, we can set a less strict limit based on the average fraud value for this interval, allowing more genuine purchases to be approved while still imposing a cap on high-value transactions (set at $1366.69). From 22:00 to 03:00, however, we should adopt a more restrictive approach by using the average legitimate transaction value as the maximum limit for this period, aiming to maintain the opportunity for legitimate purchases (set at $570.43).

It is worth noting that certain merchants have a significantly higher occurrence of fraud compared to others. Although our dataset comprises only 3.2k records, we observe that approximately 30% of all fraudulent activities are concentrated among just 12 merchants, which represents less than 1% of the total (1756). This highlights the importance of closely monitoring suspicious merchants with a history of fraud and implementing stricter approval measures for their transactions, while being more lenient towards newer merchants without a significant track record.

However, it is challenging to draw definitive conclusions since it is possible that the fraud incidents are primarily targeting large merchants like Amazon.

In addition to the information available in the spreadsheet, it would be beneficial to examine other data sources in order to identify patterns that could indicate potential fraud. If feasible, cross-referencing user information with previous purchase records would be valuable. For instance, if a particular individual's most recent purchase was made within a specific region, it is highly unlikely that they would suddenly make a purchase to be delivered overseas (although the possibility of it being a gift or an exceptional circumstance cannot be entirely ruled out). By analyzing the purchase history of individuals, we can proactively identify transactions that deviate significantly from their typical behavior and potentially block suspicious purchases.

