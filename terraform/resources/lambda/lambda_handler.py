import json
import boto3

def main (event, context):
	payload = event
	payload = payload["Records"][0]
	body = payload["body"]
	body = body.replace('\n', '')
	print(body)
	#body = json.dumps(body) 
	body = json.loads(body)
	query = body["body-json"]
	print("payload-> " + str(query) )
	
	client = boto3.resource('dynamodb', region_name="us-east-1")
	table = client.Table("AWSDynamoDB-g3")
	
	table.put_item(Item={
        "id": {
            "N": "1"
        },
        "stock": {
            "N": "2212"
        },
    })

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "El lab ha sido finalizado correctamente"
	}

	return resp