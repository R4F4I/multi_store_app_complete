# multi_store_app

 flutter app project w/ udemy

## Section Summaries

### 02 - layout [ V 1.0 ]

<details>
<summary>creating an empty layout of the app</summary>
 creating an empty layout of the app

|![image](readme-material\section-2_img-1.png)|![image](readme-material\section-2_img-2.png)|![image](readme-material\section-2_img-3.png)|
|--|--|--|
</details>

### 03 - Firebase Authentication [ Level 1 ]

<details>
<summary>add functionality to the signUp buttons</summary>
 we will add functionality for the sign up buttons

![image](readme-material\section-3_img-1.png)

#### ⇒ it will consist of a sign Up page

| ![image](readme-material\section-3_img-2.png) | ![image](readme-material\section-3_img-3.png) | ![image](readme-material\section-3_img-4.png) | ![image](readme-material\section-3_img-5.png) | ![image](readme-material\section-3_img-6.png) |
|--|--|--|--|--|

- the sign up page will take the inputs of the given fields including the image
- it will also have the functionality to hide a password
- it will return any errors using the bottom yellow popup bar

#### It will also support a firebase connection

| ![image](readme-material\section-3_img-7.png)|![image](readme-material\section-3_img-8.png)| ![image](readme-material\section-3_img-9.png)|
|--|--|--|

- this is due to the project containing a large amount of data,
- firebase will:
  - authenticate customers, &
  - store their data in a database, including their images

#### ⇒ we will also hold the ability to login into an existing account and switch b/w the login & signup pages

| ![image](readme-material\section-3_img-10.png)|![image](readme-material\section-3_img-11.png)| ![image](readme-material\section-3_img-12.png)|![image](readme-material\section-3_img-13.png)|
|--|--|--|--|

#### ⇒ Same for suppliers

| supplier sign up ![image](readme-material\section-3_img-14.png)| Store data for supplier![image](readme-material\section-3_img-15.png)|supplier login ![image](readme-material\section-3_img-16.png)|
|--|--|--|

#### ⇒ now within the login

| ![image](readme-material\section-3_img-17.png)|![image](readme-material\section-3_img-18.png)|![image](readme-material\section-3_img-19.png)|![image](readme-material\section-3_img-20.png)|
|--|--|--|--|

#### ⇒ Now finally for guest

| ![image](readme-material\section-3_img-21.png)| ![image](readme-material\section-3_img-22.png)|
|--|--|
</details>

### 04 - Upload Product [ Cloud Firestore ]

<details>
<summary>now to work on the supplier side of the project like: uploading products to the app</summary>

we will now work in the supplier side of the project,
like uploading products to the app

| ![image](readme-material\section-4_img-1.png)|![image](readme-material\section-4_img-2.png)| ![image](readme-material\section-4_img-3.png)|
|--|--|--|
|![image](readme-material\section-4_img-4.png)|![image](readme-material\section-4_img-5.png)|![image](readme-material\section-4_img-6.png)|

> **✏️NOTE:**
>
> we can pick multiple Images

the design of upload section is similar to that of signup page

- as it contains textfields which require regex to validate input,
- and also an image picker,

|![image](readme-material\section-4_img-7.png)|![image](readme-material\section-4_img-8.png)|
|-|-|

we also work on stores for the suppliers
|![image](readme-material\section-4_img-9.png)|![image](readme-material\section-4_img-10.png)|
|-|-|

</details>

### 05 - Streaming Data to Application

<details>
<summary>showing items from Firebase to app</summary>

 ![image](readme-material\section-5_img-1.png)

clicking on buttons gives:
|![image](readme-material\section-5_img-2.png)|![image](readme-material\section-5_img-3.png)|
|-|-|

|stores section|inside each store:|on clicking each product|more pictures upon clicking the main picture|
|-|-|-|-|
| ![image](readme-material\section-5_img-4.png)|![image](readme-material\section-5_img-5.png)| ![image](readme-material\section-5_img-6.png)| ![image](readme-material\section-5_img-7.png)|
</details>

### 06 - State Management [ Add To Cart - Wishlist ]

<details>
<summary>Adding To Cart/Wishlist</summary>

in this section:

#### 1 - Adding to wishlist

|![image](readme-material\section-6_img-1.png)|![image](readme-material\section-6_img-2.png)|
|-|-|

#### 2 - adding to cart

|![image](readme-material\section-6_img-3.png)|![image](readme-material\section-6_img-4.png)|
|-|-|

can increment items in cart

![image](readme-material\section-6_img-5.png)

delete items from cart

![image](readme-material\section-6_img-6.png)

clear cart w/ the button above

![image](readme-material\section-6_img-7.png)

add to cart from product_details page

![image](readme-material\section-6_img-8.png)

by clicking the 'added to cart' button snackbar appears

![image](readme-material\section-6_img-9.png)

incrementing stops after reaching max items in stock
and math done for total price of all items

|![image](readme-material\section-6_img-10.png)| ![image](readme-material\section-6_img-11.png)|
|-|-|

</details>

### 07 - Checkout & Upload Order

<details>
<summary>Checkout further handles customer requests like: confirming order</summary>

|The checkout button is now functioning|upon clicking the checkout button: |upon clicking the confirm order: |upon confirming order: |
|-|-|-|-|
|![image](readme-material\section-7_img-1.png)|![image](readme-material\section-7_img-2.png)|![image](readme-material\section-7_img-3.png)|![image](readme-material\section-7_img-4.png)|
||we land on placeOrder phone and address not present for now|different price generated because of shipping cost (for now payment method will be cash only)|cart is cleared and the the order is placed in the Order page in profile|

|the orders page has cards which contain confirmation of review and delivery status|this one has status: **preparing**|
|-|-|
|![image](readme-material\section-7_img-5.png)|![image](readme-material\section-7_img-6.png)|
</details>

### 08 - Dashboard Components

<details>
<summary> dealing with supplier orders in dashboard</summary>

|clicking orders tab|clicking on an order |declaring as delivered|brings it to delivered tab|each order shows customer info.|
|-|-|-|-|-|
|![dashboard-orders](readme-material\section-8_img-1.png)|![selecting-order-as-supplier](readme-material\section-8_img-2.png)|![alt text](readme-material\section-8_img-3.png)|![alt text](readme-material\section-8_img-4.png)|![alt text](readme-material\section-8_img-5.png)|

|statics screen|shows statistics|Balance screen|shows balance|
|-|-|-|-|
|![alt text](readme-material\section-8_img-6.png)|![alt text](readme-material\section-8_img-7.png)|![alt text](readme-material\section-8_img-8.png)|![alt text](readme-material\section-8_img-9.png)|

</details>
