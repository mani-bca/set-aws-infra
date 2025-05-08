# modules/ec2-scheduler/files/start_ec2_instances.py

import boto3
import os
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    Start EC2 instances based on tags
    """
    # Initialize EC2 client
    ec2 = boto3.client('ec2')
    
    # Get tag key and value from environment variables or use defaults
    tag_key = os.environ.get('TAG_KEY', 'AutoStartStop')
    tag_value = os.environ.get('TAG_VALUE', 'true')
    
    logger.info(f"Starting EC2 instances with {tag_key}={tag_value}")
    
    # Find stopped instances with the specified tag
    filters = [
        {'Name': f'tag:{tag_key}', 'Values': [tag_value]},
        {'Name': 'instance-state-name', 'Values': ['stopped']}
    ]
    
    # Get instance IDs
    instances = ec2.describe_instances(Filters=filters)
    instance_ids = []
    
    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])
    
    if not instance_ids:
        logger.info("No instances to start")
        return {'statusCode': 200, 'body': 'No instances to start'}
    
    # Start the instances
    logger.info(f"Starting instances: {instance_ids}")
    ec2.start_instances(InstanceIds=instance_ids)
    
    return {
        'statusCode': 200,
        'body': f'Started {len(instance_ids)} instances'
    }