#!/bin/bash

sudo dnf update -y
sudo dnf install -y httpd

# Get the instance ID using the instance metadata
INSTANCE_REGION=$(TOKEN=$(curl -s -X PUT http://169.254.169.254/latest/api/token \
-H "X-aws-ec2-metadata-token-ttl-seconds:21600") && curl -s -H "X-aws-ec2-metadata-token:$TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
INSTANCE_IP=$(TOKEN=$(curl -s -X PUT http://169.254.169.254/latest/api/token \
-H "X-aws-ec2-metadata-token-ttl-seconds:21600") && curl -s -H "X-aws-ec2-metadata-token:$TOKEN" http://169.254.169.254/latest/meta-data/hostname | cut -d "." -f 1 | cut -d "-" -f 2-5 | sed "s/-/./g")

# Install the AWS CLI
sudo dnf install -y awscli

# Download the images from S3 bucket
# aws s3 cp s3://terraform-aws-s3-bucket-2026/project.webp /var/www/html/project.png --acl public-read

# Create a simple HTML file with the portfolio content and display the images
sudo cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Terraform - AWS Infrastructure</title>

<link rel="icon" type="image/png" href="https://imgs.search.brave.com/WVI73g979SHo47bOE-x66C56PJ5_zzlHOeDd5cp_ZTo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YTIuZGV2LnRvL2R5/bmFtaWMvaW1hZ2Uv/d2lkdGg9ODAwLGhl/aWdodD0sZml0PXNj/YWxlLWRvd24sZ3Jh/dml0eT1hdXRvLGZv/cm1hdD1hdXRvL2h0/dHBzOi8vZGV2LXRv/LXVwbG9hZHMuczMu/YW1hem9uYXdzLmNv/bS91cGxvYWRzL2Fy/dGljbGVzL3F5Nmpk/YWxkbnNqcWNwNTVx/MmJpLnBuZw">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Poppins',sans-serif;
    background:#fafafa;
    color:#333;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
    background-image:
    radial-gradient(circle at top right,#f9731640,transparent 35%),
    radial-gradient(circle at bottom left,#7c3aed30,transparent 35%);
}

.container{
    width:100%;
    max-width:900px;
}

.card{
    background:#ffffff;
    border-radius:20px;
    padding:45px;
    box-shadow:0 15px 45px rgba(0,0,0,.08);
    border:1px solid rgba(0,0,0,.05);
}

.badge{
    display:inline-block;
    padding:8px 18px;
    background:#f97316;
    color:#fff;
    border-radius:30px;
    font-size:14px;
    margin-bottom:18px;
}


h1{
    font-size:42px;
    color:#6d28d9;
    margin-bottom:10px;
}

.subtitle{
    color:#666;
    font-size:17px;
    margin-bottom:35px;
}

.info-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:20px;
    margin-bottom:35px;
}

.info-box{
    background:#faf5ff;
    border-left:5px solid #f97316;
    padding:20px;
    border-radius:12px;
    transition:.3s;
}

.info-box:hover{
    transform:translateY(-4px);
    box-shadow:0 10px 25px rgba(124,58,237,.12);
}

.label{
    color:#888;
    font-size:14px;
    margin-bottom:8px;
}

.value{
    color:#6d28d9;
    font-weight:600;
    font-size:18px;
    word-break:break-word;
}

.flow{
    background:linear-gradient(135deg,#f97316,#7c3aed);
    color:white;
    border-radius:16px;
    padding:28px;
}

.flow h2{
    margin-bottom:15px;
    font-size:24px;
}

.flow p{
    line-height:1.8;
    font-size:16px;
}

.footer{
    text-align:center;
    margin-top:25px;
    color:#888;
    font-size:14px;
}

.highlight{
    color:#f97316;
    font-weight:600;
}

@media(max-width:700px){

.card{
padding:25px;
}

h1{
font-size:30px;
}

.flow h2{
font-size:20px;
}

}

.title-container {
    display: flex;
    align-items: center;
    gap: 12px;           /* Space between logo and text */
}

.terraform-logo {
    width: 62px;         /* Adjust as needed */
    height: 62px;
    object-fit: contain;
    flex-shrink: 0;
}

.title-container h1 {
    margin: 0;
    font-size: 39px;     /* Match your current heading */
    color: #673DE6;
    font-weight: 700;
}

</style>

</head>
<body>

<div class="container">

<div class="card">

<div class="badge">
	AWS + Terraform
</div>

<div class="title-container">
    <img src="https://media2.dev.to/dynamic/image/width=800,height=,fit=scale-down,gravity=auto,format=auto/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/qy6jdaldnsjqcp55q2bi.png" alt="Terraform Logo" class="terraform-logo">
    <h1>AWS Infrastructure using Terraform</h1>
</div>

<p class="subtitle">
  Provisioned Infrastructure using Terraform with a secure and scalable AWS architecture.
</p>

<div class="info-grid">

<div class="info-box">
<div class="label">EC2 Instance - REGION (AZ)</div>
<div class="value">$INSTANCE_REGION</div>
</div>

<div class="info-box">
<div class="label">EC2 Instance - IP Address</div>
<div class="value">$INSTANCE_IP</div>
</div>

</div>

<div class="flow">

<h2>Infrastructure Request Flow</h2>

<p>
👤 User
<span class="highlight">→</span>
🌐 Internet
<span class="highlight">→</span>
🚪 Internet Gateway (IGW)
<span class="highlight">→</span>
🛣️ Public Route Table
<span class="highlight">→</span>
📡 Public Subnet
<span class="highlight">→</span>
⚖️ Application Load Balancer (ALB)
<span class="highlight">→</span>
🔒 Private Subnet
<span class="highlight">→</span>
🖥️ EC2 Instance
<span class="highlight">→</span>
📤 Response returned securely through the ALB back to the User.
</p>

</div>

<div class="footer">
Powered by <strong>Terraform</strong> • <strong>AWS</strong> • Infrastructure as Code
</div>

</div>

</div>

</body>
</html>
EOF

# Start Apache and enable it on boot
sudo systemctl start httpd
sudo systemctl enable httpd