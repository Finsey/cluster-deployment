# cluster-deployment
Deploy a KinD cluster

## Deployment
### Local: GitHub Runner
Run the `docker build` commands to build the GitHub runner before running it:

```
# Build the GitHub runner image
docker build -t github-runner:latest .

# Run the GitHub runner container
docker run -d --name github-runner \
  -e 
```

install collections
ansible-galaxy collection install -r collections.yaml

install kubernetes
pip install kubernetes