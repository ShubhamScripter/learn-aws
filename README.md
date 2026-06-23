# TaskFlow SaaS

Simple Node.js task management API — AWS EC2 + RDS PostgreSQL ke liye ready.

## Project Structure

```
├── index.js          # Main entry (PM2 isse start karega)
├── config/db.js      # PostgreSQL connection
├── routes/api.js     # API routes
├── db/init.sql       # Database schema
├── scripts/init-db.js
└── ec2-setup.sh      # EC2 deployment script
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | App info |
| GET | `/health` | Health + DB check |
| GET | `/api/users` | List users |
| POST | `/api/users` | Create user `{ "name": "Ali", "email": "ali@test.com" }` |
| GET | `/api/tasks` | List all tasks |
| POST | `/api/tasks` | Create task `{ "user_id": 1, "title": "Learn AWS" }` |
| GET | `/api/users/:id/tasks` | User ke tasks |
| PATCH | `/api/tasks/:id` | Update task `{ "completed": true }` |

## Local Setup

```bash
cp .env.example .env
# .env me apne DB details daalo
npm install
npm run db:init
npm start
```

## AWS Deployment Steps

### 1. GitHub pe push karo

```bash
git init
git add .
git commit -m "Initial commit: TaskFlow SaaS"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. RDS PostgreSQL banao (AWS Console)

- Engine: PostgreSQL
- DB name: `appdb`
- Username: `appadmin`
- Security Group: EC2 se port 5432 allow karo

### 3. EC2 instance banao

- AMI: Amazon Linux 2023
- Security Group: port 22 (SSH) + port 3000 (HTTP) open karo
- User data ya SSH se `ec2-setup.sh` run karo (script me GitHub URL update karo)

### 4. Test karo

```bash
curl http://EC2_PUBLIC_IP:3000/health
curl http://EC2_PUBLIC_IP:3000/
```

## PM2 Commands

```bash
pm2 status
pm2 logs taskflow
pm2 restart taskflow
```
