# docker-prometheus-s3
This customized Prometheus container will fetch it's configuration data from the S3 bucket specified in the `S3_CONFIG_LOCATION` environment variable.

## IAM Permissions
The container will need a policy similar to below to be able to fetch the configuration at start-up:
```hcl
{
  Effect = "Allow"
  Action = [
    "s3:GetObject",
    "s3:ListBucket",
  ]
  Resource = [
    <s3-bucket-name>,
    "<s3-bucket-name>/*"
  ]
}
```

## Reason
In order to facilitate move prometheus metrics from ECS in to AWS Managed Prometheus, we need an intermediary Prometheus server to do the scraping.
- Cloudwatch Agent doesn't support forwarding Prometheus metrics (it only sends them to Cloudwatch, and doesn't support histogram)
- Existing containers that do a similar thing don't use S3 as the storage medium, and don't support the latest Prometheus version
  - The latest version of Prometheus support AWS SigV4 remote_writes, so you don't require a side-car to send requests in to AWS Managed Prometheus

Because of these reasons, it was easier to just roll a custom docker container that did what we needed.