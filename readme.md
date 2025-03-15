<h1 align="center"><b>✨ SWIFTPAY - Fintech Platform ✨</b></h1>

![Demo App](/swiftpay.gif)

## 📌 Project Overview
Swiftpay is a **highly scalable**, **event-driven**, **microservices-based banking application** that provides secure and **efficient financial transactions**, user authentication, notifications, and risk management.Built with Node.js, Express.js, MongoDB, Kafka, Firebase,Flutter, Kubernetes, and Terraform. This project ensures security, scalability, and high availability.

## 🌟 Key Features

- ✅ Microservices Architecture → Independent services for Transactions, Users, Notifications, Financial Products, Risk Management, and Audit Logging.
- ✅ JWT & Firebase Authentication → Secure login and session management.
- ✅ Real-Time Transactions → Handle deposits, withdrawals, and transfers with MongoDB.
- ✅ Event-Driven Communication → Uses Kafka for asynchronous messaging.
- ✅ Push Notifications → Firebase Cloud Messaging (FCM) for real-time alerts.
- ✅ Fraud & Risk Analysis → AI-powered risk evaluation.
- ✅ Scalable Infrastructure → Deployable with Kubernetes and Terraform on AWS/GCP.
- ✅ CI/CD Integration → Automated deployments with GitHub Actions & GitLab CI/CD.
- ✅ Fully Documented API → Swagger documentation for seamless integration.
- ✅ React.js Frontend → Interactive banking dashboard.

## 📂 Project Structure

```shell
/XNL-21BAI1743-MOBILE-1
│
├── /microservices              # Microservices directory
│   ├── /transaction-service    # Handles transactions
│   ├── /user-service           # Manages user data and authentication
│   ├── /notification-service   # Handles sending notifications
│   ├── /financial-product-service # Manages financial product data
│   ├── /risk-management-service # Handles risk analysis and alerts
│   └── /audit-service          # Audit logging and data integrity
│
├── /frontend                   # Frontend application (React.js)
│   ├── /src                    # Source files for the UI
│   ├── /public                 # Static assets
│   └── /build                  # Compiled frontend
│
├── /infrastructure             # Infrastructure as code
│   ├── /kubernetes             # Kubernetes deployment configurations
│   ├── /terraform              # Terraform scripts for cloud provisioning
│   └── /helm                   # Helm charts for Kubernetes deployment
│
├── /ci-cd                      # CI/CD pipeline configurations
│   ├── /github-actions         # GitHub Actions workflows
│   └── /gitlab-ci              # GitLab CI/CD configurations
│
└── /docs                       # Documentation
    ├── /api                    # Swagger API documentation
    └── /user                   # User documentation
```

## 🛠️ Microservices Overview  

Each microservice runs independently and is responsible for a specific domain.  

### 1️⃣ API Gateway (Port: 3000)  
   - Routes requests to microservices.  
   - Handles authentication and load balancing.  

### 2️⃣ User Service (Port: 4001)  
   - User authentication via Firebase and JWT.  
   - Manages user profiles and balances.  

### 3️⃣ Transaction Service (Port: 4002)  
   - Handles deposits, withdrawals, and transfers.  
   - Maintains transaction history in MongoDB.  

### 4️⃣ Notification Service (Port: 4003)  
   - Sends push notifications using Firebase Cloud Messaging.  
   - Email and SMS alerts for account activity.  

### 5️⃣ Financial Product Service (Port: 4004)  
   - Manages banking products such as loans, savings, and credit cards.  
   - Provides interest rate calculations.  

### 6️⃣ Risk Management Service (Port: 4005)  
   - AI-driven fraud detection and analysis.  
   - Flags suspicious transactions.  

### 7️⃣ Audit Service (Port: 4006)  
   - Logs user activities for security auditing.  
   - Ensures compliance with financial regulations.  

## 📦 Deployment & Setup
### 1️⃣ Clone the repository
```shell
git clone https://github.com/Sandhit06/XNL-21BAI1743-MOBILE-1.git
cd XNL-21BAI1743-MOBILE-1
```
### 2️⃣ Install dependencies
```shell
cd microservices/user-service
npm install
```
### 3️⃣ Start services
```shell
docker-compose up -d
```

### 4️⃣ Access API Gateway
```shell
http://localhost:3000/
```

## 🏗️ Infrastructure as Code
### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: transaction-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: transaction-service
  template:
    metadata:
      labels:
        app: transaction-service
    spec:
      containers:
      - name: transaction-service
        image: transaction-service:latest
        ports:
        - containerPort: 4002
```

