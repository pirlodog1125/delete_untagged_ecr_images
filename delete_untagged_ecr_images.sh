#!/bin/sh
if [ "$1" = "" ]
then
    echo "第1引数にリポジトリ名を指定して下さい。"
    # 処理を中断。
    exit 1
fi

ECR_REGION='ap-northeast-1'
ECR_REPO=$1
IMAGES_TO_DELETE=$( aws ecr list-images --region $ECR_REGION --repository-name $ECR_REPO --filter "tagStatus=UNTAGGED" --query 'imageIds[*]' --output json )
echo $IMAGES_TO_DELETE
aws ecr batch-delete-image --region $ECR_REGION --repository-name $ECR_REPO --image-ids "$IMAGES_TO_DELETE" || true