# cluster-deployment
Deploy a KinD cluster

# GitHub Runner
Run the `docker build` commands to build the GitHub runner before running it:

```
# Build the GitHub runner image
docker build -t github-runner:latest .

# Run the GitHub runner container
docker run -d --name github-runner \
  -e 
```