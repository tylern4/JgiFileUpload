# JgiFileUpload
 Upload files to NERSC filesystems using rancher2


```
docker build -t jgiuploader -f python3-alpine.dockerfile .
```

```
docker run --rm -it -p 80:80 jgiuploader
```