# JgiFileUpload
 Upload files to NERSC filesystems using rancher2


```
docker build -t jgiuploader -f python3.8-alpine3.11.dockerfile .
```

```
docker run --rm -it -p 80:80 jgiuploader
```