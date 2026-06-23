# myapp

Simple Node.js app for AWS EC2 + RDS.

## Files

- `index.js` — main app (PM2 isse start karega)
- `userdata.sh` — EC2 user data script

## API

| Method | URL | Body |
|--------|-----|------|
| GET | `/` | App info |
| GET | `/health` | DB check |
| GET | `/api/notes` | All notes |
| POST | `/api/notes` | `{ "title": "Hello", "body": "text" }` |

## Local run

```bash
cp .env.example .env
npm install
npm start
```

## AWS

1. GitHub pe push karo
2. `userdata.sh` me repo URL + RDS password update karo
3. EC2 Launch Template → User data me script paste karo
4. Security Group: port 3000 + 22 open karo
5. RDS Security Group: EC2 se port 5432 allow karo

```bash
curl http://EC2_IP:3000/health
```
