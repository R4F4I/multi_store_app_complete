# multi_store_app

 flutter app project w/ udemy

## Section Summaries

### 02 - layout [ V 1.0 ]

<details>
<summary>02 - layout [ V 1.0 ]</summary>
 creating an empty layout of the app

|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/b1efc2b4-b8ea-4cb7-95dd-3b343a99db36)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/730ec63a-29b5-45ce-b004-51c21dac1036)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/989e74f9-72da-47b5-bf99-d8ed2933de9d)|
|--|--|--|
</details>

### 03 - Firebase Authentication [ Level 1 ]

<details>
<summary>03 - Firebase Authentication [ Level 1 ]</summary>
 we will add functionality for the sign up buttons

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/7b2472a6-a7d3-40f7-a316-815e4fbaf342)

#### ⇒ it will consist of a sign Up page

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/0b86f8c6-d5f5-4ac4-8459-8fc18882359d) | ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/052acdde-4fc4-4c54-a7dd-6be2dc8b8742) | ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/33517eb6-606f-4bfb-a3a1-6fa106dbe82b) | ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/1b718d17-b5fc-4778-a1e1-fe33dcf18bf9) | ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/82609749-8292-4424-9b44-ac14529c988d) |
|--|--|--|--|--|

- the sign up page will take the inputs of the given fields including the image
- it will also have the functionality to hide a password
- it will return any errors using the bottom yellow popup bar

#### It will also support a firebase connection

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/a0aeaa6d-258f-438b-af32-60f8e788d7f3)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/1114360e-d3f1-4fb6-90e3-6b9d98c56b97)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/9ca9d788-ad40-4da0-b5dd-bfa18057bf47)|
|--|--|--|

- this is due to the project containing a large amount of data,
- firebase will:
  - authenticate customers, &
  - store their data in a database, including their images

#### ⇒ we will also hold the ability to login into an existing account and switch b/w the login & signup pages

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/1a70f32d-d3be-4a4d-8b94-b81e9cfc2b65)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/9ac0d52e-f49c-4321-a03f-75774326a8aa)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/c65d5c25-9804-4e23-83bf-4c59ae89b971)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/35faf1a5-9d47-4531-a0ef-9e39fbe47578)|
|--|--|--|--|

#### ⇒ Same for suppliers

| supplier sign up ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/d1de0544-f295-4cd3-8ad1-9a6d682d1db7)| Store data for supplier![image](https://github.com/R4F4I/multi_store_app/assets/94185789/a84946b6-eee1-47c3-922c-48ae1cb98021)|supplier login ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/031e9783-1290-4457-a275-f7c7cbda3a74)|
|--|--|--|

#### ⇒ now within the login

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/27c2d0c2-3108-4797-acec-53c25db7dc88)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/f903ceef-404f-43c8-ae21-f0a413e5ff93)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/2beb16bb-2965-4872-b1e8-0cd233241c9d)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/7275b408-48b3-4afa-82e1-db88b9925ba8)|
|--|--|--|--|

#### ⇒ Now finally for guest

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/7884017e-61de-4d32-82eb-a1c3785fc7fa)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/09b2d9ba-6971-4188-a286-1007a63bd23b)|
|--|--|
</details>

### 04 - Upload Product [ Cloud Firestore ]

<details>
<summary>04 - Upload Product [ Cloud Firestore ]</summary>

we will now work in the supplier side of the prject,
like uploading products to the app

| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/dd974e22-64c8-4b0b-b4f8-07c17545132c)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/cc3d9523-3d1c-4240-8d60-7a4981592a22)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/f5492386-e6b2-45d5-9c82-6eb8c9aa5e95)|
|--|--|--|
|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/424c7c71-beee-4235-a710-d49dfb54ec1e)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/5f4005fe-f72e-4247-8ec5-c4d784bde441)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/daaa21df-8bc3-434c-b0ef-e3931a4e5f8c)|

> **✏️NOTE:**
>
> we can pick multiple Images

the design of upload section is similar to that of signup page

- as it contains textfields which require regex to validate input,
- and also an image picker,

|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/945be4e9-0cdc-42f9-bd84-b507cf755c23)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/139106dc-c0f8-4de9-ab1b-da5c17332776)|
|-|-|

we also work on stores for the suppliers
|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/2e3fa8b8-5d8a-4e2e-a90a-62ba3018aa1a)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/492aea45-3cb2-48f1-b820-12180adc6181)|
|-|-|

</details>

### 05 - Streaming Data to Application

<details>
<summary>05 - Streaming Data to Application</summary>

 ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/1352fda7-d915-486c-8227-ddbace3fe107)

clicking on buttons gives:
|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/f6e08926-14a9-4ef8-9291-26f049345f10)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/bc1fb66d-6f0a-4352-a37a-053bab382e19)|
|-|-|

|stores section|inside each store:|on clicking each product|more pictures upon clicking the main picture|
|-|-|-|-|
| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/bf5128e9-0684-4da8-b595-a9b8df9d687e)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/01a15494-cbba-4df8-9347-dbda0d73c102)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/17957226-1ac3-438c-b504-ee7156c01f23)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/dfeee15d-3de1-45cb-bf6d-7c624f904a27)|
</details>

### 06 - State Management [ Add To Cart - Wishlist ]

<details>
<summary>06 - State Management [ Add To Cart - Wishlist ]</summary>

in this section:

#### 1 - Adding to wishlist

|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/5ef3bce7-70ec-4619-9da1-83f963bd83a4)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/f0f5b4ad-e750-4979-b585-660d602474cf)|
|-|-|

#### 2 - adding to cart

|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/d3633131-ae89-4e8d-ac12-43b0a813c6b6)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/a07bab41-c2b8-40ef-acd4-24feb4c57de5)|
|-|-|

can increment items in cart

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/c9655117-7cef-4b5e-a479-ae5e11f67012)

delete items from cart

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/d5145990-8d2d-44d7-af37-02f0b6b48c2f)

clear cart w/ the button above

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/877cb101-bf7d-4906-866b-a5c917e53179)

add to cart from product_details page

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/e804cdab-bbfc-42a0-b947-95cad5be16ea)

by clicking the 'added to cart' button snackbar appears

![image](https://github.com/R4F4I/multi_store_app/assets/94185789/5708e257-74db-4bbf-a22e-7b7dc134f5c4)

incrementing stops after reaching max items in stock
and math done for total price of all items

|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/69d6bf1b-7393-491d-9e9f-296149d09da1)| ![image](https://github.com/R4F4I/multi_store_app/assets/94185789/f1451510-91b1-4e34-ba49-011767b61f28)|
|-|-|

</details>

### 07 - Checkout & Upload Order

<details>
<summary> 07 - Checkout & Upload Order</summary>

||upon clicking the checkout button: we land on placeOrder phone and address not present for now|upon clicking the confirm order: different price generated because of shipping cost (for now payment method will be cash only)|upon confirming order: cart is cleared and the the order is placed in the Order page in profile|
|-|-|-|-|
|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/408193b6-58a3-49f0-98b1-ed61f643e349)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/e07d8e43-3825-438a-8197-a7315e2d03e8)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/a205cf99-bd0a-4eb1-8bbb-4dbd408d0b45)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/42154934-9529-45e7-9bc4-1bf2a58f0aa1)|

|the orders page has cards which contain confirmation of review and delivery status|this has status: **preparing**|
|-|-|
|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/b83dc926-52c3-4590-94ba-a06e81dbf2f4)|![image](https://github.com/R4F4I/multi_store_app/assets/94185789/20914371-e2a6-474a-afd4-b57e80967ae3)|
</details>
