# modules/lambda/files/stop_ec2_instances.py

import boto3
import os
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    Stop EC2 instances based on tags
    """
    # Initialize EC2 client
    ec2 = boto3.client('ec2')
    
    # Get region
    region = os.environ.get('AWS_REGION')
    
    # Get tag key and value from environment variables or use defaults
    tag_key = os.environ.get('TAG_KEY', 'AutoStop')
    tag_value = os.environ.get('TAG_VALUE', 'true')
    
    # Log the start of the function
    logger.info(f"Stopping EC2 instances in {region} with {tag_key}={tag_value}")
    
    # Find instances with the specified tag
    filters = [
        {
            'Name': f'tag:{tag_key}',
            'Values': [tag_value]
        },
        {
            'Name': 'instance-state-name',
            'Values': ['running']
        }
    ]
    
    # Describe instances with the specified filters
    response = ec2.describe_instances(Filters=filters)
    
    # Extract instance IDs from the response
    instance_ids = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])
    
    # If no instances found, log and return
    if not instance_ids:
        logger.info("No running instances found with the specified tag")
        return {
            'statusCode': 200,
            'body': 'No instances to stop'
        }
    
    # Stop the instances
    logger.info(f"Stopping instances: {instance_ids}")
    stop_response = ec2.stop_instances(InstanceIds=instance_ids)
    
    # Log the response
    logger.info(f"Stop response: {stop_response}")
    
    # Return success
    return {
        'statusCode': 200,
        'body': f'Stopped {len(instance_ids)} instances'
    }