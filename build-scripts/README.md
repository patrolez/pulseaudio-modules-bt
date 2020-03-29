## Usage after getting files

1. Run packages building within Docker

```shell
cd build-scripts
./build.bash ubuntu-eoan
```

2. Expect new `./dist` directory with packages.
3. [Optional] Remove `tmp.remove.*` Docker Image(s) or if you are know what are you doing do `sudo docker system prune`.

## Concept to add new kind of releases

1. Create own `Dockerfile` recipe and name it:
 
>  *\<release-name\>*`.`*Dockerfile*

2. Ensure that your recipe finally would place packages inside Docker Image in `/dist` directory
3. `build.bash` will take care of anything else, *but not cleaning-up Docker Image as it is barely possible when Image has many layers and if it would be used in some automated build system, so deleting layers also means loosing the "cache"*.
