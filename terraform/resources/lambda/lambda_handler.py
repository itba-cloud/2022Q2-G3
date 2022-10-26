import json
import boto3


def main (event, context):
	payload = event
	payload = payload["Records"][0]
	body = payload["body"]
	body = body.replace('\n', '')
	body = json.loads(body)
	query = body["body-json"]

	client = boto3.resource('dynamodb', region_name="us-east-1")
	table = client.Table("AWSDynamoDB-g3")
	
	table.put_item(Item=query)

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "El elemento fue agregado."
	}

	return resp