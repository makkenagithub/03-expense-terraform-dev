# 03-expense-terraform-dev

If the files in sg drectory wants to access variables/values in vpc directory, then its not possible.

Terraform can only acees the files in its own repo or directory. It cant access outside tf files

If we want the terraform to access the values of out side files, We can do it with ssm param store.

We can store the values to ssm param store and access them as and when needed.

vpc can store the values in ssm paramstore and sg can access from ssm paramstore.

SSM Paramstore:

SSM paramstore is just key value pair.

