import boto3
import json


def main(event, context):
    client = boto3.client('dynamodb')

    client.put_item(Item={
        "id": {
            "N": "1"
        },
        "stock": {
            "N": "2212"
        },
    },
        TableName='AWSDynamoDB-g3')

    print ("In lambda handler")

    resp = {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",
        },
        "body": "Se cargó el elemento correctamente"
    }

    return resp
