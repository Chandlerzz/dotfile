// -b --bucket buckect name
// -c --config config file
// -s --source source path
// -t --target target path
package main

import (
    "os"
	"log"
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
		// &cli.StringFlag{
		// 	Name:    "config",
		// 	Aliases: []string{"c"},
		// 	Usage:   "Load configuration from `FILE`",
		// },
		&cli.StringFlag{
			Name:    "bucket",
			Aliases: []string{"b"},
			Usage:   "bucket name",
			Required: true,
		},
		&cli.StringFlag{
			Name:    "source file",
			Aliases: []string{"s"},
			Usage:   "source file name",
		},
		&cli.StringFlag{
			Name:    "contentType",
			Aliases: []string{"c"},
			Usage:   "contentType",
		},
		&cli.StringFlag{
			Name:    "target file",
			Aliases: []string{"t"},
			Usage:   "target file name",
		},
	},
	    Name: "minio_client",
	    Usage: "minio client for chandler",
	}
	app.Action = func (c *cli.Context) error {
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
