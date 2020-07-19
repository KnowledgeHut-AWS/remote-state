
run: stop start exec

start:
	docker run -it -d --env AWS_PROFILE="kh-labs" --env TF_PLUGIN_CACHE_DIR="/plugin-cache" -v /var/run/docker.sock:/var/run/docker.sock -v $$(pwd):/work -v $$PWD/creds:/root/.aws -v terraform-plugin-cache:/plugin-cache -w /work --name pawst2 bryandollery/terraform-packer-aws-alpine

exec:
	docker exec -it pawst2 bash || true

stop:
	docker rm -f pawst2 2> /dev/null || true

fmt:
	time terraform fmt -recursive

plan:
	time terraform plan -out plan.out

apply:
	time terraform apply plan.out 

up: plan apply

down:
	time terraform destroy -auto-approve 

init:
	time terraform init
