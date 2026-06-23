#!/bin/bash
set -e

# System update
sudo yum update -y

# Node.js install (v20)
curl -sL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nodejs git

# App clone aur setup
cd /home/ec2-user
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git app
cd app
npm install

# Environment variables (RDS details yahan daalo)
cat > .env << 'EOF'
DB_HOST=myapp-db.xxxxxxxxx.ap-south-1.rds.amazonaws.com
DB_PORT=5432
DB_NAME=appdb
DB_USER=appadmin
DB_PASSWORD=your-actual-password
DB_SSL=true
PORT=3000
EOF

# Database tables create karo
npm run db:init

# Process manager install + app start
sudo npm install -g pm2
pm2 start index.js --name taskflow
pm2 startup
pm2 save

echo "App deployed! Test: curl http://localhost:3000/health"
