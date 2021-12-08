// -b --bucket buckect name
// -c --config config file
// -s --source source path
// -t --target target path
package main

import (
    "os"
	"log"
    "fmt"
    .	"context"
    "context"
	"github.com/minio/minio-go/v7"
	.   "github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
    "github.com/urfave/cli/v2"
)
const (
    endpoint = "10.10.8.15:9000"
	accessKeyID = "admin"
	secretAccessKey = "Risen*2021"
	// useSSL := false // http  do not need ssl
)

func main() {
    ctx := context.Background()
	app := &cli.App{
	Flags: []cli.Flag{
		&cli.StringFlag{
			Name:    "bucket",
			Aliases: []string{"b"},
			Usage:   "bucket name",
		},
		&cli.StringFlag{
			Name:    "source",
			Aliases: []string{"s"},
			Usage:   "source file name",
		},
		&cli.StringFlag{
			Name:    "contentType",
			Aliases: []string{"c"},
			Usage:   "contentType",
		},
		&cli.StringFlag{
			Name:    "target",
			Aliases: []string{"t"},
			Usage:   "target file name",
		},
        &cli.StringFlag{
			Name:    "init",
			Aliases: []string{"i"},
			Usage:   "init",
        },
	},
	    Name: "minio_client",
	    Usage: "minio client for chandler",
	}
	app.Action = func (c *cli.Context) error {
        if(c.String("init") != ""){
            multiline := ` 
#!/bin/bash
_upload() {
    local bucket=""
    local source=""
    local target=""
    local pwd=$(pwd)
	while [ "$1" ]; do
		case "$1" in
			-b) local bucket="$2" ;;
			-s) local source="$2" ;;
			-t) local target="$2" ;;
			*) break ;;
		esac
		shift 2
	done
    if [[ -f $source ]]; then
        upload -b $bucket -s $source -t $target
    elif [[ -d $source ]]; then
        files=$(find $source)
        files=$(echo $files | sed 's/ /,/g')
        IFS=',' read -r -a array <<< "$files"
        sub=$pwd/$source
        for element in "${array[@]}"
        do
            # echo -n $element | od -An -tuC
            if [[ -f $element ]]; then
                element=$(realpath $element)
                local source=$element
                target1="${element/$sub/}"
                target1=$target$target1
                echo $target1
                echo $source
                upload -b $bucket -s $source -t $target1
            fi
        done
    else
        echo "file is not existed"
    fi
}
# alias ${_ZL_CMD:-z}='_zlua 2>&1'
alias ${_UPLOAD:-minio}='_upload'
`
            fmt.Print(multiline)
            return nil
        }
        minioClient := minioInit()
        bucket := c.String("bucket")
        target := c.String("target")
        source := c.String("source")
        contentType := c.String("contentType")
        if(bucketExists(ctx,minioClient,bucket)){
            copy(ctx,minioClient,bucket,target,source,contentType)
        }
        return nil
    }

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}

//connect minio
func minioInit() * Client {
	// Initialize minio client object.
	minioClient, err := minio.New(endpoint, &minio.Options{
		Creds:  credentials.NewStaticV4(accessKeyID, secretAccessKey, ""),
		// Secure: useSSL,  // http do not need ssl
	})
	if err != nil {
		log.Fatalln(err)
	}

	log.Printf("%#v\n", minioClient) // minioClient is now set up
    return minioClient
}
//bucket exists
func bucketExists(ctx Context, client *Client, bucket string) bool {
	exists, errBucketExists := client.BucketExists(ctx, bucket)
	if errBucketExists != nil {
		log.Fatalln(errBucketExists)
	}
	log.Printf("%#V\n",exists)
    return exists
}

//copy file to minio
func copy(ctx Context, client *Client ,bucket, target,source, filetype string) {
	info, err := client.FPutObject(ctx, bucket, target, source, minio.PutObjectOptions{ContentType: filetype})
    if err != nil {
        log.Fatalln(err)
    }

    log.Printf("Successfully uploaded %s of size %d\n", target, info.Size)
}
