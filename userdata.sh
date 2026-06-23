#!/bin/bash
# System update
yum update -y

# Node.js install (v20)
curl -sL https://rpm.nodesource.com/setup_20.x | bash -
yum install -y nodejs git

# App clone aur setup
cd /home/ec2-user
git clone https://github.com/ShubhamScripter/learn-aws.git app
cd app
npm install

# Environment variables
cat > .env << 'EOF'
DB_HOST=myapp-db.xxxxxxxxx.ap-south-1.rds.amazonaws.com
DB_PORT=5432
DB_NAME=appdb
DB_USER=appadmin
DB_PASSWORD=your-actual-password
PORT=3000
EOF

# Process manager install + app start
npm install -g pm2
pm2 start index.js --name myapp
pm2 startup
pm2 save
