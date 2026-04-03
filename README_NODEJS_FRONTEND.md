# MharRuengSang Food Delivery Platform (Node.js + React)

A simplified full-stack food delivery application featuring a **React (Vite)** frontend and a monolithic **Node.js (Express)** + **MySQL** backend.

This version is an alternative to the original Dockerized Spring Boot microservices backend, designed to be **lightweight, easier to set up natively, and quicker to modify**.

---

## 🛠️ Technology Stack

*   **Frontend**: React, TypeScript, Vite, Tailwind CSS
*   **Backend**: Node.js, Express.js, JWT Authentication
*   **Database**: MySQL (using `mysql2` driver)

---

## 🚀 Quick Start Guide

### 1. Database Setup (MySQL)
First, ensure you have a local MySQL server running (e.g., via XAMPP, MAMP, or native MySQL install).

1. Open your terminal or MySQL command line.
2. Import the schema and demo data using the provided SQL script:
   ```bash
   mysql -u root -p < Implementations/Backend-NodeJS/setup-db.sql
   ```
This will create a database named `mharruengsang`, build all the necessary tables (Users, Restaurants, Menus, Orders), and populate them with demo data and bcrypt-hashed passwords.

### 2. Backend Setup (Node.js)
1. Open a new terminal window and navigate to the new Node.js backend directory:
   ```bash
   cd Implementations/Backend-NodeJS
   ```
2. Install the necessary Node dependencies:
   ```bash
   npm install
   ```
3. Create/verify your `.env` file inside the `Backend-NodeJS` folder. It should look like this:
   ```env
   PORT=8080
   DB_HOST=localhost
   DB_USER=mharruengsang
   DB_PASSWORD=mhar1234
   DB_NAME=mharruengsang
   JWT_SECRET=supersecretkey_mharruengsang
   ```
   *(We've pre-configured `DB_USER` and `DB_PASSWORD` to use the dedicated user created by the initial setup script).*
4. Start the development server:
   ```bash
   npm run dev
   ```
   The backend will now be running on `http://localhost:8080`.

### 3. Frontend Setup (React)
1. Open another terminal window and navigate to the frontend directory:
   ```bash
   cd Implementations/Frontend
   ```
2. Install the frontend dependencies:
   ```bash
   npm install
   ```
3. Start the Vite development server:
   ```bash
   npm run dev
   ```
   The frontend will now be accessible at `http://localhost:5173`.

---

## 🔑 Demo Accounts

You can log in to the application using any of the following pre-configured demo accounts. 

*   **Customer**: `customer@foodexpress.com` / `Customer123!`
*   **Restaurant**: `restaurant@foodexpress.com` / `Restaurant123!`
*   **Rider**: `rider@foodexpress.com` / `Rider123!`
*   **Admin**: `admin@foodexpress.com` / `Admin123!`

> **Note on OTP Login**: The initial login simulates sending an OTP to your email. Because this is a local development environment, **you can type ANY 6-digit number** (e.g., `123456`) on the verification screen to proceed and retrieve your session token!

---

## 📂 Project Structure

```text
MharRuengSang/
├── Implementations/
│   ├── Backend-NodeJS/       <-- New Lightweight Node.js Monolith API
│   │   ├── src/
│   │   │   ├── config/       <-- DB connection
│   │   │   ├── routes/       <-- API endpoints (Auth, Orders, Restaurants...)
│   │   │   └── index.js      <-- Main server entry file
│   │   ├── setup-db.sql      <-- MySQL Schema + Demo Data Dump
│   │   ├── package.json
│   │   └── .env              
│   │
│   ├── Frontend/             <-- React + Vite Client
│   │   ├── src/
│   │   │   ├── app/          <-- Core application (Components, Pages, Services)
│   │   │   ├── styles/       <-- Tailwind configs
│   │   │   └── main.tsx      <-- React mount point
│   │   ├── package.json
│   │   └── vite.config.ts
│   │
│   └── Backend/              <-- Original Spring Boot Microservices (Dockerized)
```

## 📝 Available API Routes (Node.js)

All routes are correctly versioned to match the frontend expectations:

*   **Auth**: `/api/v1/auth/login`, `/api/v1/auth/otp`
*   **Restaurants**: `/api/v1/restaurants`, `/api/v1/restaurants/:id`, `/api/v1/restaurants/:id/menu`
*   **Orders**: `/api/v1/orders`, `POST /api/v1/orders`, `/api/v1/orders/customer/:id`
*   **Customers**: `/api/v1/customers/profile`, `/api/v1/customers/addresses`
*   **Riders**: `/api/v1/riders`, `/api/v1/riders/available`
*   **Payments**: `POST /api/v1/payments/process`, `POST /api/v1/payments/verify`