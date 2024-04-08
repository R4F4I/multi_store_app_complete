# multi_store_app

 flutter app project w/ udemy

<details>
<summary>creating an empty layout of the app</summary>
</details>

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

### 09 - Adding Discount to products

<details>
<summary> Adding Discount to products</summary>

|New field for input| Taking Input|
|-|-|
|![section-9_img-1](readme-material\section-9_img-1.png)|![section-9_img-2.png](readme-material\section-9_img-2.png)|
||This textfield takes in a number b/w 1-100 and gives a % discount accordingly,|
||here the discount will be 14% |

|showcase in home screen|changed price|discount price instead of actual price|
|-|-|-|
|![alt text](readme-material\section-9_img-3.png)|![alt text](readme-material\section-9_img-4.png)|![alt text](readme-material\section-9_img-5.png)|





</details>

### 10 - Search Engine ====== end of v1.0

<details>
<summary> Working on the search engine to navigate through products</summary>

|by clicking the search bar|Empty prompt screen|Results in search bar correspond to prompt|result for 'ja', 'je', 'phone' |
|-|-|-|-|
|![alt text](readme-material/section-10_img-1.png)|![alt text](readme-material/section-10_img-2.png)|![alt text](readme-material/section-10_img-3.png)|![alt text](readme-material/section-10_img-4.png)|
|we are sent to a page that showcases all the results matching the prompt|| E.g: 's' shows all results with the letter 's' in their name|gives results such as 'ja'cket, 'je'ans, and various products with 'phone in their name |
</details>

### 11 - Flutter 3

<details>
<summary> </summary>

- 001 Migration to Flutter 3

</details>

### 12 - Payment Online ( Flutter Stripe ) [ V1.1 ]

<details>
<summary> </summary>

- 001 Install Stripe to Application
- 002 Payment Sheet
- 003 Passing Total Payment value

</details>

### 13 - Adding Review to Products

<details>
<summary> </summary>

- 001 Rate & Comment
- 002 Uploading Review
- 003 Streaming Reviews into Product Details
- 004 Review Model [unsolved challenge]

</details>

### 14 - Edit Store [ Supplier ]

<details>
<summary> </summary>

- 001 Replace Store logo
- 002 Replace Cover Image & edit store info
- 003 Save Changes p1
- 004 Save Changes p2

</details>

### 15 - Edit Products [ Supplier ]

<details>
<summary> </summary>

- 001 Current Images & Categories
- 002 Edit Images & Categories
- 003 Current Item Data
- 004 Save Changes [ unsolved Challenge]
- 005 Delete Product

</details>

### 16 - How to Think [ Customer Multiple Address ]

<details>
<summary> </summary>

- 001 Adding Multiple Addresses Challenge [ Solved ]
- 002 Add New Address p1 [ Form ]
- 003 Add New Address p2 [ Country Picker ]
- 004 Add New Address p3 [ Upload Data ]
- 005 Address Book p1 [ Streaming Data ]
- 006 Address Book p2 [ Set As Default ]
- 007 Pass Default Address to Place Order
- 008 Check If Address Book is empty !
- 009 Pass Data to Payment Screen
- 010 Update Customer Profile
- 011 Processing & Delete Address

</details>

### 17 - Authentication [ Level 2 ]
<details>
<summary> </summary>

- 001 Send Email Verification
- 002 Check Email Verification
- 003 Re-Send Email Verification
- 004 Firebase Auth User Data
- 005 Refactor Authentication Methods
- 006 Forgot Password
- 007 Change Password p1 [ Old Password Validation ]
- 008 Change Password p2 [ Strong Password Validation ]
- 009 Change Password p3 [ Set New Password ]
- 010 Layout Changes [ UI & UX Promise ]
- 011 Google Sign in [ install & necessary implementation]
- 012 Google Sign in [ Sign In & Upload Data ]
- 013 Google Sign in [ User Document Existing]
- 014 Google Sign in [ Listen to Current User ]

</details>

### 18 - On Boarding Screen ======end of v1.1

<details>
<summary> </summary>

- 001 You Will Love This Section
- 002 Skip Button
- 003 Skip On Timer
- 004 Offer.watches [ sub-collection ]
- 005 Offer.shoes [ main collection ]
- 006 Offer.sale [ discount ]
- 007 Random Offer
- 008 Navigator Switch
- 009 Positioned Widgets
- 010 Animated Container
- 011 Animated Opacity

</details>

### 19 - Suppliers' App vs Customers' App ( Build & Revision ) ..... [ v1.2 ]

<details>
<summary> </summary>

- 001 Create Two Apps
- 002 Copy Files ( Suppliers' App )
- 003 Run On Android
- 004 Run On iOs
- 005 Login As A Supplier
- 006 Copy Files & Android Build ( Customers' App )
- 007 Run On iOs
- 008 Login As A Customer
- 009 CustSupp Login ( half solved challenge)

</details>

### 20 - Remember Me( Shared Preferences )

<details>
<summary> </summary>

- 001 Shared Preferences [ counter example ]
- 002 Set & Get Supplier Id
- 003 Current User [ Supplier Id ]
- 004 Set & Get Customer Id
- 005 Current User [ Customer Id ]
- 006 Remember Me

</details>

### 21 - SQL + Provider[ shopping items database ]

<details>
<summary> </summary>

- 001 Flutter + SQL [ shopping items ]
- 002 Create Databse [ Notes App ]
- 003 Insert & rawInsert
- 004 Retrieve Data
- 005 Update & rawUpdate
- 006 Delete & rawDelete
- 007 Delete All Items
- 008 Upgrade Database ( ADD COLUMN )
- 009 Upgrade Database ( Todos Table )
- 010 Batch
- 010 sql-notes.zip
- 011 SQL + Provider [ Revision ]
- 012 Update the State [ Consumer ]
- 013 SQL + Provider [ Add Item ]
- 014 Existing in Database
- 015 SQL + Provider [ Load Notes ]
- 016 SQL + Provider [ delete & update ]
- 017 SQL + Provider [ clear items ]
- 017 sql-provider.zip
- 018 APPLY TO APP [ SHOPPING ITEMS ]
- [018 SQL-Tutorial-Full-Database-Course-for-Beginners-freeCodeCamp-.url](https://www.youtube.com/watch?v=HXV3zeQKqGY&t=6618s)

</details>

### 22 - Prefs + Provider [ Customer ID ]

<details>
<summary> </summary>

- 001 Prefs - Provider p1 [ Revision ]
- 002 Prefs - Provider p2 [ Extract Methods ]
- 003 Prefs - Provider p3 [ Notify Listeners ]
- 004 Prefs - Provider p4 [ Track customer ID ]

</details>

### 23 - Notifications [ FCM ]

<details>
<summary> </summary>

- 001 Notifications - Summary
- 002 Android Emulator Requirements
- 003 FCM library
- 004 Test Message ( Background & Terminated )
- 005 Background Messages Handler
- 006 Foreground Messages
- 007 Notification Channels ( Overview )
- 008 Create Notification Channel
- 009 Display Notification ( Heads-up Notifications )
- 010 Customers App ( Revision )
- 011 FollowUnfollow ( Save To Database )
- 012 Test Message ( Target a Topic )
- 013 Test Message ( send to token )
- 014 Handling Interactions

</details>

### 24 - Security Rules

<details>
<summary> </summary>

- 001 FireStore [ Security Rules ]
- 002 Getting Started With Security Rules ( Customers Collection )
- 003 Rules ( subCollection )
- 004 Rules ( Suppliers Collection )
- 005 Rules ( Functions )
- 006 Rules ( Products - get method )
- 007 Rules ( Products - delete document )
- 008 Rules ( Reviews - exists method )
- 009 Rules ( Orders Collection )
- 010 Rules ( update - transactions )
- 011 Rules ( Admins )
- 012 Rules ( format Rules into functions )
- 013 Rules ( Test on App )
- 014 One More Step to Secure Data

</details>

[//]: <> (This is also a comment.)
[//]: <> (https://stackoverflow.com/questions/51287097/how-do-you-delete-lines-with-certain-keywords-in-vscode)
[//]: <> (https://stackoverflow.com/questions/4823468/comments-in-markdown)
[//]: <> (https://stackoverflow.com/questions/33648152/regex-match-numbers-greater-or-equal-than-20-by-increments-of-5-range-20-to-99)
