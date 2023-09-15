# MetaboliteAnnotationDocker
Docker container for annotating metabolites

To build the container:

`docker build -t testanno1 -f ./dockerfile`

To run the container mounting data to analyze and databases in the media/ folder:

`docker run -it -v ./:/media/ [IMAGE_ID] bash`

Once inside can run `R`, load `metid`.

## TODO

Add database files?
Add internal scripts so users can run a script with data in file structure and get results
