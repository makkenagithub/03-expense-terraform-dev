# 03-expense-terraform-dev

If the files in sg drectory wants to access variables/values in vpc directory, then its not possible.

Terraform can only acees the files in its own repo or directory. It cant access outside tf files

If we want the terraform to access the values of out side files, We can do it with ssm param store.

We can store the values to ssm param store and access them as and when needed.

vpc can store the values in ssm paramstore and sg can access from ssm paramstore.

SSM Paramstore:

SSM paramstore is just key value pair.

mysql:

port : 3306

IP: backend private IP

Private IP will not change after ec2 instance restart But public IP will change after restart.

Private IP may change after ec2 termination and recreation of ec2.

So instead of allowing IPs from backend , we can allow backend security group.

Source: Backend SG -> mysql will allow connection from instances which are attached to backend SG.

backend SG: backend SG accepts connections from frontend SG, port 8080

frontend SG: it accept connections from public (0.0.0.0/0), port 80


Bastion and VPN:

We have two optons to connect to office network from home

1. Bastion (jump server)
2. VPN

Bastion - Bastion is a server , usually placed in public subnet and we create a seperate sg for it. Users can connect to bastion server and then access the frontend/backend/db servers


Opensource modules:

We have opensource modules contributed from terrafrom and AWS. we can use them also.

Adv:

we no need to develop module.

Dis Adv:

We need to depend on community

Custom modules:

1. we have to develop everything. 
2. we have freedom to develop whatever we want.

To see the running logs of an ec2 server, the path is

/var/log/cloud-init-output.log








