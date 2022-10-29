import json
import boto3
from decimal import *

class DecimalEncoder(json.JSONEncoder):
	def default(self, obj):
		if isinstance(obj, Decimal):
			return str(obj)
		return json.JSONEncoder.default(self, obj)


def main (event, context):
	client = boto3.resource('dynamodb', region_name="us-east-1")
	table = client.Table("AWSDynamoDB-g3")
	
	data = table.scan()["Items"]

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": json.dumps(data, cls=DecimalEncoder)
	}

	return resp